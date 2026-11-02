// NSAttributedString+ItalicizedTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSAttributedStringItalicizedTests {
    private static func font(of text: NSAttributedString, at location: Int) throws -> NSFont {
        try #require(text.attribute(.font, at: location, effectiveRange: nil) as? NSFont)
    }

    private static func namedFont(_ name: String, _ size: CGFloat) throws -> NSFont {
        try #require(NSFont(name: name, size: size))
    }

    @Test(arguments: [
        ("Helvetica", 15.0, "Helvetica-Oblique"), ("Helvetica-Bold", 15.0, "Helvetica-BoldOblique"),
        ("Georgia", 20.0, "Georgia-Italic"), ("TimesNewRomanPSMT", 18.0, "TimesNewRomanPS-ItalicMT"),
        ("Menlo-Regular", 11.0, "Menlo-Italic"), ("Menlo-Bold", 9.0, "Menlo-BoldItalic")
    ])
    func keepsTheFamilySizeAndOtherTraits(_ name: String, _ size: Double, _ expectedName: String) throws {
        let original = try Self.namedFont(name, size)
        let text = NSAttributedString(string: "Hello", attributes: [.font: original])
        let italic = try Self.font(of: text.italicized(), at: 0)
        #expect(italic.fontName == expectedName)
        #expect(italic.pointSize == original.pointSize)
        #expect(italic.familyName == original.familyName)
        #expect(italic.fontDescriptor.symbolicTraits.contains(.italic))
        let bold = original.fontDescriptor.symbolicTraits.contains(.bold)
        #expect(italic.fontDescriptor.symbolicTraits.contains(.bold) == bold)
    }

    @Test
    func convertsEachRunSeparately() throws {
        let text = NSMutableAttributedString(string: "Big", attributes: [.font: try Self.namedFont("Georgia", 30)])
        text.append(NSAttributedString(string: "small", attributes: [.font: try Self.namedFont("Menlo-Regular", 9)]))
        let result = text.italicized()
        #expect(try Self.font(of: result, at: 0).fontName == "Georgia-Italic")
        #expect(try Self.font(of: result, at: 0).pointSize == 30)
        #expect(try Self.font(of: result, at: 3).fontName == "Menlo-Italic")
        #expect(try Self.font(of: result, at: 3).pointSize == 9)
    }

    @Test
    func italicizesTheDefaultFontForTextWithoutAFont() throws {
        let text = NSMutableAttributedString(string: "Hello ", attributes: [.font: try Self.namedFont("Georgia", 20)])
        text.append(NSAttributedString(string: "world"))
        let result = text.italicized()
        let fallback = try Self.font(of: result, at: 6)
        #expect(fallback.fontDescriptor.symbolicTraits.contains(.italic))
        #expect(fallback.pointSize == NSFont.systemFontSize)
        #expect(fallback.familyName == NSFont.systemFont(ofSize: NSFont.systemFontSize).familyName)

        let custom = NSAttributedString(string: "code").italicized(defaultFont: try Self.namedFont("Menlo-Regular", 11))
        #expect(try Self.font(of: custom, at: 0).fontName == "Menlo-Italic")
    }

    @Test
    func keepsFontsThatAreAlreadyItalic() throws {
        for font in [try Self.namedFont("Helvetica-Oblique", 14), try Self.namedFont("Georgia-BoldItalic", 12)] {
            let text = NSAttributedString(string: "Hello", attributes: [.font: font])
            #expect(try Self.font(of: text.italicized(), at: 0) == font)
        }
    }

    @Test
    func keepsFontsWithoutAnItalicFace() throws {
        for font in [try Self.namedFont("Zapfino", 11), try Self.namedFont("Apple Color Emoji", 14)] {
            let text = NSAttributedString(string: "Hi", attributes: [.font: font])
            #expect(try Self.font(of: text.italicized(), at: 0) == font)
        }
    }

    @Test
    func keepsOtherAttributesAndTheOriginal() throws {
        let original = NSAttributedString(
            string: "Hello",
            attributes: [.font: try Self.namedFont("Helvetica", 12), .underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        let result = original.italicized()
        #expect(
            result.attribute(.underlineStyle, at: 0, effectiveRange: nil) as? Int == NSUnderlineStyle.single.rawValue)
        #expect(try Self.font(of: original, at: 0).fontName == "Helvetica")
        #expect(result.string == original.string)
    }

    @Test
    func handlesAnEmptyString() {
        #expect(NSAttributedString().italicized().length == 0)
    }
}
#endif
