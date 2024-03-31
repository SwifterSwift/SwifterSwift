// ColorExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(AppKit) || canImport(UIKit)

#if !os(watchOS)
import CoreImage
#endif

// swiftlint:disable:next type_body_length
final class ColorExtensionsTests: XCTestCase {
    // MARK: - Test properties

    func testCGFloatComponents() {
        XCTAssertEqual(SFColor.red.cgFloatComponents.red, 1.0)
        XCTAssertEqual(SFColor.red.cgFloatComponents.green, 0.0)
        XCTAssertEqual(SFColor.red.cgFloatComponents.blue, 0.0)

        XCTAssertEqual(SFColor.green.cgFloatComponents.red, 0.0)
        XCTAssertEqual(SFColor.green.cgFloatComponents.green, 1.0)
        XCTAssertEqual(SFColor.green.cgFloatComponents.blue, 0.0)

        XCTAssertEqual(SFColor.blue.cgFloatComponents.red, 0.0)
        XCTAssertEqual(SFColor.blue.cgFloatComponents.green, 0.0)
        XCTAssertEqual(SFColor.blue.cgFloatComponents.blue, 1.0)

        XCTAssertEqual(SFColor.black.cgFloatComponents.red, 0.0)
        XCTAssertEqual(SFColor.black.cgFloatComponents.green, 0.0)
        XCTAssertEqual(SFColor.black.cgFloatComponents.blue, 0.0)

        XCTAssertEqual(SFColor.white.cgFloatComponents.red, 1.0)
        XCTAssertEqual(SFColor.white.cgFloatComponents.green, 1.0)
        XCTAssertEqual(SFColor.white.cgFloatComponents.blue, 1.0)

        XCTAssertEqual(Int(SFColor(hex: 0x12FFFF)!.cgFloatComponents.red * 255.0), 0x12)
    }

    // MARK: - Test properties

    func testRgbComponents() {
        XCTAssertEqual(SFColor.red.rgbComponents.red, 255)
        XCTAssertEqual(SFColor.red.rgbComponents.green, 0)
        XCTAssertEqual(SFColor.red.rgbComponents.blue, 0)

        XCTAssertEqual(SFColor.green.rgbComponents.red, 0)
        XCTAssertEqual(SFColor.green.rgbComponents.green, 255)
        XCTAssertEqual(SFColor.green.rgbComponents.blue, 0)

        XCTAssertEqual(SFColor.blue.rgbComponents.red, 0)
        XCTAssertEqual(SFColor.blue.rgbComponents.green, 0)
        XCTAssertEqual(SFColor.blue.rgbComponents.blue, 255)

        XCTAssertEqual(SFColor.black.rgbComponents.red, 0)
        XCTAssertEqual(SFColor.black.rgbComponents.green, 0)
        XCTAssertEqual(SFColor.black.rgbComponents.blue, 0)

        XCTAssertEqual(SFColor.white.rgbComponents.red, 255)
        XCTAssertEqual(SFColor.white.rgbComponents.green, 255)
        XCTAssertEqual(SFColor.white.rgbComponents.blue, 255)

        XCTAssertEqual(SFColor(hex: 0x12FFFF)?.rgbComponents.red, 0x12)
    }

    func testAlpha() {
        var color = SFColor.red
        XCTAssertEqual(color.alpha, 1.0)

        color = SFColor.white.withAlphaComponent(0.5)
        XCTAssertEqual(color.alpha, 0.5)

        color = SFColor(red: 0, green: 0, blue: 0, transparency: 0.7)!
        XCTAssertEqual(color.alpha, 0.7)

        color = SFColor(red: 0, green: 0, blue: 0, transparency: 1.1)!
        XCTAssertEqual(color.alpha, 1.0)
    }

    #if !os(watchOS)
    func testCoreImageColor() {
        let color = SFColor.red
        let coreImageColor = color.coreImageColor
        XCTAssertNotNil(color.coreImageColor)
        XCTAssertEqual(color.coreImageColor!, coreImageColor)
    }
    #endif

    // MARK: - Test properties

