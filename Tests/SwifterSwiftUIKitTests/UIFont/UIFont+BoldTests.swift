// UIFont+BoldTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIFontBoldTests {
    @Test(arguments: [9, 17, 30] as [CGFloat])
    func addsTheBoldTraitAndKeepsTheSize(_ size: CGFloat) {
        let font = UIFont.systemFont(ofSize: size).bold
        #expect(font.fontDescriptor.symbolicTraits.contains(.traitBold))
        #expect(font.pointSize == size)
    }

    @Test
    func keepsTheItalicTrait() {
        // `withSymbolicTraits(.traitBold)` on its own replaces the traits and drops italic.
        let traits = UIFont.italicSystemFont(ofSize: 17).bold.fontDescriptor.symbolicTraits
        #expect(traits.contains(.traitBold))
        #expect(traits.contains(.traitItalic))
    }

    @Test(arguments: [("Helvetica", "Helvetica-Bold"), ("Helvetica-Oblique", "Helvetica-BoldOblique")])
    func keepsTheFamily(name: String, expected: String) throws {
        let font = try #require(UIFont(name: name, size: 20))
        #expect(font.bold.fontName == expected)
        #expect(font.bold.pointSize == 20)
    }

    #if !os(watchOS)
    @Test
    func keepsTheTextStyleSize() {
        let body = UIFont.preferredFont(
            forTextStyle: .body, compatibleWith: UITraitCollection(preferredContentSizeCategory: .large))
        #expect(body.bold.pointSize == body.pointSize)
        #expect(body.bold.fontDescriptor.symbolicTraits.contains(.traitBold))
    }
    #endif

    @Test
    func isIdempotent() {
        let bold = UIFont.systemFont(ofSize: 17).bold
        #expect(bold.bold.fontName == bold.fontName)
    }

    @Test(.enabled(if: UIFont(name: "Zapfino", size: 12) != nil, "Zapfino isn't installed on every platform"))
    func returnsTheFontUnchangedWhenItsFamilyHasNoBoldFace() throws {
        let font = try #require(UIFont(name: "Zapfino", size: 12))
        #expect(font.bold.fontName == font.fontName)
    }
}
#endif
