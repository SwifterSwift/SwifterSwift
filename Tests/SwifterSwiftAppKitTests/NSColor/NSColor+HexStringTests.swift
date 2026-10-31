// NSColor+HexStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorHexStringTests {
    @Test(
        arguments: [
            (NSColor.red, "#FF0000"),
            (NSColor.blue, "#0000FF"),
            (NSColor.black, "#000000"),
            (NSColor.white, "#FFFFFF"),
            (NSColor.orange, "#FF8000"),
            (NSColor(srgbRed: 0xAB / 255, green: 0xCD / 255, blue: 0xEF / 255, alpha: 1), "#ABCDEF"),
            (NSColor(srgbRed: 0x01 / 255, green: 0x02 / 255, blue: 0x0A / 255, alpha: 1), "#01020A")
        ] as [(NSColor, String)])
    func formatsOpaqueColors(_ color: NSColor, expected: String) {
        #expect(color.hexString() == expected)
    }

    @Test
    func roundsInsteadOfTruncating() {
        // 0.5 * 255 is 127.5, which rounds to 0x80.
        #expect(NSColor(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 1).hexString() == "#808080")
        #expect(NSColor(srgbRed: 0.499, green: 0.002, blue: 0.998, alpha: 1).hexString() == "#7F01FE")
    }

    @Test
    func leavesOutAlphaByDefault() {
        #expect(NSColor.red.withAlphaComponent(0.5).hexString() == "#FF0000")
    }

    @Test(arguments: [(1.0, "#FF0000FF"), (0.5, "#FF000080"), (0.0, "#FF000000")] as [(CGFloat, String)])
    func appendsAlphaWhenAsked(alpha: CGFloat, expected: String) {
        #expect(NSColor.red.withAlphaComponent(alpha).hexString(includingAlpha: true) == expected)
    }

    @Test
    func convertsCatalogColorsForTheCurrentAppearance() throws {
        let light = try #require(NSAppearance(named: .aqua))
        let dark = try #require(NSAppearance(named: .darkAqua))
        var lightHex: String?
        var darkHex: String?
        light.performAsCurrentDrawingAppearance { lightHex = NSColor.textColor.hexString() }
        dark.performAsCurrentDrawingAppearance { darkHex = NSColor.textColor.hexString() }
        #expect(lightHex == "#000000")
        #expect(darkHex == "#FFFFFF")
    }

    @Test
    func clampsComponentsOutsideTheSRGBRange() {
        #expect(NSColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1).hexString() == "#FF0000")
        #expect(NSColor(red: 2, green: -1, blue: 0.5, alpha: 1).hexString() == "#FF0080")
    }

    @Test
    func returnsNilForNaNComponents() {
        #expect(NSColor(srgbRed: .nan, green: 0, blue: 0, alpha: 1).hexString() == nil)
        #expect(NSColor(srgbRed: 0, green: 0, blue: 0, alpha: .nan).hexString(includingAlpha: true) == nil)
    }

    @Test
    func returnsNilForPatternColors() {
        let pattern = NSColor(patternImage: NSImage(size: NSSize(width: 2, height: 2)))
        #expect(pattern.hexString() == nil)
    }
}
#endif