    func testHsbaComponents() {
        var color = SFColor(hex: 0x00FF00, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 120.0 / 360.0, accuracy: 0.001)
        XCTAssertEqual(color.hsbaComponents.saturation, 1.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 1.0)

        color = SFColor(hex: 0x0000FF, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 240.0 / 360.0, accuracy: 0.001)
        XCTAssertEqual(color.hsbaComponents.saturation, 1.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 1.0)

        color = SFColor(hex: 0x000000, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 0.0)
        XCTAssertEqual(color.hsbaComponents.saturation, 0.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 0.0)

        color = SFColor(hex: 0xFFFFFF, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 0.0)
        XCTAssertEqual(color.hsbaComponents.saturation, 0.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 1.0)

        color = SFColor(hex: 0x123456, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 210.0 / 360.0, accuracy: 0.001)
        XCTAssertEqual((color.hsbaComponents.saturation * 100).rounded(), 79)
        XCTAssertEqual((color.hsbaComponents.brightness * 100).rounded(), 34)

        color = SFColor(hex: 0xFCA864, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 27.0 / 360.0, accuracy: 0.001)
        XCTAssertEqual((color.hsbaComponents.saturation * 100).rounded(), 60)
        XCTAssertEqual((color.hsbaComponents.brightness * 100).rounded(), 99)

        color = SFColor(hex: 0x1F2D3C, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 211.0 / 360.0, accuracy: 0.001)
        XCTAssertEqual((color.hsbaComponents.saturation * 100).rounded(), 48)
        XCTAssertEqual((color.hsbaComponents.brightness * 100).rounded(), 24)
    }

    func testUInt() {
        var color = SFColor(hex: 0xFF0000, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFF0000)

        color = SFColor(hex: 0x00FF00, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x00FF00)

        color = SFColor(hex: 0x0000FF, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x0000FF)

        color = SFColor(hex: 0x000000, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x000000)

        color = SFColor(hex: 0xFFFFFF, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFFFFFF)

        color = SFColor(hex: 0x123456, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x123456)

        color = SFColor(hex: 0xFCA864, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFCA864)

        color = SFColor(hex: 0xFCA864, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFCA864)

        color = SFColor(hex: 0x1F2D3C, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x1F2D3C)
    }

    func testHexString() {
        var color = SFColor.red
        XCTAssertEqual(color.hexString, "#FF0000")

        color = SFColor.blue
        XCTAssertEqual(color.hexString, "#0000FF")

        color = SFColor(hex: 0xABCDEF)!
        XCTAssertEqual(color.hexString, "#ABCDEF")

        color = SFColor(hex: 0xABC)!
        XCTAssertEqual(color.hexString, "#000ABC")

        color = SFColor.black
        XCTAssertEqual(color.hexString, "#000000")
    }

    func testShortHexString() {
        var color: SFColor? = SFColor.red
        XCTAssertEqual(color?.shortHexString, "#F00")

        color = SFColor.blue
        XCTAssertEqual(color?.shortHexString, "#00F")

        color = SFColor(hexString: "#0F120F")
        XCTAssertNil(color?.shortHexString)

        color = SFColor(hexString: "#8FFFF")
        XCTAssertNil(color?.shortHexString)
    }

    func testShortHexOrHexString() {
        var color: SFColor? = SFColor.red
        XCTAssertEqual(color?.shortHexOrHexString, "#F00")

        color = SFColor(hexString: "#8FFFFF")
        XCTAssertEqual(color?.shortHexOrHexString, "#8FFFFF")

        color = SFColor(hexString: "#F")
        XCTAssertEqual(color?.shortHexOrHexString, "#00000F")

        color = SFColor(hexString: "#11")
        XCTAssertEqual(color?.shortHexOrHexString, "#001")
    }

    func testComplementary() {
        var color = SFColor.black
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        color.complementary?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)

