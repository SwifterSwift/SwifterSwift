// UIImage+WithRoundedCornersTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageWithRoundedCornersTests {
    private let black = [0, 0, 0, 255]

    @Test
    func roundsAsMuchAsPossibleByDefault() throws {
        let rounded = try #require(makeBlackImage(width: 20, height: 20).withRoundedCorners())
        let pixels = try pixels(of: rounded)
        for (x, y) in [(0, 0), (19, 0), (0, 19), (19, 19), (1, 1)] {
            #expect(pixels[y][x][3] == 0)
        }
        for (x, y) in [(10, 10), (10, 1), (1, 10), (18, 10), (10, 18)] {
            #expect(isClose(pixels[y][x], to: black))
        }
    }

    @Test
    func roundsTheShortSideOfRectangularImages() throws {
        let rounded = try #require(makeBlackImage(width: 40, height: 20).withRoundedCorners())
        let pixels = try pixels(of: rounded)
        #expect(pixels[0][0][3] == 0)
        #expect(pixels[19][39][3] == 0)
        #expect(isClose(pixels[10][1], to: black))
        #expect(isClose(pixels[1][20], to: black))
        #expect(isClose(pixels[18][20], to: black))
    }

    @Test
    func roundsOnlyTheCornersForASmallRadius() throws {
        let rounded = try #require(makeBlackImage(width: 20, height: 20).withRoundedCorners(radius: 4))
        let pixels = try pixels(of: rounded)
        #expect(pixels[0][0][3] == 0)
        #expect(pixels[19][19][3] == 0)
        #expect(isClose(pixels[0][10], to: black))
        #expect(isClose(pixels[10][0], to: black))
        #expect(isClose(pixels[2][2], to: black))
    }

    @Test
    func keepsSquareCornersForZeroRadius() throws {
        let image = makeBlackImage(width: 4, height: 4)
        let rounded = try #require(image.withRoundedCorners(radius: 0))
        #expect(try pixels(of: rounded) == pixels(of: image))
    }

    @Test(arguments: [CGFloat(10), 11, 1000, CGFloat.infinity])
    func limitsTheRadiusToHalfTheShortSide(_ radius: CGFloat) throws {
        let image = makeBlackImage(width: 20, height: 20)
        let limited = try #require(image.withRoundedCorners(radius: radius))
        let maximum = try #require(image.withRoundedCorners())
        #expect(try pixels(of: limited) == pixels(of: maximum))
    }

    @Test
    func makesTheCornersOfOpaqueImagesTransparent() throws {
        let image = makeImage(width: 20, height: 20, opaque: true) { context in
            UIColor.black.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 20, height: 20))
        }
        let rounded = try #require(image.withRoundedCorners(radius: 5))
        #expect(try pixels(of: rounded)[0][0] == [0, 0, 0, 0])
    }

    @Test(arguments: [CGFloat(1), 2, 3])
    func keepsTheSizeScaleAndRenderingMode(_ scale: CGFloat) throws {
        let image = makeImage(width: 5, height: 3, scale: scale) { _ in }.withRenderingMode(.alwaysTemplate)
        let rounded = try #require(image.withRoundedCorners(radius: 1))
        #expect(rounded.size == image.size)
        #expect(rounded.scale == scale)
        #expect(rounded.renderingMode == .alwaysTemplate)
    }

    @Test(arguments: [CGFloat(-1), -CGFloat.infinity, CGFloat.nan])
    func returnsNilForInvalidRadius(_ radius: CGFloat) {
        #expect(makeBlackImage(width: 4, height: 4).withRoundedCorners(radius: radius) == nil)
    }

    @Test
    func returnsNilForImageWithoutArea() {
        #expect(UIImage().withRoundedCorners() == nil)
        #expect(UIImage().withRoundedCorners(radius: 2) == nil)
    }

    /// Returns an image filled with black.
    private func makeBlackImage(width: CGFloat, height: CGFloat) -> UIImage {
        makeImage(width: width, height: height) { context in
            UIColor.black.setFill()
            context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        }
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
