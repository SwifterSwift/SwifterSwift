// NSColor+RandomUsingTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorRandomUsingTests {
    /// A deterministic SplitMix64 generator, so the tests don't depend on chance.
    struct SeededGenerator: RandomNumberGenerator {
        var state: UInt64

        mutating func next() -> UInt64 {
            state &+= 0x9E37_79B9_7F4A_7C15
            var value = state
            value = (value ^ (value >> 30)) &* 0xBF58_476D_1CE4_E5B9
            value = (value ^ (value >> 27)) &* 0x94D0_49BB_1331_11EB
            return value ^ (value >> 31)
        }
    }

    @Test(arguments: [0, 1, 42, UInt64.max])
    func returnsTheSameColorForTheSameSeed(_ seed: UInt64) {
        var first = SeededGenerator(state: seed)
        var second = SeededGenerator(state: seed)
        #expect(rgba(of: NSColor.random(using: &first)) == rgba(of: NSColor.random(using: &second)))
        #expect(first.state == second.state)
    }

    @Test
    func returnsDifferentColorsForDifferentSeeds() {
        var first = SeededGenerator(state: 1)
        var second = SeededGenerator(state: 2)
        #expect(rgba(of: NSColor.random(using: &first)) != rgba(of: NSColor.random(using: &second)))
    }

    @Test
    func advancesTheGenerator() {
        var generator = SeededGenerator(state: 5)
        let first = rgba(of: NSColor.random(using: &generator))
        #expect(generator.state != 5)
        #expect(rgba(of: NSColor.random(using: &generator)) != first)
    }

    @Test
    func picksEachComponentUniformlyFromZeroToOne() {
        var generator = SeededGenerator(state: 7)
        let colors = (0..<3000).map { _ in rgba(of: NSColor.random(using: &generator)) }
        for channel in 0..<3 {
            let values = colors.map { $0[channel] }
            let mean = values.reduce(0, +) / CGFloat(values.count)
            #expect(values.allSatisfy { (0...1).contains($0) })
            #expect(abs(mean - 0.5) < 0.03)
            #expect(values.min().map { $0 < 0.01 } == true)
            #expect(values.max().map { $0 > 0.99 } == true)
        }
        #expect(colors.allSatisfy { $0[3] == 1 })
    }

    @Test
    func doesNotUseTheGeneratorForTheAlpha() {
        var opaque = SeededGenerator(state: 11)
        var translucent = SeededGenerator(state: 11)
        let opaqueComponents = rgba(of: NSColor.random(using: &opaque))
        let translucentComponents = rgba(of: NSColor.random(alpha: 0.3, using: &translucent))
        #expect(opaqueComponents.dropLast() == translucentComponents.dropLast())
        #expect(translucentComponents.last == 0.3)
        #expect(opaque.state == translucent.state)
    }

    @Test(
        arguments: [(0.5, 0.5), (0, 0), (1, 1), (-0.4, 0), (21, 1), (.nan, 0), (.infinity, 1), (-.infinity, 0)]
            as [(CGFloat, CGFloat)])
    func clampsTheAlpha(alpha: CGFloat, expected: CGFloat) {
        var generator = SeededGenerator(state: 13)
        #expect(rgba(of: NSColor.random(alpha: alpha, using: &generator)).last == expected)
    }

    @Test
    func acceptsTheSystemGenerator() {
        var generator = SystemRandomNumberGenerator()
        let components = rgba(of: NSColor.random(using: &generator))
        #expect(components.allSatisfy { (0...1).contains($0) })
        #expect(components.last == 1)
    }

    @Test
    func createsAnSRGBColor() {
        var generator = SeededGenerator(state: 17)
        #expect(NSColor.random(using: &generator).colorSpace == .sRGB)
    }

    /// The color's red, green, blue and alpha components.
    private func rgba(of color: NSColor) -> [CGFloat] {
        [color.redComponent, color.greenComponent, color.blueComponent, color.alphaComponent]
    }
}
#endif
