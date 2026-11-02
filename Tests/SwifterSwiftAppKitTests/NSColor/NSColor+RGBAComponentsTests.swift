// NSColor+RGBAComponentsTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorRGBAComponentsTests {
    @Test(
        arguments: [
            (NSColor.red, 1.0, 0.0, 0.0),
            (NSColor.green, 0.0, 1.0, 0.0),
            (NSColor.blue, 0.0, 0.0, 1.0),
            (NSColor.black, 0.0, 0.0, 0.0),
            (NSColor.white, 1.0, 1.0, 1.0),
            (NSColor(srgbRed: 0.25, green: 0.5, blue: 0.75, alpha: 1), 0.25, 0.5, 0.75)
        ] as [(NSColor, CGFloat, CGFloat, CGFloat)])
    func returnsSRGBComponents(of color: NSColor, red: CGFloat, green: CGFloat, blue: CGFloat) throws {
        let components = try #require(color.rgbaComponents)
        #expect(components.red == red)
        #expect(components.green == green)
        #expect(components.blue == blue)
        #expect(components.alpha == 1)
    }

    @Test
    func convertsGrayscaleColorsInsteadOfRaising() throws {
        // `NSColor(white:alpha:)` is a grayscale color, so reading `redComponent` on it directly raises.
        let components = try #require(NSColor(white: 0.5, alpha: 0.2).rgbaComponents)
        #expect(abs(components.red - 0.5) < 0.000_001)
        #expect(components.red == components.green && components.green == components.blue)
        #expect(abs(components.alpha - 0.2) < 0.000_001)
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let components = try #require(NSColor.red.withAlphaComponent(0.25).rgbaComponents)
        #expect(components.alpha == 0.25)
    }

    @Test
    func readsByteValuesExactly() throws {
        let components = try #require(NSColor(srgbRed: 0x12 / 255, green: 0xFF / 255, blue: 0, alpha: 1).rgbaComponents)
        #expect((components.red * 255).rounded() == 0x12)
    }

    @Test(arguments: [
        NSColor.labelColor, .controlAccentColor, .windowBackgroundColor, .systemBlue, .selectedContentBackgroundColor
    ])
    func convertsCatalogColorsInsteadOfRaising(_ color: NSColor) throws {
        let components = try #require(color.rgbaComponents)
        #expect((0...1).contains(components.red))
        #expect((0...1).contains(components.alpha))
    }

    @Test
    func resolvesDynamicColorsWithTheCurrentDrawingAppearance() throws {
        let light = try #require(NSAppearance(named: .aqua))
        let dark = try #require(NSAppearance(named: .darkAqua))
        var lightComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)?
        var darkComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)?
        light.performAsCurrentDrawingAppearance { lightComponents = NSColor.textColor.rgbaComponents }
        dark.performAsCurrentDrawingAppearance { darkComponents = NSColor.textColor.rgbaComponents }
        #expect(try #require(lightComponents).red == 0)
        #expect(try #require(darkComponents).red == 1)
    }

    @Test
    func clipsWideGamutColorsToSRGB() throws {
        let components = try #require(NSColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1).rgbaComponents)
        #expect(components.red == 1)
        #expect((0...1).contains(components.green))
        #expect((0...1).contains(components.blue))
    }

    @Test
    func convertsCMYKColors() throws {
        let cyan = NSColor(deviceCyan: 1, magenta: 0, yellow: 0, black: 0, alpha: 1)
        let components = try #require(cyan.rgbaComponents)
        #expect(components.blue > components.red)
        #expect((0...1).contains(components.red))
    }

    @Test
    func returnsNilForPatternColors() {
        let pattern = NSColor(patternImage: NSImage(size: NSSize(width: 2, height: 2)))
        #expect(pattern.rgbaComponents == nil)
    }
}
#endif
