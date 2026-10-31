// NSColor+InitHexStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorInitHexStringTests {
    @Test(
        arguments: [
            ("#FF8000", 0xFF, 0x80, 0x00, 0xFF),
            ("FF8000", 0xFF, 0x80, 0x00, 0xFF),
            ("0xff8000", 0xFF, 0x80, 0x00, 0xFF),
            ("0XFF8000", 0xFF, 0x80, 0x00, 0xFF),
            ("#aBcDeF", 0xAB, 0xCD, 0xEF, 0xFF),
            ("#F80", 0xFF, 0x88, 0x00, 0xFF),
            ("0x0F0", 0x00, 0xFF, 0x00, 0xFF),
            ("#F808", 0xFF, 0x88, 0x00, 0x88),
            ("#11223344", 0x11, 0x22, 0x33, 0x44),
            ("0x7F123456", 0x7F, 0x12, 0x34, 0x56),
            ("#000", 0x00, 0x00, 0x00, 0xFF),
            ("#FFFFFFFF", 0xFF, 0xFF, 0xFF, 0xFF),
            ("#00000000", 0x00, 0x00, 0x00, 0x00)
        ] as [(String, Int, Int, Int, Int)])
    func parsesValidStrings(_ string: String, red: Int, green: Int, blue: Int, alpha: Int) throws {
        let color = try #require(NSColor(hexString: string))
        #expect(Int((color.redComponent * 255).rounded()) == red)
        #expect(Int((color.greenComponent * 255).rounded()) == green)
        #expect(Int((color.blueComponent * 255).rounded()) == blue)
        #expect(Int((color.alphaComponent * 255).rounded()) == alpha)
    }

    @Test
    func readsEightDigitsAsRRGGBBAA() throws {
        // SwifterSwift 8 dropped the first pair and read "#11223344" as #223344.
        let color = try #require(NSColor(hexString: "#11223344"))
        #expect(Int((color.redComponent * 255).rounded()) == 0x11)
        #expect(Int((color.alphaComponent * 255).rounded()) == 0x44)
    }

    @Test(arguments: [
        "", "#", "0x", "#F", "#FF", "#FFFFF", "#FFFFFFF", "FFFFFFF", "#FFFFFFFFF", "#FFFFFFFFFFFFFFFF",
        "#GGG", "4#fff", "##FFF", "#0xFFF", "0x#FFF", "0x0xFFF", "x0FFF",
        " #FFF", "#FFF ", "#FF FF", "#FFF\n", "#-FFF", "-FFF", "+FFF", "#+FF",
        "#\u{FF26}\u{FF26}\u{FF26}", "#F\u{301}FF", "#\u{1F3A8}\u{1F3A8}\u{1F3A8}", "#\u{1F1FA}\u{1F1F8}FF",
        "#FF\u{1F9D1}\u{200D}\u{1F4BB}F"
    ])
    func returnsNilForInvalidStrings(_ string: String) {
        #expect(NSColor(hexString: string) == nil)
    }

    @Test
    func createsAnSRGBColor() throws {
        #expect(try #require(NSColor(hexString: "#123456")).colorSpace == .sRGB)
    }
}
#endif
