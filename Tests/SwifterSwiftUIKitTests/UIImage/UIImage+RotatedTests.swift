// UIImage+RotatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageRotatedTests {
    private let red = [255, 0, 0, 255]
    private let blue = [0, 0, 255, 255]

    @Test
    func swapsTheSizeForAQuarterTurn() throws {
        let image = makeHalvesImage()
        #expect(image.rotated(by: .pi / 2)?.size == CGSize(width: 2, height: 4))
        #expect(image.rotated(by: -.pi / 2)?.size == CGSize(width: 2, height: 4))
        #expect(image.rotated(by: Measurement(value: 90, unit: .degrees))?.size == CGSize(width: 2, height: 4))
    }

    @Test
    func rotatesClockwiseForPositiveAngles() throws {
        let rotated = try pixels(of: try #require(makeHalvesImage().rotated(by: .pi / 2)))
        #expect(isClose(rotated[0][0], to: red))
        #expect(isClose(rotated[0][1], to: red))
        #expect(isClose(rotated[3][0], to: blue))
        #expect(isClose(rotated[3][1], to: blue))
    }

    @Test
    func rotatesCounterclockwiseForNegativeAngles() throws {
        let rotated = try pixels(of: try #require(makeHalvesImage().rotated(by: -.pi / 2)))
        #expect(isClose(rotated[0][0], to: blue))
        #expect(isClose(rotated[3][1], to: red))
    }

    @Test
    func flipsBothAxesForAHalfTurn() throws {
        let image = makeHalvesImage()
        let rotated = try #require(image.rotated(by: .pi))
        #expect(rotated.size == image.size)
        let pixels = try pixels(of: rotated)
        #expect(isClose(pixels[0][0], to: blue))
        #expect(isClose(pixels[1][3], to: red))
    }

    @Test
    func keepsTheImageForAFullTurn() throws {
        let image = makeHalvesImage()
        let rotated = try #require(image.rotated(by: 2 * .pi))
        #expect(rotated.size == image.size)
        let expected = try pixels(of: image)
        let actual = try pixels(of: rotated)
        for (expectedRow, actualRow) in zip(expected, actual) {
            for (expectedPixel, actualPixel) in zip(expectedRow, actualRow) {
                #expect(isClose(actualPixel, to: expectedPixel))
            }
        }
    }

    @Test
    func growsAndLeavesTransparentCornersForOtherAngles() throws {
        let image = makeImage(width: 10, height: 10) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 10, height: 10))
        }
        let rotated = try #require(image.rotated(by: .pi / 4))
        #expect(rotated.size == CGSize(width: 14, height: 14))
        let pixels = try pixels(of: rotated)
        #expect(pixels[0][0][3] == 0)
        #expect(pixels[13][13][3] == 0)
        #expect(isClose(pixels[7][7], to: red))
    }

    @Test
    func roundsTheSizeToWholePixels() throws {
        let image = makeImage(width: 10, height: 10, scale: 2) { _ in }
        let rotated = try #require(image.rotated(by: .pi / 4))
        // The rotated square is 10 × √2 ≈ 14.14 points, which is 28.28 pixels at 2x.
        #expect(rotated.size == CGSize(width: 14, height: 14))
        #expect(rotated.scale == 2)
        #expect(rotated.cgImage?.width == 28)
    }

    @Test
    func makesOpaqueImagesTransparentAroundTheRotatedImage() throws {
        let image = makeImage(width: 10, height: 10, opaque: true) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 10, height: 10))
        }
        let rotated = try #require(image.rotated(by: .pi / 4))
        #expect(try pixels(of: rotated)[0][0][3] == 0)
    }

    @Test(arguments: zip([90.0, -90, 180, 45], [CGFloat.pi / 2, -CGFloat.pi / 2, CGFloat.pi, CGFloat.pi / 4]))
    func matchesTheRadiansVersionForDegrees(_ degrees: Double, radians: CGFloat) throws {
        let image = makeHalvesImage()
        let measured = try #require(image.rotated(by: Measurement(value: degrees, unit: .degrees)))
        let expected = try #require(image.rotated(by: radians))
        #expect(measured.size == expected.size)
        #expect(try pixels(of: measured) == pixels(of: expected))
    }

    @Test
    func convertsOtherUnitsToRadians() throws {
        let image = makeHalvesImage()
        let angles: [(Measurement<UnitAngle>, CGFloat)] = [
            (Measurement(value: 0.5, unit: .revolutions), .pi),
            (Measurement(value: 100, unit: .gradians), .pi / 2),
            (Measurement(value: 1, unit: .radians), 1)
        ]
        for (angle, radians) in angles {
            let measured = try #require(image.rotated(by: angle))
            let expected = try #require(image.rotated(by: radians))
            #expect(measured.size == expected.size)
            #expect(try pixels(of: measured) == pixels(of: expected))
        }
    }

    @Test
    func keepsTheScaleAndRenderingMode() throws {
        let image = makeImage(width: 4, height: 2, scale: 3) { _ in }.withRenderingMode(.alwaysTemplate)
        let rotated = try #require(image.rotated(by: .pi / 2))
        #expect(rotated.scale == 3)
        #expect(rotated.renderingMode == .alwaysTemplate)
        let measured = try #require(image.rotated(by: Measurement(value: 90, unit: .degrees)))
        #expect(measured.scale == 3)
        #expect(measured.renderingMode == .alwaysTemplate)
    }

    @Test(arguments: [CGFloat.nan, CGFloat.infinity, -CGFloat.infinity])
    func returnsNilForNonFiniteAngles(_ radians: CGFloat) {
        let image = makeHalvesImage()
        #expect(image.rotated(by: radians) == nil)
        #expect(image.rotated(by: Measurement(value: Double(radians), unit: .radians)) == nil)
    }

    @Test
    func returnsNilForImageWithoutArea() {
        #expect(UIImage().rotated(by: .pi) == nil)
        #expect(UIImage().rotated(by: Measurement(value: 180, unit: .degrees)) == nil)
    }

    /// Returns a 4 × 2 image whose left half is red and right half is blue.
    private func makeHalvesImage() -> UIImage {
        makeImage(width: 4, height: 2) { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 2, height: 2))
            UIColor.blue.setFill()
            context.fill(CGRect(x: 2, y: 0, width: 2, height: 2))
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
