// NSFont+ItalicTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSFontItalicTests {
    @Test(arguments: [9, 13, 30] as [CGFloat])
    func addsTheItalicTraitAndKeepsTheSize(_ size: CGFloat) {
        let font = NSFont.systemFont(ofSize: size).italic
        #expect(font.fontDescriptor.symbolicTraits.contains(.italic))
        #expect(font.pointSize == size)
    }

    @Test
    func keepsTheBoldTrait() {
        // `withSymbolicTraits(.italic)` on its own replaces the traits and drops bold.
        let traits = NSFont.boldSystemFont(ofSize: 13).italic.fontDescriptor.symbolicTraits
        #expect(traits.contains(.italic))
        #expect(traits.contains(.bold))
    }

    @Test(arguments: [("Helvetica", "Helvetica-Oblique"), ("Helvetica-Bold", "Helvetica-BoldOblique")])
    func keepsTheFamily(name: String, expected: String) throws {
        let font = try #require(NSFont(name: name, size: 20))
        #expect(font.italic.fontName == expected)
        #expect(font.italic.pointSize == 20)
    }

    @Test
    func isIdempotent() {
        let italic = NSFont.systemFont(ofSize: 13).italic
        #expect(italic.italic.fontName == italic.fontName)
    }

    @Test
    func returnsTheFontUnchangedWhenItsFamilyHasNoItalicFace() throws {
        let font = try #require(NSFont(name: "Papyrus", size: 12))
        #expect(font.italic == font)
    }
}
#endif
