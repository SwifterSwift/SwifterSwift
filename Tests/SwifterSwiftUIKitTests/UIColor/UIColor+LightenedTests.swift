// UIColor+LightenedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorLightenedTests {
    @Test(
        arguments: [
            (UIColor.blue, 0.25, 0.25, 0.25, 1.0),
            (UIColor.black, 0.5, 0.5, 0.5, 0.5),
            (UIColor.white, 0.5, 1.0, 1.0, 1.0),
            (UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1), 0.5, 0.6, 0.7, 0.8)
        ] as [(UIColor, CGFloat, CGFloat, CGFloat, CGFloat)])
    func movesEachComponentTowardWhite(
        _ color: UIColor,
        amount: CGFloat,
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) throws {
        let lighter = try #require(color.lightened(by: amount))
        var newRed: CGFloat = 0
        var newGreen: CGFloat = 0
        var newBlue: CGFloat = 0
        #expect(lighter.getRed(&newRed, green: &newGreen, blue: &newBlue, alpha: nil))
        #expect(abs(newRed - red) < 0.000_001)
        #expect(abs(newGreen - green) < 0.000_001)
        #expect(abs(newBlue - blue) < 0.000_001)
    }

    @Test(arguments: [0, -1, -.infinity, .nan] as [CGFloat])
    func keepsTheColorForZeroNegativeOrNaNAmounts(_ amount: CGFloat) throws {
        let color = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)
        #expect(try #require(color.lightened(by: amount)) == color)
    }

    @Test(arguments: [1, 2, .infinity] as [CGFloat])
    func returnsWhiteForAmountsOfOneOrMore(_ amount: CGFloat) throws {
        let result = try #require(UIColor(red: 1, green: 0.23, blue: 0.19, alpha: 1).lightened(by: amount))
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        #expect(result.getRed(&red, green: &green, blue: &blue, alpha: nil))
        #expect(red == 1 && green == 1 && blue == 1)
    }

    @Test
    func keepsTheHue() throws {
        // Adding the same amount to every component would clip red here and shift the hue.
        let color = UIColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 1)
        var hue: CGFloat = 0
        var newHue: CGFloat = 0
        #expect(color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil))
        #expect(try #require(color.lightened(by: 0.5)).getHue(&newHue, saturation: nil, brightness: nil, alpha: nil))
        #expect(abs(newHue - hue) < 0.000_001)
    }

    @Test
    func keepsTheAlphaComponent() throws {
        let lighter = try #require(UIColor.red.withAlphaComponent(0.3).lightened(by: 0.5))
        #expect(lighter.cgColor.alpha == 0.3)
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
        #expect(UIColor(patternImage: image).lightened(by: 0.2) == nil)
    }
}
#endif
