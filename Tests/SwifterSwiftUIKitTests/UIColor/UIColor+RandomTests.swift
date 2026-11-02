// UIColor+RandomTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorRandomTests {
    @Test
    func returnsOpaqueColorsWithComponentsInRange() {
        for _ in 0..<1000 {
            let components = rgba(of: UIColor.random())
            #expect(components.dropLast().allSatisfy { (0...1).contains($0) })
            #expect(components.last == 1)
        }
    }

    @Test
    func coversTheWholeRangeOfEachComponent() {
        // With 2,000 draws, the chance that a component never goes below 0.05 (or above 0.95) is below 1e-44.
        let colors = (0..<2000).map { _ in rgba(of: UIColor.random()) }
        for channel in 0..<3 {
            let values = colors.map { $0[channel] }
            #expect(values.min().map { $0 < 0.05 } == true)
            #expect(values.max().map { $0 > 0.95 } == true)
        }
    }

    @Test
    func returnsDifferentColors() {
        // Two random colors collide with a probability below 2^-60, even with a 32-bit `CGFloat`.
        #expect(UIColor.random() != UIColor.random())
    }

    @Test(
        arguments: [(0.5, 0.5), (0, 0), (1, 1), (-0.4, 0), (21, 1), (.nan, 0), (.infinity, 1), (-.infinity, 0)]
            as [(CGFloat, CGFloat)])
    func usesAndClampsTheAlpha(alpha: CGFloat, expected: CGFloat) {
        #expect(rgba(of: UIColor.random(alpha: alpha)).last == expected)
    }

    @Test
    func createsAnSRGBCompatibleColor() {
        // UIKit stores the color in extended sRGB, which matches sRGB for components in `0...1`.
        let name = UIColor.random().cgColor.colorSpace?.name
        #expect(name == CGColorSpace.sRGB || name == CGColorSpace.extendedSRGB)
    }

    /// The color's red, green, blue and alpha components.
    private func rgba(of color: UIColor) -> [CGFloat] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        #expect(color.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        return [red, green, blue, alpha]
    }
}
#endif
