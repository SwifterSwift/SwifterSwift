// NSColor+InitHexTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorInitHexTests {
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
        let color = NSColor(hex: hex)
        #expect(Int((color.redComponent * 255).rounded()) == red)
        #expect(Int((color.greenComponent * 255).rounded()) == green)
        #expect(Int((color.blueComponent * 255).rounded()) == blue)
        #expect(color.alphaComponent == 1)
    }

    @Test
    func createsAnSRGBColor() {
        #expect(NSColor(hex: 0x123456).colorSpace == .sRGB)
    }

    @Test
    func isNotFailable() {
        let color: NSColor = NSColor(hex: 0xABCDEF)
        #expect(color.alphaComponent == 1)
    }

    @Test
    func ignoresBitsAboveTheLowest24() {
        let color = NSColor(hex: 0xFF12_3456)
        #expect(Int((color.redComponent * 255).rounded()) == 0x12)
        #expect(Int((color.blueComponent * 255).rounded()) == 0x56)
        #expect(color.alphaComponent == 1)
    }

    @Test(
        arguments: [(0.5, 0.5), (0, 0), (1, 1), (-0.4, 0), (21, 1), (.nan, 0), (.infinity, 1)] as [(CGFloat, CGFloat)])
    func clampsTheAlpha(alpha: CGFloat, expected: CGFloat) {
        #expect(NSColor(hex: 0xAABBCC, alpha: alpha).alphaComponent == expected)
    }
}
#endif
