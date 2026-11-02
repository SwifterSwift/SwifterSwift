// UITextField+SetPlaceholderColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextFieldSetPlaceholderColorTests {
    func color(of string: NSAttributedString?, at location: Int) -> UIColor? {
        guard let string, location < string.length else { return nil }
        return string.attribute(.foregroundColor, at: location, effectiveRange: nil) as? UIColor
    }

    @Test
    func colorsPlainPlaceholder() throws {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.setPlaceholderColor(.systemBlue)
        let placeholder = try #require(textField.attributedPlaceholder)
        #expect(placeholder.string == "Email")
        #expect(color(of: placeholder, at: 0) == .systemBlue)
        #expect(color(of: placeholder, at: placeholder.length - 1) == .systemBlue)
    }

    @Test
    func keepsOtherAttributes() throws {
        let textField = UITextField()
        let font = UIFont.systemFont(ofSize: 21, weight: .bold)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.font: font, .kern: 2, .foregroundColor: UIColor.systemRed]
        )
        textField.setPlaceholderColor(.systemGreen)
        let placeholder = try #require(textField.attributedPlaceholder)
        #expect(color(of: placeholder, at: 0) == .systemGreen)
        #expect(placeholder.attribute(.font, at: 0, effectiveRange: nil) as? UIFont == font)
        #expect(placeholder.attribute(.kern, at: 0, effectiveRange: nil) as? Int == 2)
    }

    @Test
    func colorsEveryRangeOfMixedPlaceholder() throws {
        let textField = UITextField()
        let mixed = NSMutableAttributedString(string: "Name ", attributes: [.foregroundColor: UIColor.systemRed])
        mixed.append(NSAttributedString(string: "(optional)", attributes: [.foregroundColor: UIColor.systemGray]))
        textField.attributedPlaceholder = mixed
        textField.setPlaceholderColor(.systemPurple)
        let placeholder = try #require(textField.attributedPlaceholder)
        #expect(color(of: placeholder, at: 0) == .systemPurple)
        #expect(color(of: placeholder, at: placeholder.length - 1) == .systemPurple)
    }

    @Test(arguments: ["👨‍👩‍👧‍👦 Family", "e\u{301}", "🇸🇾", "البريد"])
    func colorsWholeUnicodePlaceholder(_ text: String) throws {
        let textField = UITextField()
        textField.placeholder = text
        textField.setPlaceholderColor(.systemOrange)
        let placeholder = try #require(textField.attributedPlaceholder)
        #expect(placeholder.string == text)
        #expect(color(of: placeholder, at: 0) == .systemOrange)
        #expect(color(of: placeholder, at: placeholder.length - 1) == .systemOrange)
    }

    @Test
    func doesNothingWithoutPlaceholder() {
        let textField = UITextField()
        textField.setPlaceholderColor(.systemYellow)
        #expect(textField.attributedPlaceholder == nil)
        #expect(textField.placeholder == nil)
    }

    @Test
    func doesNothingWithEmptyPlaceholder() {
        let textField = UITextField()
        textField.placeholder = ""
        textField.setPlaceholderColor(.systemYellow)
        #expect(textField.placeholder?.isEmpty ?? true)
        #expect(textField.attributedPlaceholder?.length ?? 0 == 0)
    }

    @Test
    func colorsNewPlaceholderWhenCalledAgain() throws {
        let textField = UITextField()
        textField.placeholder = "Old"
        textField.setPlaceholderColor(.systemPink)
        textField.placeholder = "Much longer new placeholder"
        textField.setPlaceholderColor(.systemTeal)
        let placeholder = try #require(textField.attributedPlaceholder)
        #expect(placeholder.string == "Much longer new placeholder")
        #expect(color(of: placeholder, at: 0) == .systemTeal)
        #expect(color(of: placeholder, at: placeholder.length - 1) == .systemTeal)
    }
}
#endif
