import SwiftUI

struct HTMLText: View {
    private enum Constants {
        static let defaultFont: Font = .body
    }
    let html: String
    
    init(_ html: String) {
        self.html = html
    }
    
    var attributedString: AttributedString {
        do {
            let data = Data(html.utf8)
            if let nsAttributedString = try? NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            ) {
                return try AttributedString(nsAttributedString, including: \.foundation)
            }
        } catch {
            print("Error converting HTML to AttributedString: \(error)")
        }
        return AttributedString(html)
    }
    
    var body: some View {
        Text(attributedString)
            .font(Constants.defaultFont)
    }
}

#Preview("HTML Text Examples") {
    VStack(alignment: .leading, spacing: 20) {
        HTMLText("Regular text without HTML")
        
        HTMLText("<b>Bold text</b> and <i>italic text</i>")
        
        HTMLText("Text with <a href=\"https://example.com\">hyperlink</a>")
        
        HTMLText("""
            <p>Paragraph with <b>mixed</b> <i>formatting</i></p>
            <p>Second paragraph with a <br>line break</p>
            <ul>
                <li>List item 1</li>
                <li>List item 2</li>
            </ul>
        """)
        
        HTMLText("""
            <div style="color: blue;">Styled text</div>
            <p style="font-size: 18px;">Different size text</p>
        """)
    }
    .padding()
}
