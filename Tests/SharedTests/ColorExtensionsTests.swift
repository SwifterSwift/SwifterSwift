//
//  ColorExtensionsTests.swift
//  SwifterSwift
//
//  Created by Ewelina on 25/01/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) || canImport(Cocoa)

#if os(macOS)
import Cocoa
public typealias Color = NSColor
#else
import UIKit
public typealias Color = UIColor
#endif

#if !os(watchOS)
import CoreImage
#endif

// swiftlint:disable:next type_body_length
final class ColorExtensionsTests: XCTestCase {

    // MARK: - Test properties
    func testCGFloatComponents() {
        XCTAssertEqual(Color.red.cgFloatComponents.red, 1.0)
        XCTAssertEqual(Color.red.cgFloatComponents.green, 0.0)
        XCTAssertEqual(Color.red.cgFloatComponents.blue, 0.0)

        XCTAssertEqual(Color.green.cgFloatComponents.red, 0.0)
        XCTAssertEqual(Color.green.cgFloatComponents.green, 1.0)
        XCTAssertEqual(Color.green.cgFloatComponents.blue, 0.0)

        XCTAssertEqual(Color.blue.cgFloatComponents.red, 0.0)
        XCTAssertEqual(Color.blue.cgFloatComponents.green, 0.0)
        XCTAssertEqual(Color.blue.cgFloatComponents.blue, 1.0)

        XCTAssertEqual(Color.black.cgFloatComponents.red, 0.0)
        XCTAssertEqual(Color.black.cgFloatComponents.green, 0.0)
        XCTAssertEqual(Color.black.cgFloatComponents.blue, 0.0)

        XCTAssertEqual(Color.white.cgFloatComponents.red, 1.0)
        XCTAssertEqual(Color.white.cgFloatComponents.green, 1.0)
        XCTAssertEqual(Color.white.cgFloatComponents.blue, 1.0)

        XCTAssertEqual(Int(Color(hex: 0x12FFFF)!.cgFloatComponents.red * 255.0), 0x12)
    }

    // MARK: - Test properties
    func testRgbComponents() {
        XCTAssertEqual(Color.red.rgbComponents.red, 255)
        XCTAssertEqual(Color.red.rgbComponents.green, 0)
        XCTAssertEqual(Color.red.rgbComponents.blue, 0)

        XCTAssertEqual(Color.green.rgbComponents.red, 0)
        XCTAssertEqual(Color.green.rgbComponents.green, 255)
        XCTAssertEqual(Color.green.rgbComponents.blue, 0)

        XCTAssertEqual(Color.blue.rgbComponents.red, 0)
        XCTAssertEqual(Color.blue.rgbComponents.green, 0)
        XCTAssertEqual(Color.blue.rgbComponents.blue, 255)

        XCTAssertEqual(Color.black.rgbComponents.red, 0)
        XCTAssertEqual(Color.black.rgbComponents.green, 0)
        XCTAssertEqual(Color.black.rgbComponents.blue, 0)

        XCTAssertEqual(Color.white.rgbComponents.red, 255)
        XCTAssertEqual(Color.white.rgbComponents.green, 255)
        XCTAssertEqual(Color.white.rgbComponents.blue, 255)

        XCTAssertEqual(Color(hex: 0x12FFFF)?.rgbComponents.red, 0x12)
    }

    func testAlpha() {
        var color: Color = Color.red
        XCTAssertEqual(color.alpha, 1.0)

        color = Color.white.withAlphaComponent(0.5)
        XCTAssertEqual(color.alpha, 0.5)

        color = Color(red: 0, green: 0, blue: 0, transparency: 0.7)!
        XCTAssertEqual(color.alpha, 0.7)

        color = Color(red: 0, green: 0, blue: 0, transparency: 1.1)!
        XCTAssertEqual(color.alpha, 1.0)
    }

    #if !os(watchOS)
    func testCoreImageColor() {
        let color = Color.red
        let coreImageColor = color.coreImageColor
        XCTAssertNotNil(color.coreImageColor)
        XCTAssertEqual(color.coreImageColor!, coreImageColor)
    }
    #endif

