import Foundation

extension DateComponents: @retroactive Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        guard let lhsDate = Calendar.current.date(from: lhs),
              let rhsDate = Calendar.current.date(from: rhs) else {
            // If either cannot be converted, treat lhs as not less than rhs
            return false
        }
        return lhsDate < rhsDate
    }

    public static func == (lhs: DateComponents, rhs: DateComponents) -> Bool {
        guard let lhsDate = Calendar.current.date(from: lhs),
              let rhsDate = Calendar.current.date(from: rhs) else {
            return false
        }
        return lhsDate == rhsDate
    }
}

extension Date {
    /// Converts a `Date` to `DateComponents` using the given calendar and components.
    /// - Parameters:
    ///   - calendar: The calendar to use (default is `.current`).
    ///   - components: The set of components to extract.
    /// - Returns: A `DateComponents` instance containing the requested components.
    func toDateComponents(using calendar: Calendar = .current,
                          components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]) -> DateComponents {
        return calendar.dateComponents(components, from: self)
    }
}
