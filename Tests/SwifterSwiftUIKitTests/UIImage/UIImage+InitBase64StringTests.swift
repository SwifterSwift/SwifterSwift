// UIImage+InitBase64StringTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageInitBase64StringTests {
    /// A 5 × 5 pixel PNG.
    private let png =
        "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAE0lEQVR42mP8v5JhEwMaYKSBIADNAwvIr8dhZAAAAABJRU5ErkJggg=="

    @Test
    func decodesPNGData() throws {
        let image = try #require(UIImage(base64String: png))
        #expect(image.size == CGSize(width: 5, height: 5))
        #expect(image.scale == 1)
    }

    @Test(arguments: [(CGFloat(1), CGFloat(5)), (2, 2.5), (5, 1)])
    func appliesTheScale(_ scale: CGFloat, expectedSide: CGFloat) throws {
        let image = try #require(UIImage(base64String: png, scale: scale))
        #expect(image.scale == scale)
        #expect(image.size == CGSize(width: expectedSide, height: expectedSide))
    }

    @Test
    func decodesPixelsOfEncodedImage() throws {
        let cgImage = try #require(makeTwoPixelImage())
        let encoded = try #require(UIImage(cgImage: cgImage).pngData()).base64EncodedString()
        let decoded = try #require(UIImage(base64String: encoded)?.cgImage)
        #expect(decoded.width == 2)
        #expect(decoded.height == 1)
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let context = try #require(
            CGContext(
                data: nil, width: 2, height: 1, bitsPerComponent: 8, bytesPerRow: 8, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.draw(decoded, in: CGRect(x: 0, y: 0, width: 2, height: 1))
        let data = try #require(context.data).assumingMemoryBound(to: UInt8.self)
        #expect((0..<8).map { data[$0] } == [255, 0, 0, 255, 0, 0, 255, 255])
    }

    @Test
    func decodesJPEGData() throws {
        let cgImage = try #require(makeTwoPixelImage())
        let encoded = try #require(UIImage(cgImage: cgImage).jpegData(compressionQuality: 1)).base64EncodedString()
        let image = try #require(UIImage(base64String: encoded))
        #expect(image.size == CGSize(width: 2, height: 1))
    }

    @Test(arguments: ["", "not base64", "iVBORw0KGgo", "🙂", "====", "data:image/png;base64,iVBORw0KGgo="])
    func returnsNilForInvalidBase64(_ string: String) {
        #expect(UIImage(base64String: string) == nil)
    }

    @Test
    func returnsNilForLineBreaksAndWhitespace() {
        let index = png.index(png.startIndex, offsetBy: 20)
        var wrapped = png
        wrapped.insert("\n", at: index)
        #expect(UIImage(base64String: wrapped) == nil)
        #expect(UIImage(base64String: " " + png) == nil)
    }

    @Test
    func returnsNilForDataThatIsNotAnImage() {
        let text = Data("Hello, SwifterSwift! 👋".utf8).base64EncodedString()
        #expect(UIImage(base64String: text) == nil)
    }

    /// Returns a 2 × 1 image with a red pixel and a blue pixel.
    private func makeTwoPixelImage() -> CGImage? {
        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: 2, height: 1, bitsPerComponent: 8, bytesPerRow: 8, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return nil }
        context.setFillColor(red: 1, green: 0, blue: 0, alpha: 1)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        context.setFillColor(red: 0, green: 0, blue: 1, alpha: 1)
        context.fill(CGRect(x: 1, y: 0, width: 1, height: 1))
        return context.makeImage()
    }
}
#endif