    // MARK: - Test properties
    func testHsbaComponents() {
        var color = Color(hex: 0x00FF00, transparency: 1.0)!
        XCTAssertEqual(CGFloat(round(1000 * color.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (120/360)) / 1000))
        XCTAssertEqual(color.hsbaComponents.saturation, 1.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 1.0)

        color = Color(hex: 0x0000FF, transparency: 1.0)!
        XCTAssertEqual(CGFloat(round(1000 * color.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (240/360)) / 1000))
        XCTAssertEqual(color.hsbaComponents.saturation, 1.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 1.0)

        color = Color(hex: 0x000000, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 0.0)
        XCTAssertEqual(color.hsbaComponents.saturation, 0.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 0.0)

        color = Color(hex: 0xFFFFFF, transparency: 1.0)!
        XCTAssertEqual(color.hsbaComponents.hue, 0.0)
        XCTAssertEqual(color.hsbaComponents.saturation, 0.0)
        XCTAssertEqual(color.hsbaComponents.brightness, 1.0)

        color = Color(hex: 0x123456, transparency: 1.0)!
        XCTAssertEqual(CGFloat(round(1000 * color.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (210/360)) / 1000))
        XCTAssertEqual((color.hsbaComponents.saturation * 100).rounded(), 79)
        XCTAssertEqual((color.hsbaComponents.brightness * 100).rounded(), 34)

        color = Color(hex: 0xFCA864, transparency: 1.0)!
        XCTAssertEqual(CGFloat(round(1000 * color.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (27/360)) / 1000))
        XCTAssertEqual((color.hsbaComponents.saturation * 100).rounded(), 60)
        XCTAssertEqual((color.hsbaComponents.brightness * 100).rounded(), 99)

        color = Color(hex: 0x1F2D3C, transparency: 1.0)!
        XCTAssertEqual(CGFloat(round(1000 * color.hsbaComponents.hue) / 1000), CGFloat(round(1000 * (211/360)) / 1000))
        XCTAssertEqual((color.hsbaComponents.saturation * 100).rounded(), 48)
        XCTAssertEqual((color.hsbaComponents.brightness * 100).rounded(), 24)
    }

    func testUInt() {
        var color = Color(hex: 0xFF0000, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFF0000)

        color = Color(hex: 0x00FF00, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x00FF00)

        color = Color(hex: 0x0000FF, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x0000FF)

        color = Color(hex: 0x000000, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x000000)

        color = Color(hex: 0xFFFFFF, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFFFFFF)

        color = Color(hex: 0x123456, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x123456)

        color = Color(hex: 0xFCA864, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFCA864)

        color = Color(hex: 0xFCA864, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0xFCA864)

        color = Color(hex: 0x1F2D3C, transparency: 1.0)
        XCTAssertEqual(color?.uInt, 0x1F2D3C)
    }

    func testHexString() {
        var color = Color.red
        XCTAssertEqual(color.hexString, "#FF0000")

        color = Color.blue
        XCTAssertEqual(color.hexString, "#0000FF")

        color = Color(hex: 0xABCDEF)!
        XCTAssertEqual(color.hexString, "#ABCDEF")

        color = Color(hex: 0xABC)!
        XCTAssertEqual(color.hexString, "#000ABC")

        color = Color.black
        XCTAssertEqual(color.hexString, "#000000")
    }

    func testShortHexString() {
        var color: Color? = Color.red
        XCTAssertEqual(color?.shortHexString, "#F00")

        color = Color.blue
        XCTAssertEqual(color?.shortHexString, "#00F")

        color = Color(hexString: "#0F120F")
        XCTAssertNil(color?.shortHexString)

        color = Color(hexString: "#8FFFF")
        XCTAssertNil(color?.shortHexString)
    }

