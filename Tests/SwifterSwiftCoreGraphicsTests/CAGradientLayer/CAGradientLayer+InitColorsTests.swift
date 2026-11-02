// CAGradientLayer+InitColorsTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import Foundation
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CAGradientLayerInitColorsTests {
    let colors = [
        CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1),
        CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 1),
        CGColor(srgbRed: 1, green: 0.5, blue: 0, alpha: 0.5),
        CGColor(gray: 0.5, alpha: 1)
    ]

    @Test
    func setsEveryProperty() throws {
        let layer = CAGradientLayer(
            colors: colors,
            locations: [0, 0.3, 0.6, 1],
            startPoint: CGPoint(x: 0, y: 0.5),
            endPoint: CGPoint(x: 1, y: 0.5),
            type: .radial
        )
        let storedColors = try #require(layer.colors as? [CGColor])
        #expect(storedColors == colors)
        #expect(layer.locations?.map(\.doubleValue) == [0, 0.3, 0.6, 1])
        #expect(layer.startPoint == CGPoint(x: 0, y: 0.5))
        #expect(layer.endPoint == CGPoint(x: 1, y: 0.5))
        #expect(layer.type == .radial)
    }

    @Test
    func usesTheDefaultsOfANewGradientLayer() {
        let layer = CAGradientLayer(colors: colors)
        let plain = CAGradientLayer()
        #expect(layer.locations == nil)
        #expect(layer.startPoint == CGPoint(x: 0.5, y: 0))
        #expect(layer.endPoint == CGPoint(x: 0.5, y: 1))
        #expect(layer.type == .axial)
        #expect(layer.startPoint == plain.startPoint)
        #expect(layer.endPoint == plain.endPoint)
        #expect(layer.type == plain.type)
    }

    @Test(arguments: [CAGradientLayerType.axial, .radial, .conic])
    func setsTheType(_ type: CAGradientLayerType) {
        #expect(CAGradientLayer(colors: colors, type: type).type == type)
    }

    @Test
    func acceptsNoColors() {
        let layer = CAGradientLayer(colors: [])
        #expect(layer.colors?.isEmpty == true)
    }

    @Test
    func storesLocationsAsGivenWithoutCrashing() {
        let layer = CAGradientLayer(colors: colors, locations: [1, -0.5, 2])
        #expect(layer.locations?.map(\.doubleValue) == [1, -0.5, 2])
        #expect(layer.colors?.count == colors.count)
    }
}
#endif
