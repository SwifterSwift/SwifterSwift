// NSColor+RandomTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorRandomTests {
    @Test
    func returnsOpaqueColorsWithComponentsInRange() {
        for _ in 0..<1000 {
            let components = rgba(of: NSColor.random())
            #expect(components.dropLast().allSatisfy { (0...1).contains($0) })
            #expect(components.last == 1)
        }
    }

    @Test
    func coversTheWholeRangeOfEachComponent() {
        // With 2,000 draws, the chance that a component never goes below 0.05 (or above 0.95) is below 1e-44.
        let colors = (0..<2000).map { _ in rgba(of: NSColor.random()) }
        for channel in 0..<3 {
            let values = colors.map { $0[channel] }
            #expect(values.min().map { $0 < 0.05 } == true)
            #expect(values.max().map { $0 > 0.95 } == true)
        }
    }

    @Test
    func returnsDifferentColors() {
        // Two random colors collide with a probability below 2^-60, even with a 32-bit `CGFloat`.
        #expect(NSColor.random() != NSColor.random())
    }

    @Test(
        arguments: [(0.5, 0.5), (0, 0), (1, 1), (-0.4, 0), (21, 1), (.nan, 0), (.infinity, 1), (-.infinity, 0)]
            as [(CGFloat, CGFloat)])
    func usesAndClampsTheAlpha(alpha: CGFloat, expected: CGFloat) {
        #expect(rgba(of: NSColor.random(alpha: alpha)).last == expected)
    }

    @Test
    func createsAnSRGBColor() {
        #expect(NSColor.random().colorSpace == .sRGB)
    }

    /// The color's red, green, blue and alpha components.
    private func rgba(of color: NSColor) -> [CGFloat] {
        [color.redComponent, color.greenComponent, color.blueComponent, color.alphaComponent]
    }
}
#endif
