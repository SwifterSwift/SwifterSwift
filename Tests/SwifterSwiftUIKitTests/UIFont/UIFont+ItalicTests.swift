// UIFont+ItalicTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIFontItalicTests {
    @Test(arguments: [9, 17, 30] as [CGFloat])
    func addsTheItalicTraitAndKeepsTheSize(_ size: CGFloat) {
        let font = UIFont.systemFont(ofSize: size).italic
        #expect(font.fontDescriptor.symbolicTraits.contains(.traitItalic))
        #expect(font.pointSize == size)
    }

    @Test
    func keepsTheBoldTrait() {
        // `withSymbolicTraits(.traitItalic)` on its own replaces the traits and drops bold.
        let traits = UIFont.boldSystemFont(ofSize: 17).italic.fontDescriptor.symbolicTraits
        #expect(traits.contains(.traitItalic))
        #expect(traits.contains(.traitBold))
    }

    @Test(arguments: [("Helvetica", "Helvetica-Oblique"), ("Helvetica-Bold", "Helvetica-BoldOblique")])
    func keepsTheFamily(name: String, expected: String) throws {
        let font = try #require(UIFont(name: name, size: 20))
        #expect(font.italic.fontName == expected)
        #expect(font.italic.pointSize == 20)
    }

    #if !os(watchOS)
    @Test
    func keepsTheTextStyleSize() {
        let body = UIFont.preferredFont(
            forTextStyle: .body, compatibleWith: UITraitCollection(preferredContentSizeCategory: .large))
        #expect(body.italic.pointSize == body.pointSize)
        if #available(tvOS 27, *) {
            #expect(body.italic.fontDescriptor.symbolicTraits.contains(.traitItalic))
        } else {
            // Text-style fonts on tvOS 26 can't take the trait, so the font is returned unchanged.
            #expect(body.italic == body)
        }
    }
    #endif

    @Test
    func isIdempotent() {
        let italic = UIFont.systemFont(ofSize: 17).italic
        #expect(italic.italic.fontName == italic.fontName)
    }

    @Test(.enabled(if: UIFont(name: "Papyrus", size: 12) != nil, "Papyrus isn't installed on every platform"))
    func returnsTheFontUnchangedWhenItsFamilyHasNoItalicFace() throws {
        let font = try #require(UIFont(name: "Papyrus", size: 12))
        #expect(font.italic.fontName == font.fontName)
    }
}
#endif
