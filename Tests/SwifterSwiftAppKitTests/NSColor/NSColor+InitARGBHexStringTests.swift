// NSColor+InitARGBHexStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorInitARGBHexStringTests {
    @Test(
        arguments: [
            ("#80FF8000", 0x80, 0xFF, 0x80, 0x00),
            ("80FF8000", 0x80, 0xFF, 0x80, 0x00),
            ("0x80ff8000", 0x80, 0xFF, 0x80, 0x00),
            ("0X80FF8000", 0x80, 0xFF, 0x80, 0x00),
            ("#FFaBcDeF", 0xFF, 0xAB, 0xCD, 0xEF),
            ("#44112233", 0x44, 0x11, 0x22, 0x33),
            ("0x7F123456", 0x7F, 0x12, 0x34, 0x56),
            ("#8F80", 0x88, 0xFF, 0x88, 0x00),
            ("0xF0F0", 0xFF, 0x00, 0xFF, 0x00),
            ("#0F00", 0x00, 0xFF, 0x00, 0x00),
            ("#FF8000", 0xFF, 0xFF, 0x80, 0x00),
            ("1f2d3c", 0xFF, 0x1F, 0x2D, 0x3C),
            ("#F80", 0xFF, 0xFF, 0x88, 0x00),
            ("0x0F0", 0xFF, 0x00, 0xFF, 0x00),
            ("#000", 0xFF, 0x00, 0x00, 0x00),
            ("#FFFFFFFF", 0xFF, 0xFF, 0xFF, 0xFF),
            ("#00000000", 0x00, 0x00, 0x00, 0x00),
            ("#00FFFFFF", 0x00, 0xFF, 0xFF, 0xFF),
            ("#FF000000", 0xFF, 0x00, 0x00, 0x00)
        ] as [(String, Int, Int, Int, Int)])
    func parsesValidStrings(_ string: String, alpha: Int, red: Int, green: Int, blue: Int) throws {
        let color = try #require(NSColor(argbHexString: string))
        #expect(argb(of: color) == [alpha, red, green, blue])
    }

    @Test
    func readsEightDigitsAsAARRGGBB() throws {
        // `NSColor(hexString:)` reads the same string as CSS `RRGGBBAA`: red 0x11 and alpha 0x44.
        let color = try #require(NSColor(argbHexString: "#11223344"))
        #expect(argb(of: color) == [0x11, 0x22, 0x33, 0x44])
    }

    @Test
    func readsFourDigitsAsARGB() throws {
        let color = try #require(NSColor(argbHexString: "#1234"))
        #expect(argb(of: color) == [0x11, 0x22, 0x33, 0x44])
    }

    @Test
    func readsThreeAndSixDigitsAsOpaqueRGB() throws {
        let short = try #require(NSColor(argbHexString: "#123"))
        let long = try #require(NSColor(argbHexString: "#112233"))
        #expect(argb(of: short) == [0xFF, 0x11, 0x22, 0x33])
        #expect(argb(of: long) == [0xFF, 0x11, 0x22, 0x33])
    }

    @Test(arguments: [
        "", "#", "0x", "#F", "#FF", "#FFFFF", "#FFFFFFF", "FFFFFFF", "#FFFFFFFFF", "#FFFFFFFFFFFFFFFF",
        "#GGG", "4#fff", "##FFF", "#0xFFF", "0x#FFF", "0x0xFFF", "x0FFF",
        " #FFF", "#FFF ", "#FF FF", "#FFF\n", "#-FFF", "-FFF", "+FFF", "#+FF",
        "#\u{FF26}\u{FF26}\u{FF26}", "#F\u{301}FF", "#\u{1F3A8}\u{1F3A8}\u{1F3A8}", "#\u{1F1FA}\u{1F1F8}FF",
        "#FF\u{1F9D1}\u{200D}\u{1F4BB}F"
    ])
    func returnsNilForInvalidStrings(_ string: String) {
        #expect(NSColor(argbHexString: string) == nil)
    }

    @Test(arguments: ["#F", "#FF", "F", "12345", "1234567", "#FF0x00", "0x12340x5678", "#12#34", "FF#00"])
    func rejectsStringsThatSwifterSwift8Misread(_ string: String) {
        // SwifterSwift 8 deleted every "#" and "0x" in the string and doubled the digits of anything up to 4 digits
        // long, so "#F" was opaque blue, "#FF0x00" was opaque red and "12345" was #012345.
        #expect(NSColor(argbHexString: string) == nil)
    }

    @Test
    func createsAnSRGBColor() throws {
        #expect(try #require(NSColor(argbHexString: "#80123456")).colorSpace == .sRGB)
    }

    /// The color's alpha, red, green and blue components, scaled to `0...255` and rounded.
    private func argb(of color: NSColor) -> [Int] {
        [color.alphaComponent, color.redComponent, color.greenComponent, color.blueComponent].map {
            Int(($0 * 255).rounded())
        }
    }
}
#endif
