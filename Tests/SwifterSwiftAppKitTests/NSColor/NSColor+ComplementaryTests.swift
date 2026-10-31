// NSColor+ComplementaryTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorComplementaryTests {
    @Test(
        arguments: [
            (0xFF0000, 0x00FFFF),
            (0x00FF00, 0xFF00FF),
            (0x0000FF, 0xFFFF00),
            (0x123456, 0x563412),
            (0xFCA864, 0x64B8FC),
            (0x000000, 0x000000),
            (0xFFFFFF, 0xFFFFFF),
            (0x808080, 0x808080)
        ] as [(Int, Int)])
    func rotatesTheHueByHalfATurn(hex: Int, expected: Int) throws {
        let color = NSColor(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
        let complement = try #require(color.complementary?.usingColorSpace(.sRGB))
        #expect(Int((complement.redComponent * 255).rounded()) == (expected >> 16) & 0xFF)
        #expect(Int((complement.greenComponent * 255).rounded()) == (expected >> 8) & 0xFF)
        #expect(Int((complement.blueComponent * 255).rounded()) == expected & 0xFF)
    }

    @Test
    func keepsGraysUnchanged() throws {
        // SwifterSwift 8 returned #DCDCDC for 50% gray and white for black.
        let gray = try #require(NSColor.gray.complementary?.usingColorSpace(.sRGB))
        #expect(gray.redComponent == 0.5 && gray.greenComponent == 0.5 && gray.blueComponent == 0.5)
        let black = try #require(NSColor.black.complementary?.usingColorSpace(.sRGB))
        #expect(black.redComponent == 0 && black.greenComponent == 0 && black.blueComponent == 0)
    }

    @Test
    func keepsSaturationBrightnessAndAlpha() throws {
        let color = NSColor(srgbRed: 0.9, green: 0.5, blue: 0.1, alpha: 0.3)
        let complement = try #require(color.complementary?.usingColorSpace(.sRGB))
        #expect(abs(complement.saturationComponent - color.saturationComponent) < 0.000_001)
        #expect(abs(complement.brightnessComponent - color.brightnessComponent) < 0.000_001)
        #expect(abs(abs(complement.hueComponent - color.hueComponent) - 0.5) < 0.000_001)
        #expect(complement.alphaComponent == 0.3)
    }

    @Test
    func isItsOwnInverse() throws {
        let color = NSColor(srgbRed: 0.2, green: 0.6, blue: 0.4, alpha: 1)
        let twice = try #require(color.complementary?.complementary?.usingColorSpace(.sRGB))
        #expect(abs(twice.redComponent - 0.2) < 0.000_001)
        #expect(abs(twice.greenComponent - 0.6) < 0.000_001)
        #expect(abs(twice.blueComponent - 0.4) < 0.000_001)
    }

    @Test(arguments: [NSColor.labelColor, .controlAccentColor, .white])
    func convertsCatalogAndGrayscaleColorsInsteadOfRaising(_ color: NSColor) {
        #expect(color.complementary != nil)
    }

    @Test
    func returnsNilForPatternColors() {
        #expect(NSColor(patternImage: NSImage(size: NSSize(width: 2, height: 2))).complementary == nil)
    }
}
#endif
