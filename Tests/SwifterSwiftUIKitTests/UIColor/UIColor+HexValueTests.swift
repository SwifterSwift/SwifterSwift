// UIColor+HexValueTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorHexValueTests {
    @Test(arguments: [0xFF0000, 0x00FF00, 0x0000FF, 0x000000, 0xFFFFFF, 0x123456, 0xFCA864, 0x1F2D3C] as [UInt32])
    func packsTheComponents(_ hex: UInt32) {
        let color = UIColor(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
        #expect(color.hexValue == hex)
    }

    @Test
    func roundsInsteadOfTruncating() {
        #expect(UIColor(white: 0.5, alpha: 1).hexValue == 0x808080)
        #expect(UIColor.orange.hexValue == 0xFF8000)
    }

    @Test
    func leavesOutAlpha() {
        #expect(UIColor.red.withAlphaComponent(0.5).hexValue == 0xFF0000)
        #expect(UIColor.clear.hexValue == 0x000000)
    }

    @Test
    func clampsComponentsOutsideTheSRGBRangeWithoutTrapping() {
        // SwifterSwift 8 trapped converting the negative component to `UInt32`.
        #expect(UIColor(red: -0.5, green: 2, blue: 0.5, alpha: 1).hexValue == 0x00FF80)
        #expect(UIColor(displayP3Red: 0, green: 1, blue: 0, alpha: 1).hexValue == 0x00FF00)
        #expect(UIColor(red: .infinity, green: -.infinity, blue: 0, alpha: 1).hexValue == 0xFF0000)
    }

    @Test
    func returnsNilForNaNComponents() {
        #expect(UIColor(red: 0, green: .nan, blue: 0, alpha: 1).hexValue == nil)
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
        #expect(UIColor(patternImage: image).hexValue == nil)
    }
}
#endif
