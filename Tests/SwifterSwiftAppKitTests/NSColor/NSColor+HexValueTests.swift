// NSColor+HexValueTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorHexValueTests {
    @Test(arguments: [0xFF0000, 0x00FF00, 0x0000FF, 0x000000, 0xFFFFFF, 0x123456, 0xFCA864, 0x1F2D3C] as [UInt32])
    func packsTheComponents(_ hex: UInt32) {
        let color = NSColor(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
        #expect(color.hexValue == hex)
    }

    @Test
    func roundsInsteadOfTruncating() {
        #expect(NSColor(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 1).hexValue == 0x808080)
        #expect(NSColor.orange.hexValue == 0xFF8000)
    }

    @Test
    func leavesOutAlpha() {
        #expect(NSColor.red.withAlphaComponent(0.5).hexValue == 0xFF0000)
        #expect(NSColor.clear.hexValue == 0x000000)
    }

    @Test
    func clampsComponentsOutsideTheSRGBRangeWithoutTrapping() {
        #expect(NSColor(red: -0.5, green: 2, blue: 0.5, alpha: 1).hexValue == 0x00FF80)
        #expect(NSColor(red: .infinity, green: -.infinity, blue: 0, alpha: 1).hexValue != nil)
    }

    @Test(arguments: [NSColor.black, .white, .labelColor, .controlAccentColor])
    func convertsGrayscaleAndCatalogColorsInsteadOfRaising(_ color: NSColor) throws {
        let value = try #require(color.hexValue)
        #expect(value <= 0xFFFFFF)
    }

    @Test
    func returnsNilForNaNAndPatternColors() {
        #expect(NSColor(srgbRed: 0, green: .nan, blue: 0, alpha: 1).hexValue == nil)
        #expect(NSColor(patternImage: NSImage(size: NSSize(width: 2, height: 2))).hexValue == nil)
    }
}
#endif
