// UIColor+BlendedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorBlendedTests {
    @Test
    func mixesEvenlyByDefault() throws {
        let mix = try #require(UIColor.white.blended(with: .black))
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        #expect(mix.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
        #expect(red == 0.5 && green == 0.5 && blue == 0.5 && alpha == 1)
    }

    @Test(
        arguments: [
            (0.25, 0.75, 0.0, 0.25),
            (0.5, 0.5, 0.0, 0.5),
            (0.75, 0.25, 0.0, 0.75)
        ] as [(CGFloat, CGFloat, CGFloat, CGFloat)])
    func weighsTheOtherColorByTheFraction(fraction: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat) throws {
        let mix = try #require(UIColor.red.blended(with: .blue, fraction: fraction))
        var newRed: CGFloat = 0
        var newGreen: CGFloat = 0
        var newBlue: CGFloat = 0
        #expect(mix.getRed(&newRed, green: &newGreen, blue: &newBlue, alpha: nil))
        #expect(abs(newRed - red) < 0.000_001)
        #expect(abs(newGreen - green) < 0.000_001)
        #expect(abs(newBlue - blue) < 0.000_001)
    }

    @Test
    func interpolatesAlpha() throws {
        let first = UIColor(red: 0x12 / 255, green: 0x34 / 255, blue: 0x56 / 255, alpha: 0.5)
        let second = UIColor(red: 0x66 / 255, green: 0x55 / 255, blue: 0x44 / 255, alpha: 0.7)
        let mix = try #require(first.blended(with: second, fraction: 0.3))
        var red: CGFloat = 0
        var alpha: CGFloat = 0
        #expect(mix.getRed(&red, green: nil, blue: nil, alpha: &alpha))
        #expect(abs(red * 255 - (0x12 * 0.7 + 0x66 * 0.3)) < 0.000_1)
        #expect(abs(alpha - (0.5 * 0.7 + 0.7 * 0.3)) < 0.000_001)
    }

    @Test(arguments: [0, -1, -.infinity, .nan] as [CGFloat])
    func returnsThisColorForFractionsOfZeroOrLess(_ fraction: CGFloat) throws {
        let color = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
        #expect(try #require(color.blended(with: .white, fraction: fraction)) == color)
    }

    @Test(arguments: [1, 2, .infinity] as [CGFloat])
    func returnsTheOtherColorForFractionsOfOneOrMore(_ fraction: CGFloat) throws {
        let other = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
        #expect(try #require(UIColor.white.blended(with: other, fraction: fraction)) == other)
    }

    @Test
    func mixesGrayscaleAndRGBColors() throws {
        let mix = try #require(UIColor(white: 1, alpha: 1).blended(with: .red))
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        #expect(mix.getRed(&red, green: &green, blue: &blue, alpha: nil))
        #expect(red == 1 && green == 0.5 && blue == 0.5)
    }

    @Test
    func returnsNilWhenEitherColorIsAPattern() throws {
        let context = CGContext(
            data: nil,
            width: 2,
            height: 2,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        let pattern = UIColor(patternImage: UIImage(cgImage: try #require(context?.makeImage())))
        #expect(pattern.blended(with: .red) == nil)
        #expect(UIColor.red.blended(with: pattern) == nil)
    }
}
#endif
