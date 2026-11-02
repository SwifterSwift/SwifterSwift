// UIImage+Rotated.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import Foundation
import UIKit

public extension UIImage {
    /// SwifterSwift: Returns a copy of the image rotated by an angle, in radians.
    ///
    /// Positive angles rotate clockwise, as the image is displayed. The new image is just big enough to hold the rotated
    /// one, rounded to whole pixels, so its size swaps for a quarter turn and grows for other angles, leaving transparent
    /// corners. It's redrawn with `UIGraphicsImageRenderer`, keeping the image's `scale`, pixel format and
    /// `renderingMode`; its `imageOrientation` is `.up`. On watchOS, which doesn't have `UIGraphicsImageRenderer`, it's
    /// drawn into an 8-bit sRGB bitmap instead, keeping the `scale` and `renderingMode`.
    ///
    /// ```swift
    /// let photo = UIImage(named: "Photo")!  // 300 × 200 points.
    /// photo.rotated(by: .pi / 2)?.size  // (200.0, 300.0)
    /// photo.rotated(by: .pi)?.size  // (300.0, 200.0)
    /// photo.rotated(by: .nan)  // nil
    /// ```
    ///
    /// - Parameter radians: The angle to rotate the image by, in radians. Positive values rotate clockwise.
    /// - Returns: The rotated image, or `nil` if the angle isn't finite or the image has no area. On watchOS, it's also
    ///   `nil` if the rotated image is too large for a bitmap.
    func rotated(by radians: CGFloat) -> UIImage? {
        guard radians.isFinite, size.width > 0, size.height > 0 else { return nil }
        let bounds = CGRect(origin: .zero, size: size).applying(CGAffineTransform(rotationAngle: radians))
        let newSize = CGSize(
            width: (bounds.width * scale).rounded() / scale, height: (bounds.height * scale).rounded() / scale)
        guard newSize.width > 0, newSize.height > 0 else { return nil }
        #if os(watchOS)
        guard let pixelWidth = Int(exactly: (newSize.width * scale).rounded()),
            let pixelHeight = Int(exactly: (newSize.height * scale).rounded()),
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: pixelWidth, height: pixelHeight, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return nil }
        // Flips the bitmap to UIKit's top-left origin, in points, then rotates around the center.
        context.translateBy(x: 0, y: CGFloat(pixelHeight))
        context.scaleBy(x: scale, y: -scale)
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        UIGraphicsPushContext(context)
        draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up).withRenderingMode(renderingMode)
        #else
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: newSize, format: format)
            .image { context in
                context.cgContext.translateBy(x: newSize.width / 2, y: newSize.height / 2)
                context.cgContext.rotate(by: radians)
                draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            }
            .withRenderingMode(renderingMode)
        #endif
    }

    /// SwifterSwift: Returns a copy of the image rotated by an angle in any unit, such as degrees.
    ///
    /// Positive angles rotate clockwise, as the image is displayed. The new image is just big enough to hold the rotated
    /// one, rounded to whole pixels, so its size swaps for a quarter turn and grows for other angles, leaving transparent
    /// corners. It's redrawn with `UIGraphicsImageRenderer`, keeping the image's `scale`, pixel format and
    /// `renderingMode`; its `imageOrientation` is `.up`. On watchOS, which doesn't have `UIGraphicsImageRenderer`, it's
    /// drawn into an 8-bit sRGB bitmap instead, keeping the `scale` and `renderingMode`.
    ///
    /// ```swift
    /// let photo = UIImage(named: "Photo")!  // 300 × 200 points.
    /// photo.rotated(by: Measurement(value: 90, unit: .degrees))?.size  // (200.0, 300.0)
    /// photo.rotated(by: Measurement(value: -0.5, unit: .revolutions))?.size  // (300.0, 200.0)
    /// ```
    ///
    /// - Parameter angle: The angle to rotate the image by. Positive values rotate clockwise.
    /// - Returns: The rotated image, or `nil` if the angle isn't finite or the image has no area. On watchOS, it's also
    ///   `nil` if the rotated image is too large for a bitmap.
    func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)
        guard radians.isFinite, size.width > 0, size.height > 0 else { return nil }
        let bounds = CGRect(origin: .zero, size: size).applying(CGAffineTransform(rotationAngle: radians))
        let newSize = CGSize(
            width: (bounds.width * scale).rounded() / scale, height: (bounds.height * scale).rounded() / scale)
        guard newSize.width > 0, newSize.height > 0 else { return nil }
        #if os(watchOS)
        guard let pixelWidth = Int(exactly: (newSize.width * scale).rounded()),
            let pixelHeight = Int(exactly: (newSize.height * scale).rounded()),
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: pixelWidth, height: pixelHeight, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return nil }
        // Flips the bitmap to UIKit's top-left origin, in points, then rotates around the center.
        context.translateBy(x: 0, y: CGFloat(pixelHeight))
        context.scaleBy(x: scale, y: -scale)
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        UIGraphicsPushContext(context)
        draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up).withRenderingMode(renderingMode)
        #else
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: newSize, format: format)
            .image { context in
                context.cgContext.translateBy(x: newSize.width / 2, y: newSize.height / 2)
                context.cgContext.rotate(by: radians)
                draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            }
            .withRenderingMode(renderingMode)
        #endif
    }
}
#endif
