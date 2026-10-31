// UIColor+ComplementaryTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorComplementaryTests {
    @Test(
        arguments: [
            (0xFF0000, 0x00FFFF),
            (0x00FF00, 0xFF00FF),
            (0x0000FF, 0xFFFF00),
            (0x123456, 0x563412),
            (0xFCA864, 0x64B8FC),
            (0x000000, 0x000000),
            (0xFFFFFF, 0xFFFFFF),
            (0x808080, 0x808080)
        ] as [(Int, Int)])
    func rotatesTheHueByHalfATurn(hex: Int, expected: Int) throws {
        let color = UIColor(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        let complement = try #require(color.complementary)
        #expect(complement.getRed(&red, green: &green, blue: &blue, alpha: nil))
        #expect(Int((red * 255).rounded()) == (expected >> 16) & 0xFF)
        #expect(Int((green * 255).rounded()) == (expected >> 8) & 0xFF)
        #expect(Int((blue * 255).rounded()) == expected & 0xFF)
    }

    @Test
    func keepsGraysUnchanged() throws {
        // Grays have no hue to rotate, so each one is its own complement.
        var red: CGFloat = -1
        var green: CGFloat = -1
        var blue: CGFloat = -1
        let gray = try #require(UIColor(white: 0.5, alpha: 1).complementary)
        #expect(gray.getRed(&red, green: &green, blue: &blue, alpha: nil))
        #expect(red == 0.5 && green == 0.5 && blue == 0.5)
        let black = try #require(UIColor.black.complementary)
        #expect(black.getRed(&red, green: &green, blue: &blue, alpha: nil))
        #expect(red == 0 && green == 0 && blue == 0)
    }

    @Test
    func keepsSaturationBrightnessAndAlpha() throws {
        let color = UIColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 0.3)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        #expect(color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha))
        var newHue: CGFloat = 0
        var newSaturation: CGFloat = 0
        var newBrightness: CGFloat = 0
        var newAlpha: CGFloat = 0
        let complement = try #require(color.complementary)
        #expect(complement.getHue(&newHue, saturation: &newSaturation, brightness: &newBrightness, alpha: &newAlpha))
        #expect(abs(abs(newHue - hue) - 0.5) < 0.000_001)
        #expect(abs(newSaturation - saturation) < 0.000_001)
        #expect(abs(newBrightness - brightness) < 0.000_001)
        #expect(newAlpha == 0.3)
    }

    @Test
    func isItsOwnInverse() throws {
        let twice = try #require(UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1).complementary?.complementary)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        #expect(twice.getRed(&red, green: &green, blue: &blue, alpha: nil))
        #expect(abs(red - 0.2) < 0.000_001)
        #expect(abs(green - 0.6) < 0.000_001)
        #expect(abs(blue - 0.4) < 0.000_001)
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
        #expect(UIColor(patternImage: image).complementary == nil)
    }
}
#endif
