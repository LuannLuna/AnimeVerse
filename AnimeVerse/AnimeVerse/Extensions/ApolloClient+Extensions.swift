@preconcurrency
import Apollo
import AnilistAPI
import Foundation

extension ApolloClient {
    final class RequestHolder: @unchecked Sendable {
        var request: Cancellable?
    }

    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue = .main
    ) -> AsyncThrowingStream<GraphQLResult<Query.Data>, Error> {
        let holder = RequestHolder()

        return AsyncThrowingStream { continuation in
            holder.request = fetch(
                query: query,
                cachePolicy: cachePolicy,
                contextIdentifier: contextIdentifier,
                queue: queue
            ) { response in
                switch response {
                case .success(let result):
                    continuation.yield(result)
                    if result.isFinalForCachePolicy(cachePolicy) {
                        continuation.finish()
                    }
                case .failure(let error):
                    continuation.finish(throwing: error)
                }
            }
            continuation.onTermination = { @Sendable _ in
                holder.request?.cancel()
            }
        }
    }

    @discardableResult
    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Query.Data> {
        return try await withTaskCancellationContinuation { continuation in
            return self.fetch(
                query: query,
                cachePolicy: cachePolicy,
                contextIdentifier: contextIdentifier,
                queue: queue
            ) { result in
                continuation.resume(returning: result)
            }
        }
    }

    @discardableResult
    public func perform<Mutation: GraphQLMutation>(
        mutation: Mutation,
        publishResultToStore: Bool = true,
        queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Mutation.Data> {
        return try await withTaskCancellationContinuation { continuation in
            return self.perform(
                mutation: mutation,
                publishResultToStore: publishResultToStore,
                queue: queue
            ) { result in
                continuation.resume(returning: result)
            }
        }
    }
}

extension GraphQLResult {
    func isFinalForCachePolicy(_ cachePolicy: CachePolicy) -> Bool {
        switch cachePolicy {
        case .returnCacheDataElseFetch:
            return true
        case .fetchIgnoringCacheData:
            return source == .server
        case .fetchIgnoringCacheCompletely:
            return source == .server
        case .returnCacheDataDontFetch:
            return source == .cache
        case .returnCacheDataAndFetch:
            return source == .server
        }
    }
}

private
extension ApolloClient {
    final class CancelStateHolder: @unchecked Sendable {
        var state: ManagedBuffer<(isCancelled: Bool, task: Cancellable?), os_unfair_lock>

        init() {
            self.state = ManagedBuffer.create(minimumCapacity: .zero, makingHeaderWith: { _ in
                (isCancelled: false, task: nil)
            })
        }
    }

    func withTaskCancellationContinuation<T>(
        _ body: (CheckedContinuation<(Result<GraphQLResult<T>, Error>), Never>) -> Apollo.Cancellable
    ) async throws -> GraphQLResult<T> {
        let holder = CancelStateHolder()
        holder.state = makeState()

        let result: (Result<GraphQLResult<T>, Error>) = await withTaskCancellationHandler {
            return await withCheckedContinuation { continuation in
                let task = body(continuation)
                activate(state: holder.state, task: task)
            }
        } onCancel: {
            cancel(state: holder.state)
        }
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }

    func makeState() -> Swift.ManagedBuffer<(isCancelled: Swift.Bool, task: Apollo.Cancellable?), Darwin.os_unfair_lock> {
        ManagedBuffer<(isCancelled: Bool, task: Apollo.Cancellable?), os_unfair_lock>.create(minimumCapacity: 1) { buffer in
            buffer.withUnsafeMutablePointerToElements { $0.initialize(to: os_unfair_lock()) }
            return (isCancelled: false, task: nil)
        }
    }

    func cancel(state: Swift.ManagedBuffer<(isCancelled: Swift.Bool, task: Apollo.Cancellable?), Darwin.os_unfair_lock>) {
        state.withUnsafeMutablePointers { state, lock in
            os_unfair_lock_lock(lock)
            let task = state.pointee.task
            state.pointee = (isCancelled: true, task: nil)
            os_unfair_lock_unlock(lock)
            task?.cancel()
        }
    }

    func activate(state: Swift.ManagedBuffer<(isCancelled: Swift.Bool, task: Apollo.Cancellable?), Darwin.os_unfair_lock>, task: Apollo.Cancellable) {
        state.withUnsafeMutablePointers { state, lock in
            os_unfair_lock_lock(lock)
            if state.pointee.task != nil {
                fatalError("Cannot activate twice")
            }
            if state.pointee.isCancelled {
                os_unfair_lock_unlock(lock)
                task.cancel()
            } else {
                state.pointee = (isCancelled: false, task: task)
                os_unfair_lock_unlock(lock)
            }
        }
    }
}

extension ApolloClient: @unchecked @retroactive Sendable {}
extension GraphQLResult: @unchecked @retroactive Sendable{}
