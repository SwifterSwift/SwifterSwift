// NSColor+LightenedTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorLightenedTests {
    @Test(
        arguments: [
            (NSColor.blue, 0.25, 0.25, 0.25, 1.0),
            (NSColor.black, 0.5, 0.5, 0.5, 0.5),
            (NSColor.white, 0.5, 1.0, 1.0, 1.0),
            (NSColor(srgbRed: 0.2, green: 0.4, blue: 0.6, alpha: 1), 0.5, 0.6, 0.7, 0.8)
        ] as [(NSColor, CGFloat, CGFloat, CGFloat, CGFloat)])
    func movesEachComponentTowardWhite(
        _ color: NSColor,
        amount: CGFloat,
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) throws {
        let lighter = try #require(color.lightened(by: amount)?.usingColorSpace(.sRGB))
        #expect(abs(lighter.redComponent - red) < 0.000_001)
        #expect(abs(lighter.greenComponent - green) < 0.000_001)
        #expect(abs(lighter.blueComponent - blue) < 0.000_001)
    }

    @Test(arguments: [0, -1, -.infinity, .nan] as [CGFloat])
    func keepsTheColorForZeroNegativeOrNaNAmounts(_ amount: CGFloat) throws {
        let color = NSColor(srgbRed: 0.2, green: 0.4, blue: 0.6, alpha: 1)
        let result = try #require(color.lightened(by: amount)?.usingColorSpace(.sRGB))
        #expect(result.redComponent == 0.2 && result.greenComponent == 0.4 && result.blueComponent == 0.6)
    }

    @Test(arguments: [1, 2, .infinity] as [CGFloat])
    func returnsWhiteForAmountsOfOneOrMore(_ amount: CGFloat) throws {
        let result = try #require(NSColor.systemRed.lightened(by: amount)?.usingColorSpace(.sRGB))
        #expect(result.redComponent == 1 && result.greenComponent == 1 && result.blueComponent == 1)
    }

    @Test
    func keepsTheHue() throws {
        // Adding the same amount to every component would clip red here and shift the hue.
        let color = NSColor(srgbRed: 0.9, green: 0.5, blue: 0.1, alpha: 1)
        let lighter = try #require(color.lightened(by: 0.5)?.usingColorSpace(.sRGB))
        #expect(abs(lighter.hueComponent - color.hueComponent) < 0.000_001)
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let lighter = try #require(NSColor.red.withAlphaComponent(0.3).lightened(by: 0.5))
        #expect(lighter.alphaComponent == 0.3)
    }

    @Test(arguments: [NSColor.white, .black, .labelColor, .controlAccentColor])
    func convertsGrayscaleAndCatalogColorsInsteadOfRaising(_ color: NSColor) {
        #expect(color.lightened(by: 0.2) != nil)
    }

    @Test
    func returnsNilForPatternColors() {
        #expect(NSColor(patternImage: NSImage(size: NSSize(width: 2, height: 2))).lightened(by: 0.2) == nil)
    }
}
#endif
