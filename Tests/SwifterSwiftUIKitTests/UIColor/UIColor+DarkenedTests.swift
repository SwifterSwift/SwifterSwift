// UIColor+DarkenedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorDarkenedTests {
    @Test(
        arguments: [
            (UIColor.blue, 0.25, 0.0, 0.0, 0.75),
            (UIColor.white, 0.5, 0.5, 0.5, 0.5),
            (UIColor.black, 0.5, 0.0, 0.0, 0.0),
            (UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1), 0.5, 0.1, 0.2, 0.3)
        ] as [(UIColor, CGFloat, CGFloat, CGFloat, CGFloat)])
    func scalesEachComponentTowardBlack(
        _ color: UIColor,
        amount: CGFloat,
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) throws {
        let darker = try #require(color.darkened(by: amount))
        var newRed: CGFloat = 0
        var newGreen: CGFloat = 0
        var newBlue: CGFloat = 0
        #expect(darker.getRed(&newRed, green: &newGreen, blue: &newBlue, alpha: nil))
        #expect(abs(newRed - red) < 0.000_001)
        #expect(abs(newGreen - green) < 0.000_001)
        #expect(abs(newBlue - blue) < 0.000_001)
    }

    @Test(arguments: [0, -1, -.infinity, .nan] as [CGFloat])
    func keepsTheColorForZeroNegativeOrNaNAmounts(_ amount: CGFloat) throws {
        let color = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)
        #expect(try #require(color.darkened(by: amount)) == color)
    }

    @Test(arguments: [1, 2, .infinity] as [CGFloat])
    func returnsBlackForAmountsOfOneOrMore(_ amount: CGFloat) throws {
        let result = try #require(UIColor(red: 0.2, green: 0.7, blue: 0.8, alpha: 1).darkened(by: amount))
        var red: CGFloat = 1
        var green: CGFloat = 1
        var blue: CGFloat = 1
        #expect(result.getRed(&red, green: &green, blue: &blue, alpha: nil))
        #expect(red == 0 && green == 0 && blue == 0)
    }

    @Test
    func keepsTheHueAndSaturation() throws {
        let color = UIColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 1)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var newHue: CGFloat = 0
        var newSaturation: CGFloat = 0
        #expect(color.getHue(&hue, saturation: &saturation, brightness: nil, alpha: nil))
        let darker = try #require(color.darkened(by: 0.5))
        #expect(darker.getHue(&newHue, saturation: &newSaturation, brightness: nil, alpha: nil))
        #expect(abs(newHue - hue) < 0.000_001)
        #expect(abs(newSaturation - saturation) < 0.000_001)
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let darker = try #require(UIColor.red.withAlphaComponent(0.3).darkened(by: 0.5))
        #expect(darker.cgColor.alpha == 0.3)
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
        #expect(UIColor(patternImage: image).darkened(by: 0.2) == nil)
    }
}
#endif
