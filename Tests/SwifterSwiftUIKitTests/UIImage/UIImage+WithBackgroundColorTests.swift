// UIImage+WithBackgroundColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageWithBackgroundColorTests {
    @Test
    func fillsTransparentPixels() throws {
        let image = makeImage(width: 2, height: 2) { _ in }
        let pixels = try pixels(of: image.withBackgroundColor(.black))
        #expect(pixels.allSatisfy { row in row.allSatisfy { $0 == [0, 0, 0, 255] } })
    }

    @Test
    func keepsOpaquePixels() throws {
        let image = makeImage(width: 2, height: 1) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        let row = try pixels(of: image.withBackgroundColor(.blue))[0]
        #expect(isClose(row[0], to: [255, 0, 0, 255]))
        #expect(isClose(row[1], to: [0, 0, 255, 255]))
    }

    @Test
    func blendsTranslucentPixelsWithTheBackground() throws {
        let image = makeImage(width: 1, height: 1) { context in
            UIColor(red: 1, green: 0, blue: 0, alpha: 0.5).setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        #expect(isClose(try pixels(of: image.withBackgroundColor(.white))[0][0], to: [255, 128, 128, 255]))
    }

    @Test
    func keepsATranslucentBackgroundTranslucent() throws {
        let image = makeImage(width: 1, height: 1) { _ in }
        let flattened = image.withBackgroundColor(UIColor(red: 0, green: 0, blue: 1, alpha: 0.5))
        #expect(isClose(try pixels(of: flattened)[0][0], to: [0, 0, 128, 128]))
    }

    @Test(arguments: [CGFloat(1), 2, 3])
    func keepsTheSizeAndScale(_ scale: CGFloat) {
        let image = makeImage(width: 5, height: 3, scale: scale) { _ in }
        let flattened = image.withBackgroundColor(.white)
        #expect(flattened.size == image.size)
        #expect(flattened.scale == scale)
    }

    @Test
    func returnsAnImageWithoutAreaUnchanged() {
        let image = UIImage()
        #expect(image.withBackgroundColor(.white) === image)
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
