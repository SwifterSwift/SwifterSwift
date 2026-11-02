// UIImage+CroppedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

#if canImport(CoreImage)
import CoreImage
#endif

struct UIImageCroppedTests {
    @Test
    func keepsThePixelsInsideTheRect() throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: .up)
        let cropped = try #require(image.cropped(to: CGRect(x: 1, y: 1, width: 2, height: 2)))
        #expect(cropped.size == CGSize(width: 2, height: 2))
        let all = try pixels(of: image)
        #expect(try pixels(of: cropped) == [Array(all[1][1...2]), Array(all[2][1...2])])
    }

    @Test
    func keepsTheWholeImageForItsBounds() throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: .up)
        let cropped = try #require(image.cropped(to: CGRect(origin: .zero, size: image.size)))
        #expect(cropped.size == image.size)
        #expect(try pixels(of: cropped) == pixels(of: image))
    }

    @Test
    func measuresTheRectInPoints() throws {
        let image = try makeImage(width: 20, height: 20, scale: 2, orientation: .up)
        #expect(image.size == CGSize(width: 10, height: 10))
        let cropped = try #require(image.cropped(to: CGRect(x: 0, y: 0, width: 5, height: 6)))
        #expect(cropped.scale == 2)
        #expect(cropped.size == CGSize(width: 5, height: 6))
        #expect(cropped.cgImage?.width == 10)
        #expect(cropped.cgImage?.height == 12)
    }

    @Test(arguments: [
        UIImage.Orientation.up, .upMirrored, .down, .downMirrored, .left, .leftMirrored, .right, .rightMirrored
    ])
    func cropsWhatIsDisplayedForEveryOrientation(_ orientation: UIImage.Orientation) throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: orientation)
        let displayed = try pixels(of: image)
        let rects = [
            CGRect(x: 1, y: 0, width: 2, height: 1),
            CGRect(x: 0, y: 1, width: 1, height: 2),
            CGRect(x: 1, y: 1, width: 2, height: 2)
        ]
        for rect in rects {
            let cropped = try #require(image.cropped(to: rect))
            #expect(cropped.size == rect.size)
            #expect(cropped.imageOrientation == orientation)
            let expected = (Int(rect.minY)..<Int(rect.maxY)).map { y in
                Array(displayed[y][Int(rect.minX)..<Int(rect.maxX)])
            }
            #expect(try pixels(of: cropped) == expected)
        }
    }

    @Test
    func clipsTheRectToTheImage() throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: .up)
        let cropped = try #require(image.cropped(to: CGRect(x: 2, y: 1, width: 100, height: 100)))
        #expect(cropped.size == CGSize(width: 2, height: 2))
        let negative = try #require(image.cropped(to: CGRect(x: -5, y: -5, width: 6, height: 6)))
        #expect(negative.size == CGSize(width: 1, height: 1))
        #expect(try pixels(of: negative)[0][0] == pixels(of: image)[0][0])
    }

    @Test
    func roundsFractionalRectsOutToWholePixels() throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: .up)
        let cropped = try #require(image.cropped(to: CGRect(x: 0.5, y: 0.5, width: 1, height: 1)))
        #expect(cropped.size == CGSize(width: 2, height: 2))
    }

    @Test
    func acceptsRectsWithNegativeSize() throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: .up)
        let flipped = try #require(image.cropped(to: CGRect(x: 3, y: 2, width: -2, height: -1)))
        let standard = try #require(image.cropped(to: CGRect(x: 1, y: 1, width: 2, height: 1)))
        #expect(try pixels(of: flipped) == pixels(of: standard))
    }

    @Test(arguments: [
        CGRect(x: 10, y: 0, width: 5, height: 5),
        CGRect(x: 0, y: -10, width: 5, height: 5),
        CGRect(x: 1, y: 1, width: 0, height: 2),
        CGRect(x: 4, y: 0, width: 1, height: 1),
        CGRect.null,
        CGRect(x: CGFloat.nan, y: 0, width: 1, height: 1),
        CGRect(x: 0, y: 0, width: CGFloat.nan, height: 1)
    ])
    func returnsNilWhenTheRectMissesTheImage(_ rect: CGRect) throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: .up)
        #expect(image.cropped(to: rect) == nil)
    }

    @Test
    func keepsTheRenderingMode() throws {
        let image = try makeImage(width: 4, height: 3, scale: 1, orientation: .up).withRenderingMode(.alwaysTemplate)
        #expect(image.cropped(to: CGRect(x: 0, y: 0, width: 2, height: 2))?.renderingMode == .alwaysTemplate)
    }

    @Test
    func returnsNilForImagesWithoutCGImage() {
        #expect(UIImage().cropped(to: CGRect(x: 0, y: 0, width: 2, height: 2)) == nil)
        #if canImport(CoreImage)
        let ciImage = CIImage(color: CIColor(red: 1, green: 0, blue: 0))
            .cropped(to: CGRect(x: 0, y: 0, width: 4, height: 4))
        #expect(UIImage(ciImage: ciImage).cropped(to: CGRect(x: 0, y: 0, width: 2, height: 2)) == nil)
        #endif
    }

    /// Returns an image whose stored pixels all have different colors.
    private func makeImage(width: Int, height: Int, scale: CGFloat, orientation: UIImage.Orientation) throws -> UIImage
    {
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let context = try #require(
            CGContext(
                data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        for y in 0..<height {
            for x in 0..<width {
                let index = CGFloat(y * width + x)
                context.setFillColor(red: index / 20, green: 1 - index / 20, blue: CGFloat(x % 2), alpha: 1)
                context.fill(CGRect(x: x, y: y, width: 1, height: 1))
            }
        }
        return UIImage(cgImage: try #require(context.makeImage()), scale: scale, orientation: orientation)
    }

    /// Returns the 8-bit sRGB components of every pixel as the image is displayed, by row from the top-left corner.
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
}
#endif
