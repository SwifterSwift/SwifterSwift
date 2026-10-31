// NSColor+InitRed255Tests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorInitRed255Tests {
    @Test(
        arguments: [
            (255, 128, 0),
            (31, 45, 60),
            (1, 0, 0),
            (0, 0, 0),
            (255, 255, 255),
            (UInt8.min, UInt8.max, UInt8.min),
            (254, 1, 127)
        ] as [(UInt8, UInt8, UInt8)])
    func dividesEachComponentBy255(red: UInt8, green: UInt8, blue: UInt8) {
        let components = rgba(of: NSColor(red255: red, green255: green, blue255: blue))
        #expect(components == [CGFloat(red) / 255, CGFloat(green) / 255, CGFloat(blue) / 255, 1])
    }

    @Test
    func mapsTheExtremesToZeroAndOne() {
        #expect(rgba(of: NSColor(red255: .min, green255: .min, blue255: .min)) == [0, 0, 0, 1])
        #expect(rgba(of: NSColor(red255: .max, green255: .max, blue255: .max)) == [1, 1, 1, 1])
    }

    @Test
    func matchesTheSDKInitializer() {
        let color = NSColor(red255: 255, green255: 128, blue255: 0, alpha: 0.5)
        #expect(color == NSColor(srgbRed: 1, green: 128 / 255, blue: 0, alpha: 0.5))
    }

    @Test
    func keepsTheSDKInitializerForUnitComponents() {
        // In SwifterSwift 8, `init?(red: Int, green: Int, blue: Int)` caught integer literals, so
        // `NSColor(red: 1, green: 0, blue: 0)` was #010000. The `red255:` labels can't be picked by accident.
        #expect(rgba(of: NSColor(red: 1, green: 0, blue: 0, alpha: 1)) == [1, 0, 0, 1])
        #expect(rgba(of: NSColor(red255: 1, green255: 0, blue255: 0)) == [1 / 255, 0, 0, 1])
    }

    @Test(
        arguments: [(0.5, 0.5), (0, 0), (1, 1), (-0.4, 0), (21, 1), (.nan, 0), (.infinity, 1), (-.infinity, 0)]
            as [(CGFloat, CGFloat)])
    func clampsTheAlpha(alpha: CGFloat, expected: CGFloat) {
        #expect(rgba(of: NSColor(red255: 10, green255: 20, blue255: 30, alpha: alpha)).last == expected)
    }

    @Test
    func createsAnSRGBColor() {
        #expect(NSColor(red255: 18, green255: 52, blue255: 86).colorSpace == .sRGB)
    }

    /// The color's red, green, blue and alpha components.
    private func rgba(of color: NSColor) -> [CGFloat] {
        [color.redComponent, color.greenComponent, color.blueComponent, color.alphaComponent]
    }
}
#endif
