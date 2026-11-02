// UIView+ScreenshotTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewScreenshotTests {
    /// Returns the average RGBA color of the given part of an image, as 8-bit components.
    func color(of image: UIImage, in rect: CGRect) throws -> [UInt8] {
        let cgImage = try #require(image.cgImage)
        let pixelRect = CGRect(
            x: rect.minX * image.scale,
            y: rect.minY * image.scale,
            width: rect.width * image.scale,
            height: rect.height * image.scale
        )
        let cropped = try #require(cgImage.cropping(to: pixelRect))
        var pixel: [UInt8] = [0, 0, 0, 0]
        let drawn = pixel.withUnsafeMutableBytes { buffer in
            let context = CGContext(
                data: buffer.baseAddress,
                width: 1,
                height: 1,
                bitsPerComponent: 8,
                bytesPerRow: 4,
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            )
            context?.draw(cropped, in: CGRect(x: 0, y: 0, width: 1, height: 1))
            return context != nil
        }
        try #require(drawn)
        return pixel
    }

    @Test
    func rendersViewWithoutWindow() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        view.backgroundColor = .red
        let image = try #require(view.screenshot())
        #expect(image.size == CGSize(width: 20, height: 10))
        #expect(try color(of: image, in: CGRect(x: 0, y: 0, width: 20, height: 10)) == [255, 0, 0, 255])
    }

    @Test
    func includesSubviews() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        view.backgroundColor = .red
        let subview = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 10))
        subview.backgroundColor = .blue
        view.addSubview(subview)
        let image = try #require(view.screenshot())
        #expect(try color(of: image, in: CGRect(x: 0, y: 0, width: 10, height: 10)) == [255, 0, 0, 255])
        #expect(try color(of: image, in: CGRect(x: 10, y: 0, width: 10, height: 10)) == [0, 0, 255, 255])
    }

    @Test
    func usesBoundsOfTransformedView() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        view.backgroundColor = .red
        view.transform = CGAffineTransform(rotationAngle: .pi / 4).scaledBy(x: 2, y: 2)
        let image = try #require(view.screenshot())
        #expect(image.size == CGSize(width: 40, height: 20))
        #expect(try color(of: image, in: CGRect(x: 0, y: 0, width: 40, height: 20)) == [255, 0, 0, 255])
    }

    @Test
    func usesBoundsOriginOfScrolledView() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        view.bounds.origin = CGPoint(x: 10, y: 0)
        let subview = UIView(frame: CGRect(x: 10, y: 0, width: 20, height: 10))
        subview.backgroundColor = .blue
        view.addSubview(subview)
        let image = try #require(view.screenshot())
        #expect(image.size == CGSize(width: 20, height: 10))
        #expect(try color(of: image, in: CGRect(x: 0, y: 0, width: 20, height: 10)) == [0, 0, 255, 255])
    }

    @Test(arguments: [CGFloat(1), 2, 3])
    func usesDisplayScaleOfTraitCollection(_ scale: CGFloat) throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        view.traitOverrides.displayScale = scale
        view.updateTraitsIfNeeded()
        let image = try #require(view.screenshot())
        #expect(image.scale == view.traitCollection.displayScale)
        #expect(image.cgImage?.width == Int(20 * view.traitCollection.displayScale))
    }

    @Test(arguments: [
        CGRect.zero,
        CGRect(x: 0, y: 0, width: 0, height: 10),
        CGRect(x: 0, y: 0, width: 10, height: 0),
        CGRect(x: 5, y: 5, width: 0, height: 0)
    ])
    func returnsNilForViewWithoutArea(_ frame: CGRect) {
        #expect(UIView(frame: frame).screenshot() == nil)
    }

    @Test(
        .disabled(
            if: ProcessInfo.processInfo.isMacCatalystApp,
            "Mac Catalyst test runners have no NSApplication for a UIWindow"))
    func rendersViewInWindow() throws {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 20, height: 10))
        view.backgroundColor = .red
        window.addSubview(view)
        let image = try #require(view.screenshot())
        #expect(image.size == CGSize(width: 20, height: 10))
        #expect(try color(of: image, in: CGRect(x: 0, y: 0, width: 20, height: 10)) == [255, 0, 0, 255])
    }
}
#endif
