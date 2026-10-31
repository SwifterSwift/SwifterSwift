// UIColor+InitHexTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIColorInitHexTests {
    @Test(
        arguments: [
            (0xFF8000, 0xFF, 0x80, 0x00),
            (0x123456, 0x12, 0x34, 0x56),
            (0x000000, 0x00, 0x00, 0x00),
            (0xFFFFFF, 0xFF, 0xFF, 0xFF),
            (0x000FFF, 0x00, 0x0F, 0xFF),
            (0x000001, 0x00, 0x00, 0x01)
        ] as [(UInt32, Int, Int, Int)])
    func readsTheRedGreenAndBlueBytes(hex: UInt32, red: Int, green: Int, blue: Int) {
        var newRed: CGFloat = 0
        var newGreen: CGFloat = 0
        var newBlue: CGFloat = 0
        var alpha: CGFloat = 0
        #expect(UIColor(hex: hex).getRed(&newRed, green: &newGreen, blue: &newBlue, alpha: &alpha))
        #expect(Int((newRed * 255).rounded()) == red)
        #expect(Int((newGreen * 255).rounded()) == green)
        #expect(Int((newBlue * 255).rounded()) == blue)
        #expect(alpha == 1)
    }

    @Test
    func createsAnSRGBCompatibleColor() {
        // UIKit stores the color in extended sRGB, which matches sRGB for components in `0...1`.
        let name = UIColor(hex: 0x123456).cgColor.colorSpace?.name
        #expect(name == CGColorSpace.sRGB || name == CGColorSpace.extendedSRGB)
    }

    @Test
    func isNotFailable() {
        let color: UIColor = UIColor(hex: 0xABCDEF)
        #expect(color.cgColor.alpha == 1)
    }

    @Test
    func ignoresBitsAboveTheLowest24() {
        #expect(UIColor(hex: 0xFF12_3456) == UIColor(hex: 0x12_3456))
    }

    @Test(
        arguments: [(0.5, 0.5), (0, 0), (1, 1), (-0.4, 0), (21, 1), (.nan, 0), (.infinity, 1)] as [(CGFloat, CGFloat)])
    func clampsTheAlpha(alpha: CGFloat, expected: CGFloat) {
        #expect(UIColor(hex: 0xAABBCC, alpha: alpha).cgColor.alpha == expected)
    }
}
#endif
