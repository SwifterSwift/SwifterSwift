// NSAttributedString+BoldedTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSAttributedStringBoldedTests {
    private static func font(of text: NSAttributedString, at location: Int) throws -> NSFont {
        try #require(text.attribute(.font, at: location, effectiveRange: nil) as? NSFont)
    }

    private static func namedFont(_ name: String, _ size: CGFloat) throws -> NSFont {
        try #require(NSFont(name: name, size: size))
    }

    @Test(arguments: [
        ("Helvetica", 15.0, "Helvetica-Bold"), ("Helvetica-Oblique", 15.0, "Helvetica-BoldOblique"),
        ("Georgia", 20.0, "Georgia-Bold"), ("TimesNewRomanPSMT", 18.0, "TimesNewRomanPS-BoldMT"),
        ("Menlo-Regular", 11.0, "Menlo-Bold"), ("Menlo-Italic", 9.0, "Menlo-BoldItalic")
    ])
    func keepsTheFamilySizeAndOtherTraits(_ name: String, _ size: Double, _ expectedName: String) throws {
        let original = try Self.namedFont(name, size)
        let text = NSAttributedString(string: "Hello", attributes: [.font: original])
        let bold = try Self.font(of: text.bolded(), at: 0)
        #expect(bold.fontName == expectedName)
        #expect(bold.pointSize == original.pointSize)
        #expect(bold.familyName == original.familyName)
        #expect(bold.fontDescriptor.symbolicTraits.contains(.bold))
        let italic = original.fontDescriptor.symbolicTraits.contains(.italic)
        #expect(bold.fontDescriptor.symbolicTraits.contains(.italic) == italic)
    }

    @Test
    func convertsEachRunSeparately() throws {
        // The legacy implementation used the size of the first character for every run, in the bold system font.
        let text = NSMutableAttributedString(string: "Big", attributes: [.font: try Self.namedFont("Georgia", 30)])
        text.append(NSAttributedString(string: "small", attributes: [.font: try Self.namedFont("Menlo-Regular", 9)]))
        let result = text.bolded()
        #expect(try Self.font(of: result, at: 0).fontName == "Georgia-Bold")
        #expect(try Self.font(of: result, at: 0).pointSize == 30)
        #expect(try Self.font(of: result, at: 3).fontName == "Menlo-Bold")
        #expect(try Self.font(of: result, at: 3).pointSize == 9)
    }

    @Test
    func boldsTheDefaultFontForTextWithoutAFont() throws {
        let text = NSMutableAttributedString(string: "Hello ", attributes: [.font: try Self.namedFont("Georgia", 20)])
        text.append(NSAttributedString(string: "world"))
        let result = text.bolded()
        let fallback = try Self.font(of: result, at: 6)
        #expect(fallback.fontDescriptor.symbolicTraits.contains(.bold))
        #expect(fallback.pointSize == NSFont.systemFontSize)
        #expect(fallback.familyName == NSFont.systemFont(ofSize: NSFont.systemFontSize).familyName)

        let custom = NSAttributedString(string: "code").bolded(defaultFont: try Self.namedFont("Menlo-Regular", 11))
        #expect(try Self.font(of: custom, at: 0).fontName == "Menlo-Bold")
        #expect(try Self.font(of: custom, at: 0).pointSize == 11)
    }

    @Test
    func keepsFontsThatAreAlreadyBold() throws {
        let fonts = [
            NSFont.boldSystemFont(ofSize: 12), try Self.namedFont("Helvetica-Bold", 14),
            NSFont.preferredFont(forTextStyle: .headline)
        ]
        for font in fonts {
            let text = NSAttributedString(string: "Hello", attributes: [.font: font])
            #expect(try Self.font(of: text.bolded(), at: 0) == font)
        }
    }

    @Test
    func keepsFontsWithoutABoldFace() throws {
        let fonts = [
            try Self.namedFont("Zapfino", 11), try Self.namedFont("Apple Color Emoji", 14),
            NSFont.systemFont(ofSize: 20, weight: .light)
        ]
        for font in fonts {
            let text = NSAttributedString(string: "Hi", attributes: [.font: font])
            #expect(try Self.font(of: text.bolded(), at: 0) == font)
        }
    }

    @Test
    func keepsOtherAttributesAndTheOriginal() throws {
        let original = NSAttributedString(
            string: "Hello",
            attributes: [.font: try Self.namedFont("Helvetica", 12), .foregroundColor: NSColor.red, .kern: 2]
        )
        let result = original.bolded()
        let attributes = result.attributes(at: 0, effectiveRange: nil)
        #expect(attributes[.foregroundColor] as? NSColor == .red)
        #expect(attributes[.kern] as? Int == 2)
        #expect(try Self.font(of: original, at: 0).fontName == "Helvetica")
        #expect(result.string == original.string)
    }

    @Test
    func handlesAnEmptyStringAndEmoji() throws {
        #expect(NSAttributedString().bolded().length == 0)
        let emoji = NSAttributedString(string: "🧑‍💻 é", attributes: [.font: try Self.namedFont("Helvetica", 12)])
        var range = NSRange()
        let font = emoji.bolded().attribute(
            .font, at: 0, longestEffectiveRange: &range, in: NSRange(location: 0, length: emoji.length))
        #expect((font as? NSFont)?.fontName == "Helvetica-Bold")
        #expect(range == NSRange(location: 0, length: emoji.length))
    }
}
#endif
