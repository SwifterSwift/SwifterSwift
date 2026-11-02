// UIColor+RGBAComponentsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorRGBAComponentsTests {
    @Test(
        arguments: [
            (UIColor.red, 1.0, 0.0, 0.0),
            (UIColor.green, 0.0, 1.0, 0.0),
            (UIColor.blue, 0.0, 0.0, 1.0),
            (UIColor.black, 0.0, 0.0, 0.0),
            (UIColor.white, 1.0, 1.0, 1.0),
            (UIColor(red: 0.25, green: 0.5, blue: 0.75, alpha: 1), 0.25, 0.5, 0.75)
        ] as [(UIColor, CGFloat, CGFloat, CGFloat)])
    func returnsTheComponents(of color: UIColor, red: CGFloat, green: CGFloat, blue: CGFloat) throws {
        let components = try #require(color.rgbaComponents)
        #expect(components.red == red)
        #expect(components.green == green)
        #expect(components.blue == blue)
        #expect(components.alpha == 1)
    }

    @Test
    func convertsGrayscaleColors() throws {
        let components = try #require(UIColor(white: 0.5, alpha: 0.2).rgbaComponents)
        #expect(components.red == 0.5)
        #expect(components.green == 0.5)
        #expect(components.blue == 0.5)
        #expect(components.alpha == 0.2)
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let components = try #require(UIColor.red.withAlphaComponent(0.25).rgbaComponents)
        #expect(components.alpha == 0.25)
    }

    @Test
    func readsByteValuesExactly() throws {
        let components = try #require(UIColor(red: 0x12 / 255, green: 1, blue: 1, alpha: 1).rgbaComponents)
        #expect((components.red * 255).rounded() == 0x12)
    }

    @Test
    func keepsWideGamutComponentsOutsideTheUnitRange() throws {
        let components = try #require(UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1).rgbaComponents)
        #expect(components.red > 1)
        #expect(components.green < 0)
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
        #expect(UIColor(patternImage: image).rgbaComponents == nil)
    }

    #if !os(watchOS)
    @Test
    func resolvesDynamicColorsWithTheCurrentTraits() throws {
        var light: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)?
        var dark: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)?
        UITraitCollection(userInterfaceStyle: .light).performAsCurrent { light = UIColor.label.rgbaComponents }
        UITraitCollection(userInterfaceStyle: .dark).performAsCurrent { dark = UIColor.label.rgbaComponents }
        #expect(try #require(light).red == 0)
        #expect(abs(try #require(dark).red - 1) < 0.000_01)
    }

    @Test
    func readsResolvedDynamicColors() throws {
        let resolved = UIColor.label.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))
        let components = try #require(resolved.rgbaComponents)
        #expect(abs(components.red - 1) < 0.000_01)
        #expect(abs(components.green - 1) < 0.000_01)
        #expect(abs(components.blue - 1) < 0.000_01)
    }
    #endif
}
#endif
