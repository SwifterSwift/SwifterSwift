// UIButton+SetBackgroundColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIButtonSetBackgroundColorTests {
    @Test
    func setsAOneByOneImageForTheState() throws {
        let button = UIButton(type: .custom)
        button.setBackgroundColor(.red, for: .highlighted)
        let image = try #require(button.backgroundImage(for: .highlighted))
        #expect(image.size == CGSize(width: 1, height: 1))
        #expect(image.scale == 1)
        let cgImage = try #require(image.cgImage)
        #expect(cgImage.width == 1)
        #expect(cgImage.height == 1)
    }

    @Test
    func fillsTheImageWithTheColor() throws {
        let button = UIButton(type: .custom)
        button.setBackgroundColor(UIColor(red: 0, green: 0, blue: 1, alpha: 1), for: .normal)
        let pixel = try pixel(of: button.backgroundImage(for: .normal))
        #expect(isClose(pixel, to: [0, 0, 255, 255]))
    }

    @Test
    func keepsTheAlphaOfTranslucentColors() throws {
        let button = UIButton(type: .custom)
        button.setBackgroundColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), for: .normal)
        let pixel = try pixel(of: button.backgroundImage(for: .normal))
        #expect(isClose(pixel, to: [128, 0, 0, 128]))
    }

    @Test
    func usesAClearImageForAClearColor() throws {
        let button = UIButton(type: .custom)
        button.setBackgroundColor(.clear, for: .normal)
        let pixel = try pixel(of: button.backgroundImage(for: .normal))
        #expect(pixel == [0, 0, 0, 0])
    }

    @Test
    func setsEachStateSeparately() throws {
        let button = UIButton(type: .custom)
        button.setBackgroundColor(UIColor(red: 1, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setBackgroundColor(UIColor(red: 0, green: 1, blue: 0, alpha: 1), for: .highlighted)
        button.setBackgroundColor(UIColor(red: 0, green: 0, blue: 1, alpha: 1), for: [.selected, .highlighted])
        #expect(isClose(try pixel(of: button.backgroundImage(for: .normal)), to: [255, 0, 0, 255]))
        #expect(isClose(try pixel(of: button.backgroundImage(for: .highlighted)), to: [0, 255, 0, 255]))
        #expect(isClose(try pixel(of: button.backgroundImage(for: [.selected, .highlighted])), to: [0, 0, 255, 255]))
        #expect(button.backgroundImage(for: .disabled) === button.backgroundImage(for: .normal))
    }

    @Test
    func replacesAnEarlierColor() throws {
        let button = UIButton(type: .custom)
        button.setBackgroundColor(.red, for: .normal)
        button.setBackgroundColor(UIColor(red: 0, green: 1, blue: 0, alpha: 1), for: .normal)
        #expect(isClose(try pixel(of: button.backgroundImage(for: .normal)), to: [0, 255, 0, 255]))
    }

    @Test(arguments: [UIUserInterfaceStyle.light, .dark])
    func resolvesDynamicColorsWithTheButtonsTraits(_ style: UIUserInterfaceStyle) throws {
        let button = UIButton(type: .custom)
        button.traitOverrides.userInterfaceStyle = style
        button.updateTraitsIfNeeded()
        let color = UIColor {
            $0.userInterfaceStyle == .dark
                ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        button.setBackgroundColor(color, for: .normal)
        let expected: [UInt8] = style == .dark ? [255, 255, 255, 255] : [0, 0, 0, 255]
        #expect(isClose(try pixel(of: button.backgroundImage(for: .normal)), to: expected))
    }

    @Test
    func leavesClippingAlone() {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 8
        button.setBackgroundColor(.red, for: .normal)
        #expect(!button.clipsToBounds)
        #expect(button.layer.cornerRadius == 8)
    }

    @Test
    func leavesTheConfigurationOfAConfiguredButtonAlone() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .green
        let button = UIButton(configuration: configuration)
        button.setBackgroundColor(.red, for: .normal)
        #expect(button.configuration?.baseBackgroundColor == .green)
        #expect(button.configuration?.background.image == nil)
    }

    /// Returns the 8-bit premultiplied sRGB components of the single pixel of the image.
    private func pixel(of image: UIImage?) throws -> [UInt8] {
        let cgImage = try #require(image?.cgImage)
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        try pixel.withUnsafeMutableBytes { buffer in
            let context = try #require(
                CGContext(
                    data: buffer.baseAddress, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4,
                    space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        return pixel
    }

    /// Whether every component is within 1 of the expected one, to allow for color space rounding.
    private func isClose(_ pixel: [UInt8], to expected: [UInt8]) -> Bool {
        pixel.count == expected.count && zip(pixel, expected).allSatisfy { abs(Int($0) - Int($1)) <= 1 }
    }
}
#endif
