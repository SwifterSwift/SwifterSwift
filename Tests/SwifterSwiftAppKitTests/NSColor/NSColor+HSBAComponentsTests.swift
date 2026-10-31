// NSColor+HSBAComponentsTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorHSBAComponentsTests {
    @Test(
        arguments: [
            (0x00FF00, 120.0, 100.0, 100.0),
            (0x0000FF, 240.0, 100.0, 100.0),
            (0x000000, 0.0, 0.0, 0.0),
            (0xFFFFFF, 0.0, 0.0, 100.0),
            (0x123456, 210.0, 79.0, 34.0),
            (0xFCA864, 27.0, 60.0, 99.0),
            (0x1F2D3C, 211.0, 48.0, 24.0)
        ] as [(Int, CGFloat, CGFloat, CGFloat)])
    func returnsHueSaturationAndBrightness(
        hex: Int,
        degrees: CGFloat,
        saturation: CGFloat,
        brightness: CGFloat
    ) throws {
        let color = NSColor(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
        let components = try #require(color.hsbaComponents)
        #expect((components.hue * 360).rounded() == degrees)
        #expect((components.saturation * 100).rounded() == saturation)
        #expect((components.brightness * 100).rounded() == brightness)
        #expect(components.alpha == 1)
    }

    @Test
    func reportsZeroRatherThanOneForRed() throws {
        // AppKit's own `getHue` reports a full turn (1.0) for pure red.
        let components = try #require(NSColor.red.hsbaComponents)
        #expect(components.hue == 0)
        #expect(components.saturation == 1)
        #expect(components.brightness == 1)
    }

    @Test(arguments: [NSColor.black, .white, .gray, .labelColor, .controlAccentColor, .windowBackgroundColor])
    func convertsGrayscaleAndCatalogColorsInsteadOfRaising(_ color: NSColor) throws {
        let components = try #require(color.hsbaComponents)
        #expect((0..<1).contains(components.hue))
        #expect((0...1).contains(components.saturation))
        #expect((0...1).contains(components.brightness))
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let components = try #require(NSColor(white: 1, alpha: 0.4).hsbaComponents)
        #expect(abs(components.alpha - 0.4) < 0.000_001)
        #expect(components.saturation == 0)
    }

    @Test
    func keepsHuesJustBelowAFullTurn() throws {
        let components = try #require(NSColor(srgbRed: 1, green: 0, blue: 0.01, alpha: 1).hsbaComponents)
        #expect(components.hue > 0.99 && components.hue < 1)
    }

    @Test
    func returnsNilForPatternColors() {
        let pattern = NSColor(patternImage: NSImage(size: NSSize(width: 2, height: 2)))
        #expect(pattern.hsbaComponents == nil)
    }
}
#endif
