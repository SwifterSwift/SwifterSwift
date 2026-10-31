// UIImage+InitColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageInitColorTests {
    @Test(arguments: [
        CGSize(width: 1, height: 1),
        CGSize(width: 20, height: 10),
        CGSize(width: 3, height: 7)
    ])
    func createsImageOfGivenSize(_ size: CGSize) throws {
        let image = UIImage(color: .red, size: size)
        #expect(image.size == size)
        #expect(image.scale == 1)
        let cgImage = try #require(image.cgImage)
        #expect(cgImage.width == Int(size.width))
        #expect(cgImage.height == Int(size.height))
    }

    @Test
    func fillsEveryPixelWithTheColor() throws {
        let image = UIImage(color: UIColor(red: 0, green: 0, blue: 1, alpha: 1), size: CGSize(width: 3, height: 2))
        for row in try pixels(of: image) {
            for pixel in row {
                #expect(pixel == [0, 0, 255, 255])
            }
        }
    }

    @Test
    func keepsTheAlphaOfTranslucentColors() throws {
        let image = UIImage(color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), size: CGSize(width: 2, height: 2))
        let pixel = try pixels(of: image)[0][0]
        #expect(abs(pixel[3] - 128) <= 1)
        #expect(abs(pixel[0] - 128) <= 1)
    }

    @Test
    func roundsFractionalSizesUpToWholePixels() throws {
        let image = UIImage(color: .red, size: CGSize(width: 2.5, height: 1.2))
        let cgImage = try #require(image.cgImage)
        #expect(cgImage.width == 3)
        #expect(cgImage.height == 2)
        #expect(image.size == CGSize(width: 3, height: 2))
    }

    @Test(arguments: [
        CGSize.zero,
        CGSize(width: 0, height: 10),
        CGSize(width: 10, height: 0),
        CGSize(width: -5, height: 5),
        CGSize(width: 5, height: -5),
        CGSize(width: CGFloat.nan, height: 5),
        CGSize(width: 5, height: CGFloat.infinity)
    ])
    func returnsEmptyImageForSizeWithoutArea(_ size: CGSize) {
        let image = UIImage(color: .red, size: size)
        #expect(image.size == .zero)
        #expect(image.cgImage == nil)
    }

    /// Returns the premultiplied 8-bit sRGB components of every pixel, by row from the top-left corner.
    private func pixels(of image: UIImage) throws -> [[[Int]]] {
        let cgImage = try #require(image.cgImage)
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let context = try #require(
            CGContext(
                data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        let data = try #require(context.data).assumingMemoryBound(to: UInt8.self)
        return (0..<height).map { y in
            (0..<width).map { x in (0..<4).map { Int(data[(y * width + x) * 4 + $0]) } }
        }
    }
}
#endif
