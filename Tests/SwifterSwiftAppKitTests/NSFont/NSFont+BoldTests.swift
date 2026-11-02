// NSFont+BoldTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSFontBoldTests {
    @Test(arguments: [9, 13, 30] as [CGFloat])
    func addsTheBoldTraitAndKeepsTheSize(_ size: CGFloat) {
        let font = NSFont.systemFont(ofSize: size).bold
        #expect(font.fontDescriptor.symbolicTraits.contains(.bold))
        #expect(font.pointSize == size)
    }

    @Test
    func keepsTheItalicTrait() throws {
        // `withSymbolicTraits(.bold)` on its own replaces the traits and drops italic.
        let system = NSFont.systemFont(ofSize: 13)
        let italic = try #require(NSFont(descriptor: system.fontDescriptor.withSymbolicTraits(.italic), size: 0))
        let traits = italic.bold.fontDescriptor.symbolicTraits
        #expect(traits.contains(.bold))
        #expect(traits.contains(.italic))
    }

    @Test(arguments: [("Helvetica", "Helvetica-Bold"), ("Helvetica-Oblique", "Helvetica-BoldOblique")])
    func keepsTheFamily(name: String, expected: String) throws {
        let font = try #require(NSFont(name: name, size: 20))
        #expect(font.bold.fontName == expected)
        #expect(font.bold.pointSize == 20)
    }

    @Test
    func isIdempotent() {
        let bold = NSFont.systemFont(ofSize: 13).bold
        #expect(bold.bold.fontName == bold.fontName)
    }

    @Test
    func returnsTheFontUnchangedWhenItsFamilyHasNoBoldFace() throws {
        let font = try #require(NSFont(name: "Zapfino", size: 12))
        #expect(font.bold == font)
    }
}
#endif
