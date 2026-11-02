// UIImage+Cropped.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIImage {
    /// SwifterSwift: Returns the part of the image inside a rectangle, or `nil` if they don't overlap.
    ///
    /// The rectangle is in points, in the coordinate space of the image as it's displayed: its origin is the top-left
    /// corner after `imageOrientation` is applied, so a photo taken in portrait is cropped the way it looks. The rectangle
    /// is clipped to the image's bounds and then rounded out to whole pixels.
    ///
    /// The pixels are copied from `cgImage` without redrawing, and the result keeps the image's `scale`,
    /// `imageOrientation` and `renderingMode`. The method returns `nil` for an image without a `cgImage`, such as one
    /// backed by a `CIImage`, and for a rectangle that's empty, contains NaN, or lies outside the image.
    ///
    /// ```swift
    /// let photo = UIImage(named: "Photo")!  // 300 × 200 points.
    /// photo.cropped(to: CGRect(x: 0, y: 0, width: 100, height: 100))?.size  // (100.0, 100.0)
    /// photo.cropped(to: CGRect(x: 250, y: 150, width: 100, height: 100))?.size  // (50.0, 50.0)
    /// photo.cropped(to: CGRect(x: 400, y: 0, width: 10, height: 10))  // nil
    /// ```
    ///
    /// - Parameter rect: The area to keep, in points, in the image's displayed coordinate space.
    /// - Returns: The cropped image, or `nil` if the image has no `cgImage` or `rect` doesn't overlap the image.
    func cropped(to rect: CGRect) -> UIImage? {
        guard let cgImage, !rect.minX.isNaN, !rect.minY.isNaN, !rect.width.isNaN, !rect.height.isNaN else { return nil }
        let visibleRect = rect.intersection(CGRect(origin: .zero, size: size))
        guard !visibleRect.isNull, !visibleRect.isEmpty else { return nil }

        // Converts the rectangle to pixels in the displayed image, then undoes the orientation to find the same pixels in
        // the stored bitmap.
        let displayed = visibleRect.applying(CGAffineTransform(scaleX: scale, y: scale))
        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        let stored: CGRect =
            switch imageOrientation {
            case .upMirrored:
                CGRect(x: width - displayed.maxX, y: displayed.minY, width: displayed.width, height: displayed.height)
            case .down:
                CGRect(
                    x: width - displayed.maxX, y: height - displayed.maxY, width: displayed.width,
                    height: displayed.height)
            case .downMirrored:
                CGRect(x: displayed.minX, y: height - displayed.maxY, width: displayed.width, height: displayed.height)
            case .left:
                CGRect(x: width - displayed.maxY, y: displayed.minX, width: displayed.height, height: displayed.width)
            case .right:
                CGRect(x: displayed.minY, y: height - displayed.maxX, width: displayed.height, height: displayed.width)
            case .leftMirrored:
                CGRect(x: displayed.minY, y: displayed.minX, width: displayed.height, height: displayed.width)
            case .rightMirrored:
                CGRect(
                    x: width - displayed.maxY, y: height - displayed.maxX, width: displayed.height,
                    height: displayed.width)
            default:
                displayed
            }

        guard let croppedImage = cgImage.cropping(to: stored) else { return nil }
        return UIImage(cgImage: croppedImage, scale: scale, orientation: imageOrientation)
            .withRenderingMode(renderingMode)
    }
}
#endif