    func testShortHexOrHexString() {
        var color: Color? = Color.red
        XCTAssertEqual(color?.shortHexOrHexString, "#F00")

        color = Color(hexString: "#8FFFFF")
        XCTAssertEqual(color?.shortHexOrHexString, "#8FFFFF")

        color = Color(hexString: "#F")
        XCTAssertEqual(color?.shortHexOrHexString, "#00000F")

        color = Color(hexString: "#11")
        XCTAssertEqual(color?.shortHexOrHexString, "#001")
    }

    func testComplementary() {
        var color = Color.black
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        color.complementary?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)

        color = Color.white
        color.complementary?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 0)
        XCTAssertEqual(blue, 0)

        color = Color.red
        color.complementary?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
    }

    func testRandom() {
        let color1 = Color.random
        let color2 = Color.random

        XCTAssertNotEqual(color1, color2)
    }

    // MARK: - Test methods
    func testBlend() {
        var color1 = Color.white
        var color2 = Color.black

        var blendColor = Color.blend(color1, with: color2)
        XCTAssertEqual(blendColor.rgbComponents.red, 0xFF / 2)
        XCTAssertEqual(blendColor.rgbComponents.green, 0xFF / 2)
        XCTAssertEqual(blendColor.rgbComponents.blue, 0xFF / 2)

        color1 = Color(hex: 0x123456, transparency: 0.5)!
        color2 = Color(hex: 0x665544, transparency: 0.7)!

        blendColor = Color.blend(color1, with: color2)
        XCTAssertEqual(blendColor.rgbComponents.red, (0x12 + 0x66) / 2)
        XCTAssertEqual(blendColor.rgbComponents.green, (0x34 + 0x55) / 2)
        XCTAssertEqual(blendColor.rgbComponents.blue, (0x56 + 0x44) / 2)
        XCTAssertEqual(blendColor.alpha, (0.7 + 0.5) / 2)

        blendColor = Color.blend(color1, intensity1: 0.7, with: color2, intensity2: 0.3)
        var output: Double = 0x12 * 0.7 + 0x66 * 0.3
        XCTAssertEqual(blendColor.rgbComponents.red, Int(output))
        output = 0x34 * 0.7 + 0x55 * 0.3
        XCTAssertEqual(blendColor.rgbComponents.green, Int(output))
        output = 0x56 * 0.7 + 0x44 * 0.3
        XCTAssertEqual(blendColor.rgbComponents.blue, Int(output))
        output = 0.5 * 0.7 + 0.7 * 0.3
        XCTAssertEqual(blendColor.alpha, CGFloat(output))

        blendColor = Color.blend(color1, intensity1: 0.0, with: color2, intensity2: 0.3)
        output = (0x12 * 0.0 + 0x66 * 0.3) / 0.3
        XCTAssertEqual(blendColor.rgbComponents.red, Int(output))
        output = (0x34 * 0.0 + 0x55 * 0.3) / 0.3
        XCTAssertEqual(blendColor.rgbComponents.green, Int(output))
        output = (0x56 * 0.0 + 0x44 * 0.3) / 0.3
        XCTAssertEqual(blendColor.rgbComponents.blue, Int(output))
        output = (0.5 * 0.0 + 0.7 * 0.3 / 0.3)
        XCTAssertEqual(blendColor.alpha, CGFloat(output))

        blendColor = Color.blend(color1, intensity1: 1.0, with: color2, intensity2: 0.0)
        XCTAssertEqual(blendColor, color1)
    }

    func testLighten() {
        let color = Color.blue
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
        let color = Color.blue
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
        var color = Color(hex: 0xFFF)
        XCTAssertEqual(color?.rgbComponents.red, 0)
        XCTAssertEqual(color?.rgbComponents.green, 0xf)
        XCTAssertEqual(color?.rgbComponents.blue, 0xff)
        XCTAssertEqual(color?.alpha, 1.0)

        color = Color(hex: 0xFFFFFFF)
        XCTAssertEqual(color?.rgbComponents.red, 0xff)
        XCTAssertEqual(color?.rgbComponents.green, 0xff)
        XCTAssertEqual(color?.rgbComponents.blue, 0xff)
        XCTAssertEqual(color?.alpha, 1.0)

        color = Color(hex: 0x123456, transparency: 1.0)
        XCTAssertEqual(color?.rgbComponents.red, 0x12)
        XCTAssertEqual(color?.rgbComponents.green, 0x34)
        XCTAssertEqual(color?.rgbComponents.blue, 0x56)
        XCTAssertEqual(color?.alpha, 1.0)

        color = Color(hex: 0x999, transparency: 21.0)
        XCTAssertEqual(color?.rgbComponents.red, 0)
        XCTAssertEqual(color?.rgbComponents.green, 0x09)
        XCTAssertEqual(color?.rgbComponents.blue, 0x99)
        XCTAssertEqual(color?.alpha, 1.0)

        color = Color(hex: 0xaabbcc, transparency: 0.0)
        XCTAssertEqual(color?.rgbComponents.red, 0xaa)
        XCTAssertEqual(color?.rgbComponents.green, 0xbb)
        XCTAssertEqual(color?.rgbComponents.blue, 0xcc)
        XCTAssertEqual(color?.alpha, 0.0)

        color = Color(hex: 0x1, transparency: 0.5)
        XCTAssertEqual(color?.rgbComponents.red, 0)
        XCTAssertEqual(color?.rgbComponents.green, 0)
        XCTAssertEqual(color?.rgbComponents.blue, 1)
        XCTAssertEqual(color?.alpha, 0.5)
        let color1 = Color(hex: 0xFFF, transparency: -0.4)
        let color2 = Color(hex: 0xFFF, transparency: 0)
        XCTAssertEqual(color1, color2)

        let color3 = Color(hex: 0xFFF, transparency: 1.5)
        let color4 = Color(hex: 0xFFF, transparency: 1)
        XCTAssertEqual(color3, color4)
    }

    func testFailableInit() {
        var color = Color(hexString: "0xFFFFFF")
        XCTAssertNotNil(color)

        color = Color(hexString: "#FFFFFF")
        XCTAssertNotNil(color)

        color = Color(hexString: "FFFFFF")
        XCTAssertNotNil(color)

        color = Color(hexString: "#ABC")
        XCTAssertNotNil(color)

        color = Color(hexString: "#GGG")
        XCTAssertNil(color)

        color = Color(hexString: "4#fff")
        XCTAssertNil(color)

        color = Color(hexString: "FFFFFFF")
        XCTAssertNotNil(color)
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

        var color1 = Color(red: 255, green: 244, blue: 255, transparency: 2.0)
        var color2 = Color(red: 1.0, green: 244.0 / 255.0, blue: 1.0, alpha: 1.0)
        color1?.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)

        color1 = Color(red: 25, green: 244, blue: 55, transparency: -1.0)
        color2 = Color(red: 25.0 / 255.0, green: 244.0 / 255.0, blue: 55.0 / 255.0, alpha: 0.0)
        color1?.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)

        color1 = Color(red: 2, green: 4, blue: 5)
        color2 = Color(red: 2.0 / 255.0, green: 4.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
        color1?.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        XCTAssertEqual(red1, red2)
        XCTAssertEqual(green1, green2)
        XCTAssertEqual(blue1, blue2)
        XCTAssertEqual(alpha1, alpha2)
    }

    func testFailableInitWithComponents() {
        let color1 = Color(red: 258, green: 0, blue: 0)
        XCTAssertNil(color1)

        let color2 = Color(red: 0, green: 258, blue: 0)
        XCTAssertNil(color2)

        let color3 = Color(red: 0, green: 0, blue: 258)
        XCTAssertNil(color3)

        let color4 = Color(red: 258, green: 258, blue: 258)
        XCTAssertNil(color4)

    }

    func testFailableInitWithComplementaryColor() {
        var color = Color(complementaryFor: Color.black)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0

        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)

        color = Color(complementaryFor: Color.red)
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
    }

}

#endif
