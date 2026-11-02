// UILabel+InitTextTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UILabelInitTextTests {
    @Test(arguments: [UIFont.TextStyle.body, .headline, .caption1, .title1])
    func usesPreferredFontForStyle(_ style: UIFont.TextStyle) {
        let label = UILabel(text: "Hello", style: style)
        #expect(label.font == UIFont.preferredFont(forTextStyle: style))
    }

    @Test
    func adjustsFontForContentSizeCategory() {
        let label = UILabel(text: "Hello", style: .body)
        #expect(label.adjustsFontForContentSizeCategory)
    }

    @Test(arguments: ["Hello world", "", "Ça va? 👋🏽", "e\u{301}", "🇯🇵 こんにちは"])
    func setsText(_ text: String) {
        let label = UILabel(text: text, style: .body)
        #expect(label.text == text)
    }
}
#endif
