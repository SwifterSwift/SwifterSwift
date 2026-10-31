// UIColor+HSBAComponentsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorHSBAComponentsTests {
    @Test(
        arguments: [
            (0x00FF00, 120.0, 100.0, 100.0),
            (0x0000FF, 240.0, 100.0, 100.0),
            (0x000000, 0.0, 0.0, 0.0),
            (0xFFFFFF, 0.0, 0.0, 100.0),
            (0x123456, 210.0, 79.0, 34.0),
            (0xFCA864, 27.0, 60.0, 99.0),
            (0x1F2D3C, 211.0, 48.0, 24.0)
        ] as [(Int, CGFloat, CGFloat, CGFloat)])
    func returnsHueSaturationAndBrightness(
        hex: Int,
        degrees: CGFloat,
        saturation: CGFloat,
        brightness: CGFloat
    ) throws {
        let color = UIColor(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
        let components = try #require(color.hsbaComponents)
        #expect((components.hue * 360).rounded() == degrees)
        #expect((components.saturation * 100).rounded() == saturation)
        #expect((components.brightness * 100).rounded() == brightness)
        #expect(components.alpha == 1)
    }

    @Test
    func reportsZeroForRed() throws {
        let components = try #require(UIColor.red.hsbaComponents)
        #expect(components.hue == 0)
        #expect(components.saturation == 1)
        #expect(components.brightness == 1)
    }

    @Test(arguments: [UIColor.black, .white, .gray, .clear])
    func returnsZeroHueAndSaturationForGrays(_ color: UIColor) throws {
        let components = try #require(color.hsbaComponents)
        #expect(components.hue == 0)
        #expect(components.saturation == 0)
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let components = try #require(UIColor(white: 1, alpha: 0.4).hsbaComponents)
        #expect(components.alpha == 0.4)
        #expect(components.brightness == 1)
    }

    @Test
    func returnsNilForPatternColors() throws {
        let context = CGContext(
            data: nil,
            width: 2,
            height: 2,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        let image = UIImage(cgImage: try #require(context?.makeImage()))
        #expect(UIColor(patternImage: image).hsbaComponents == nil)
    }

    #if !os(watchOS)
    @Test
    func readsResolvedDynamicColors() throws {
        // A custom dynamic color, because `systemBackground` doesn't exist on tvOS.
        let dynamic = UIColor { $0.userInterfaceStyle == .dark ? .black : .white }
        let resolved = dynamic.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        let components = try #require(resolved.hsbaComponents)
        #expect(components.brightness == 1)
    }
    #endif
}
#endif
