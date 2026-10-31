// NSColor+DarkenedTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorDarkenedTests {
    @Test(
        arguments: [
            (NSColor.blue, 0.25, 0.0, 0.0, 0.75),
            (NSColor.white, 0.5, 0.5, 0.5, 0.5),
            (NSColor.black, 0.5, 0.0, 0.0, 0.0),
            (NSColor(srgbRed: 0.2, green: 0.4, blue: 0.6, alpha: 1), 0.5, 0.1, 0.2, 0.3)
        ] as [(NSColor, CGFloat, CGFloat, CGFloat, CGFloat)])
    func scalesEachComponentTowardBlack(
        _ color: NSColor,
        amount: CGFloat,
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) throws {
        let darker = try #require(color.darkened(by: amount)?.usingColorSpace(.sRGB))
        #expect(abs(darker.redComponent - red) < 0.000_001)
        #expect(abs(darker.greenComponent - green) < 0.000_001)
        #expect(abs(darker.blueComponent - blue) < 0.000_001)
    }

    @Test(arguments: [0, -1, -.infinity, .nan] as [CGFloat])
    func keepsTheColorForZeroNegativeOrNaNAmounts(_ amount: CGFloat) throws {
        let color = NSColor(srgbRed: 0.2, green: 0.4, blue: 0.6, alpha: 1)
        let result = try #require(color.darkened(by: amount)?.usingColorSpace(.sRGB))
        #expect(result.redComponent == 0.2 && result.greenComponent == 0.4 && result.blueComponent == 0.6)
    }

    @Test(arguments: [1, 2, .infinity] as [CGFloat])
    func returnsBlackForAmountsOfOneOrMore(_ amount: CGFloat) throws {
        let result = try #require(NSColor.systemTeal.darkened(by: amount)?.usingColorSpace(.sRGB))
        #expect(result.redComponent == 0 && result.greenComponent == 0 && result.blueComponent == 0)
    }

    @Test
    func keepsTheHue() throws {
        let color = NSColor(srgbRed: 0.9, green: 0.5, blue: 0.1, alpha: 1)
        let darker = try #require(color.darkened(by: 0.5)?.usingColorSpace(.sRGB))
        #expect(abs(darker.hueComponent - color.hueComponent) < 0.000_001)
        #expect(abs(darker.saturationComponent - color.saturationComponent) < 0.000_001)
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let darker = try #require(NSColor.red.withAlphaComponent(0.3).darkened(by: 0.5))
        #expect(darker.alphaComponent == 0.3)
    }

    @Test(arguments: [NSColor.white, .black, .labelColor, .controlAccentColor])
    func convertsGrayscaleAndCatalogColorsInsteadOfRaising(_ color: NSColor) {
        #expect(color.darkened(by: 0.2) != nil)
    }

    @Test
    func returnsNilForPatternColors() {
        #expect(NSColor(patternImage: NSImage(size: NSSize(width: 2, height: 2))).darkened(by: 0.2) == nil)
    }
}
#endif