        color = SFColor.white
        color.complementary?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 0)
        XCTAssertEqual(blue, 0)

        color = SFColor.red
        color.complementary?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
    }

    func testRandom() {
        let color1 = SFColor.random
        let color2 = SFColor.random

        XCTAssertNotEqual(color1, color2)
    }

    // MARK: - Test methods

    func testBlend() {
        var color1 = SFColor.white
        var color2 = SFColor.black

        var blendColor = SFColor.blend(color1, with: color2)
        XCTAssertEqual(blendColor.rgbComponents.red, 0xFF / 2)
        XCTAssertEqual(blendColor.rgbComponents.green, 0xFF / 2)
        XCTAssertEqual(blendColor.rgbComponents.blue, 0xFF / 2)

        color1 = SFColor(hex: 0x123456, transparency: 0.5)!
        color2 = SFColor(hex: 0x665544, transparency: 0.7)!

        blendColor = SFColor.blend(color1, with: color2)
        XCTAssertEqual(blendColor.rgbComponents.red, (0x12 + 0x66) / 2)
        XCTAssertEqual(blendColor.rgbComponents.green, (0x34 + 0x55) / 2)
        XCTAssertEqual(blendColor.rgbComponents.blue, (0x56 + 0x44) / 2)
        XCTAssertEqual(blendColor.alpha, (0.7 + 0.5) / 2)

        blendColor = SFColor.blend(color1, intensity1: 0.7, with: color2, intensity2: 0.3)
        var output: Double = 0x12 * 0.7 + 0x66 * 0.3
        XCTAssertEqual(blendColor.rgbComponents.red, Int(output))
        output = 0x34 * 0.7 + 0x55 * 0.3
        XCTAssertEqual(blendColor.rgbComponents.green, Int(output))
        output = 0x56 * 0.7 + 0x44 * 0.3
        XCTAssertEqual(blendColor.rgbComponents.blue, Int(output))
        output = 0.5 * 0.7 + 0.7 * 0.3
        XCTAssertEqual(blendColor.alpha, CGFloat(output))

        blendColor = SFColor.blend(color1, intensity1: 0.0, with: color2, intensity2: 0.3)
        output = (0x12 * 0.0 + 0x66 * 0.3) / 0.3
        XCTAssertEqual(blendColor.rgbComponents.red, Int(output))
        output = (0x34 * 0.0 + 0x55 * 0.3) / 0.3
        XCTAssertEqual(blendColor.rgbComponents.green, Int(output))
        output = (0x56 * 0.0 + 0x44 * 0.3) / 0.3
        XCTAssertEqual(blendColor.rgbComponents.blue, Int(output))
        output = (0.5 * 0.0 + 0.7 * 0.3 / 0.3)
        XCTAssertEqual(blendColor.alpha, CGFloat(output))

        blendColor = SFColor.blend(color1, intensity1: 1.0, with: color2, intensity2: 0.0)
        XCTAssertEqual(blendColor, color1)
    }

    func testLighten() {
        let color = SFColor.blue
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)

        let lighterColor = color.lighten(by: 0.3)
        var lightR: CGFloat = 0, lightG: CGFloat = 0, lightB: CGFloat = 0
        lighterColor.getRed(&lightR, green: &lightG, blue: &lightB, alpha: nil)

        XCTAssertEqual(lightR, min(red + 0.3, 1.0))
        XCTAssertEqual(lightG, min(green + 0.3, 1.0))
        XCTAssertEqual(lightB, min(blue + 0.3, 1.0))
    }

    func testDarken() {
        let color = SFColor.blue
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)

        let darkerColor = color.darken(by: 0.3)
        var darkR: CGFloat = 0, darkG: CGFloat = 0, darkB: CGFloat = 0
        darkerColor.getRed(&darkR, green: &darkG, blue: &darkB, alpha: nil)

        XCTAssertEqual(darkR, max(red - 0.3, 0))
        XCTAssertEqual(darkG, max(green - 0.3, 0))
        XCTAssertEqual(darkB, max(blue - 0.3, 0))
    }

    // MARK: - Test initializers

    func testInit() {
        var color = SFColor(hex: 0xFFF)
        XCTAssertEqual(color?.rgbComponents.red, 0)
        XCTAssertEqual(color?.rgbComponents.green, 0xF)
        XCTAssertEqual(color?.rgbComponents.blue, 0xFF)
        XCTAssertEqual(color?.alpha, 1.0)

        color = SFColor(hex: 0xFFFFFFF)
        XCTAssertEqual(color?.rgbComponents.red, 0xFF)
        XCTAssertEqual(color?.rgbComponents.green, 0xFF)
        XCTAssertEqual(color?.rgbComponents.blue, 0xFF)
        XCTAssertEqual(color?.alpha, 1.0)

        color = SFColor(hex: 0x123456, transparency: 1.0)
        XCTAssertEqual(color?.rgbComponents.red, 0x12)
        XCTAssertEqual(color?.rgbComponents.green, 0x34)
        XCTAssertEqual(color?.rgbComponents.blue, 0x56)
        XCTAssertEqual(color?.alpha, 1.0)

        color = SFColor(hex: 0x999, transparency: 21.0)
        XCTAssertEqual(color?.rgbComponents.red, 0)
        XCTAssertEqual(color?.rgbComponents.green, 0x09)
        XCTAssertEqual(color?.rgbComponents.blue, 0x99)
        XCTAssertEqual(color?.alpha, 1.0)

        color = SFColor(hex: 0xAABBCC, transparency: 0.0)
        XCTAssertEqual(color?.rgbComponents.red, 0xAA)
        XCTAssertEqual(color?.rgbComponents.green, 0xBB)
        XCTAssertEqual(color?.rgbComponents.blue, 0xCC)
        XCTAssertEqual(color?.alpha, 0.0)

        color = SFColor(hex: 0x1, transparency: 0.5)
        XCTAssertEqual(color?.rgbComponents.red, 0)
        XCTAssertEqual(color?.rgbComponents.green, 0)
        XCTAssertEqual(color?.rgbComponents.blue, 1)
        XCTAssertEqual(color?.alpha, 0.5)
        let color1 = SFColor(hex: 0xFFF, transparency: -0.4)
        let color2 = SFColor(hex: 0xFFF, transparency: 0)
        XCTAssertEqual(color1, color2)

        let color3 = SFColor(hex: 0xFFF, transparency: 1.5)
        let color4 = SFColor(hex: 0xFFF, transparency: 1)
        XCTAssertEqual(color3, color4)
    }

    func testFailableInit() {
        var color = SFColor(hexString: "0xFFFFFF")
        XCTAssertNotNil(color)

        color = SFColor(hexString: "0XFFAABB")
        XCTAssertNotNil(color)

        color = SFColor(hexString: "#FFFFFF")
        XCTAssertNotNil(color)

        color = SFColor(hexString: "FFFFFF")
        XCTAssertNotNil(color)

        color = SFColor(hexString: "#ABC")
        XCTAssertNotNil(color)

        color = SFColor(hexString: "#GGG")
        XCTAssertNil(color)

        color = SFColor(hexString: "4#fff")
        XCTAssertNil(color)

        color = SFColor(hexString: "FFFFFFF")
        XCTAssertNotNil(color)
    }

    func testInitARGB() {
        var color = SFColor(argbHexString: "0xFFFF")
        XCTAssertNotNil(color)
        XCTAssertEqual(color!.rgbComponents.red, 0xFF)
        XCTAssertEqual(color!.rgbComponents.green, 0xFF)
        XCTAssertEqual(color!.rgbComponents.blue, 0xFF)
        XCTAssertEqual(color!.alpha, 1.0)

        color = SFColor(argbHexString: "#FFFFFFFFF")
        XCTAssertNotNil(color)
        XCTAssertEqual(color!.rgbComponents.red, 0xFF)
        XCTAssertEqual(color!.rgbComponents.green, 0xFF)
        XCTAssertEqual(color!.rgbComponents.blue, 0xFF)
        XCTAssertEqual(color!.alpha, 1.0)

        color = SFColor(argbHexString: "7F123456")
        XCTAssertNotNil(color)
        XCTAssertEqual(color!.rgbComponents.red, 0x12)
        XCTAssertEqual(color!.rgbComponents.green, 0x34)
        XCTAssertEqual(color!.rgbComponents.blue, 0x56)
        XCTAssertEqual(color!.alpha, 0.5, accuracy: 0.01)

        color = SFColor(argbHexString: "#9999")
        XCTAssertNotNil(color)
        XCTAssertEqual(color!.rgbComponents.red, 0x99)
        XCTAssertEqual(color!.rgbComponents.green, 0x99)
        XCTAssertEqual(color!.rgbComponents.blue, 0x99)
        XCTAssertEqual(color!.alpha, 0.6)
    }

    func testInitWithComponents() {
        var red1: CGFloat = 0
        var red2: CGFloat = 0
        var green1: CGFloat = 0
        var green2: CGFloat = 0
        var blue1: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha1: CGFloat = 0
        var alpha2: CGFloat = 0

        var color1 = SFColor(red: 255, green: 244, blue: 255, transparency: 2.0)
        var color2 = SFColor(red: 1.0, green: 244.0 / 255.0, blue: 1.0, alpha: 1.0)
        color1?.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)

        color1 = SFColor(red: 25, green: 244, blue: 55, transparency: -1.0)
        color2 = SFColor(red: 25.0 / 255.0, green: 244.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.0)
        color1?.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)

        color1 = SFColor(red: 2, green: 4, blue: 5)
        color2 = SFColor(red: 2.0 / 255.0, green: 4.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
        color1?.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)
    }

    func testFailableInitWithComponents() {
        let color1 = SFColor(red: 258, green: 0, blue: 0)
        XCTAssertNil(color1)

        let color2 = SFColor(red: 0, green: 258, blue: 0)
        XCTAssertNil(color2)

        let color3 = SFColor(red: 0, green: 0, blue: 258)
        XCTAssertNil(color3)

        let color4 = SFColor(red: 258, green: 258, blue: 258)
        XCTAssertNil(color4)
    }

    func testFailableInitWithComplementaryColor() {
        var color = SFColor(complementaryFor: SFColor.black)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0

        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)

        color = SFColor(complementaryFor: SFColor.red)
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
    }
}

#endif
