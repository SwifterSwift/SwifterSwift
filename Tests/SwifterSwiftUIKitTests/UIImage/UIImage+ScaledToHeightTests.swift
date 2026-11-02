// UIImage+ScaledToHeightTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageScaledToHeightTests {
    @Test
    func keepsTheAspectRatio() {
        let image = makeImage(width: 300, height: 200) { _ in }
        #expect(image.scaled(toHeight: 100)?.size == CGSize(width: 150, height: 100))
        #expect(image.scaled(toHeight: 400)?.size == CGSize(width: 600, height: 400))
    }

    @Test(arguments: [CGFloat(1), 2, 3])
    func keepsTheScale(_ scale: CGFloat) throws {
        let image = makeImage(width: 300, height: 200, scale: scale) { _ in }
        let scaled = try #require(image.scaled(toHeight: 100))
        #expect(scaled.scale == scale)
        #expect(scaled.size == CGSize(width: 150, height: 100))
        #expect(scaled.cgImage?.width == Int(150 * scale))
    }

    @Test
    func drawsTheImage() throws {
        let image = makeImage(width: 4, height: 2) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 2, height: 2))
            UIColor.blue.setFill()
            context.fill(CGRect(x: 2, y: 0, width: 2, height: 2))
        }
        let scaled = try #require(image.scaled(toHeight: 1))
        #expect(scaled.size == CGSize(width: 2, height: 1))
        let row = try pixels(of: scaled)[0]
        #expect(isClose(row[0], to: [255, 0, 0, 255], tolerance: 40))
        #expect(isClose(row[1], to: [0, 0, 255, 255], tolerance: 40))
    }

    @Test
    func keepsTransparencyByDefault() throws {
        let image = makeImage(width: 4, height: 4) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 4, height: 2))
        }
        let scaled = try #require(image.scaled(toHeight: 8))
        let pixels = try pixels(of: scaled)
        #expect(isClose(pixels[0][0], to: [255, 0, 0, 255]))
        #expect(pixels[7][0] == [0, 0, 0, 0])
    }

    @Test
    func dropsTheAlphaChannelWhenOpaque() throws {
        let image = makeImage(width: 4, height: 4) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 4, height: 2))
        }
        let scaled = try #require(image.scaled(toHeight: 8, opaque: true))
        let alphaInfo = try #require(scaled.cgImage?.alphaInfo)
        #expect([.none, .noneSkipFirst, .noneSkipLast].contains(alphaInfo))
        let pixels = try pixels(of: scaled)
        #expect(isClose(pixels[0][0], to: [255, 0, 0, 255]))
        #expect(pixels[7][0] == [0, 0, 0, 255])
    }

    @Test
    func keepsTheRenderingMode() {
        let image = makeImage(width: 4, height: 4) { _ in }.withRenderingMode(.alwaysTemplate)
        #expect(image.scaled(toHeight: 2)?.renderingMode == .alwaysTemplate)
    }

    @Test(arguments: [CGFloat(0), -1, -CGFloat.infinity, CGFloat.infinity, CGFloat.nan])
    func returnsNilForInvalidHeight(_ height: CGFloat) {
        let image = makeImage(width: 4, height: 4) { _ in }
        #expect(image.scaled(toHeight: height) == nil)
    }

    @Test
    func returnsNilForImageWithoutArea() {
        #expect(UIImage().scaled(toHeight: 10) == nil)
    }

    /// Returns an image drawn by `actions` into an 8-bit sRGB bitmap, with UIKit's top-left origin and the bitmap as the
    /// current UIKit context. It uses Core Graphics directly, since watchOS doesn't have `UIGraphicsImageRenderer`.
    private func makeImage(
        width: CGFloat, height: CGFloat, scale: CGFloat = 1, opaque: Bool = false, actions: (CGContext) -> Void
    ) -> UIImage {
        let pixelWidth = Int((width * scale).rounded(.up))
        let pixelHeight = Int((height * scale).rounded(.up))
        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: pixelWidth, height: pixelHeight, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: (opaque ? CGImageAlphaInfo.noneSkipLast : .premultipliedLast).rawValue)
        else { return UIImage() }
        context.translateBy(x: 0, y: CGFloat(pixelHeight))
        context.scaleBy(x: scale, y: -scale)
        UIGraphicsPushContext(context)
        actions(context)
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else { return UIImage() }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
    }

    /// Returns the premultiplied 8-bit sRGB components of every pixel as the image is displayed, by row from the
    /// top-left corner.
    private func pixels(of image: UIImage) throws -> [[[Int]]] {
        let width = Int((image.size.width * image.scale).rounded())
        let height = Int((image.size.height * image.scale).rounded())
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let context = try #require(
            CGContext(
                data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.interpolationQuality = .none
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: image.scale, y: -image.scale)
        UIGraphicsPushContext(context)
        image.draw(at: .zero)
        UIGraphicsPopContext()
        let data = try #require(context.data).assumingMemoryBound(to: UInt8.self)
        return (0..<height).map { y in
            (0..<width).map { x in (0..<4).map { Int(data[(y * width + x) * 4 + $0]) } }
        }
    }

    /// Returns whether two pixels match, allowing for rounding in each component.
    private func isClose(_ pixel: [Int], to expected: [Int], tolerance: Int = 2) -> Bool {
        pixel.count == expected.count && zip(pixel, expected).allSatisfy { abs($0 - $1) <= tolerance }
    }
}
#endif
