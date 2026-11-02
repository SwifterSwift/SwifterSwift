// UIColor+HexStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorHexStringTests {
    @Test(
        arguments: [
            (UIColor.red, "#FF0000"),
            (UIColor.blue, "#0000FF"),
            (UIColor.black, "#000000"),
            (UIColor.white, "#FFFFFF"),
            (UIColor.orange, "#FF8000"),
            (UIColor(red: 0xAB / 255, green: 0xCD / 255, blue: 0xEF / 255, alpha: 1), "#ABCDEF"),
            (UIColor(red: 0x01 / 255, green: 0x02 / 255, blue: 0x0A / 255, alpha: 1), "#01020A")
        ] as [(UIColor, String)])
    func formatsOpaqueColors(_ color: UIColor, expected: String) {
        #expect(color.hexString() == expected)
    }

    @Test
    func roundsInsteadOfTruncating() {
        // 0.5 * 255 is 127.5, which rounds to 0x80.
        #expect(UIColor(white: 0.5, alpha: 1).hexString() == "#808080")
        #expect(UIColor(red: 0.499, green: 0.002, blue: 0.998, alpha: 1).hexString() == "#7F01FE")
    }

    @Test
    func leavesOutAlphaByDefault() {
        #expect(UIColor.red.withAlphaComponent(0.5).hexString() == "#FF0000")
    }

    @Test(arguments: [(1.0, "#FF0000FF"), (0.5, "#FF000080"), (0.0, "#FF000000")] as [(CGFloat, String)])
    func appendsAlphaWhenAsked(alpha: CGFloat, expected: String) {
        #expect(UIColor.red.withAlphaComponent(alpha).hexString(includingAlpha: true) == expected)
    }

    @Test
    func clampsComponentsOutsideTheSRGBRange() {
        #expect(UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1).hexString() == "#FF0000")
        #expect(UIColor(red: 2, green: -1, blue: 0.5, alpha: 1).hexString() == "#FF0080")
        #expect(UIColor(red: .infinity, green: -.infinity, blue: 0, alpha: 1).hexString() == "#FF0000")
    }

    @Test
    func returnsNilForNaNComponents() {
        #expect(UIColor(red: .nan, green: 0, blue: 0, alpha: 1).hexString() == nil)
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
        #expect(UIColor(patternImage: image).hexString() == nil)
    }

    #if !os(watchOS)
    @Test
    func resolvesDynamicColorsWithTheCurrentTraits() {
        var light: String?
        var dark: String?
        UITraitCollection(userInterfaceStyle: .light).performAsCurrent { light = UIColor.label.hexString() }
        UITraitCollection(userInterfaceStyle: .dark).performAsCurrent { dark = UIColor.label.hexString() }
        #expect(light == "#000000")
        #expect(dark == "#FFFFFF")
    }
    #endif
}
#endif
