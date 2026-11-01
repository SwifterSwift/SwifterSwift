// NSAttributedString+ItalicizedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct NSAttributedStringItalicizedTests {
    private static func font(of text: NSAttributedString, at location: Int) throws -> UIFont {
        try #require(text.attribute(.font, at: location, effectiveRange: nil) as? UIFont)
    }

    private static func namedFont(_ name: String, _ size: CGFloat) throws -> UIFont {
        try #require(UIFont(name: name, size: size))
    }

    @Test(arguments: [
        ("Helvetica", 15.0, "Helvetica-Oblique"), ("Helvetica-Bold", 15.0, "Helvetica-BoldOblique"),
        ("TimesNewRomanPSMT", 18.0, "TimesNewRomanPS-ItalicMT"),
        ("Menlo-Regular", 11.0, "Menlo-Italic"), ("Menlo-Bold", 9.0, "Menlo-BoldItalic")
    ])
    func keepsTheFamilySizeAndOtherTraits(_ name: String, _ size: Double, _ expectedName: String) throws {
        let original = try Self.namedFont(name, size)
        let text = NSAttributedString(string: "Hello", attributes: [.font: original])
        let italic = try Self.font(of: text.italicized(), at: 0)
        #expect(italic.fontName == expectedName)
        #expect(italic.pointSize == original.pointSize)
        #expect(italic.familyName == original.familyName)
        #expect(italic.fontDescriptor.symbolicTraits.contains(.traitItalic))
        let bold = original.fontDescriptor.symbolicTraits.contains(.traitBold)
        #expect(italic.fontDescriptor.symbolicTraits.contains(.traitBold) == bold)
    }

    @Test
    func italicizesSystemFontsAndKeepsTheirSize() throws {
        for font in [UIFont.systemFont(ofSize: 14), UIFont.boldSystemFont(ofSize: 22)] {
            let text = NSAttributedString(string: "Hello", attributes: [.font: font])
            let italic = try Self.font(of: text.italicized(), at: 0)
            #expect(italic.fontDescriptor.symbolicTraits.contains(.traitItalic))
            #expect(italic.pointSize == font.pointSize)
            #expect(italic.familyName == font.familyName)
            let bold = font.fontDescriptor.symbolicTraits.contains(.traitBold)
            #expect(italic.fontDescriptor.symbolicTraits.contains(.traitBold) == bold)
        }
    }

    @Test
    func convertsEachRunSeparately() throws {
        let text = NSMutableAttributedString(string: "Big", attributes: [.font: try Self.namedFont("Helvetica", 30)])
        text.append(NSAttributedString(string: "small", attributes: [.font: try Self.namedFont("Menlo-Regular", 9)]))
        let result = text.italicized()
        #expect(try Self.font(of: result, at: 0).fontName == "Helvetica-Oblique")
        #expect(try Self.font(of: result, at: 0).pointSize == 30)
        #expect(try Self.font(of: result, at: 3).fontName == "Menlo-Italic")
        #expect(try Self.font(of: result, at: 3).pointSize == 9)
    }

    @Test
    func italicizesTheDefaultFontForTextWithoutAFont() throws {
        let text = NSMutableAttributedString(string: "Hello ", attributes: [.font: try Self.namedFont("Helvetica", 20)])
        text.append(NSAttributedString(string: "world"))
        let result = text.italicized()
        let body = UIFont.preferredFont(forTextStyle: .body)
        let fallback = try Self.font(of: result, at: 6)
        if #available(tvOS 27, *) {
            #expect(fallback.fontDescriptor.symbolicTraits.contains(.traitItalic))
        } else {
            // Text-style fonts on tvOS 26 can't take the trait, so the default font is used unchanged.
            #expect(fallback == body)
        }
        #expect(fallback.pointSize == body.pointSize)
        #expect(fallback.familyName == body.familyName)

        let custom = NSAttributedString(string: "code").italicized(defaultFont: try Self.namedFont("Menlo-Regular", 11))
        #expect(try Self.font(of: custom, at: 0).fontName == "Menlo-Italic")
    }

    @Test
    func keepsFontsThatAreAlreadyItalic() throws {
        let fonts = [
            UIFont.italicSystemFont(ofSize: 12), try Self.namedFont("Helvetica-Oblique", 14),
            try Self.namedFont("TimesNewRomanPS-BoldItalicMT", 12)
        ]
        for font in fonts {
            let text = NSAttributedString(string: "Hello", attributes: [.font: font])
            #expect(try Self.font(of: text.italicized(), at: 0) == font)
        }
    }

    @Test
    func keepsFontsWithoutAnItalicFace() throws {
        // Not every platform ships both fonts (tvOS has no Zapfino), so test the ones that are installed.
        let fonts = [("Zapfino", 11.0), ("AppleColorEmoji", 14.0)].compactMap { UIFont(name: $0, size: $1) }
        #expect(!fonts.isEmpty)
        for font in fonts {
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
