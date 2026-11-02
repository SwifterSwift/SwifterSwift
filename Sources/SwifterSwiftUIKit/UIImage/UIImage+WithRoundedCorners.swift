// UIImage+WithRoundedCorners.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIImage {
    /// SwifterSwift: Returns a copy of the image with its corners rounded, making them transparent.
    ///
    /// Without a radius, the corners are rounded as much as possible, which gives a circle for a square image and a
    /// capsule otherwise. A radius larger than half the shorter side is reduced to that, and a radius of `0` keeps
    /// square corners. The image is clipped with `UIBezierPath(roundedRect:cornerRadius:)`, and the copy keeps the image's
    /// size, `scale`, pixel format and `renderingMode`, with an alpha channel even if the image was opaque. On watchOS,
    /// which doesn't have `UIGraphicsImageRenderer`, the copy is drawn into an 8-bit sRGB bitmap instead.
    ///
    /// ```swift
    /// let avatar = UIImage(named: "Avatar")!  // 100 × 100 points.
    /// avatar.withRoundedCorners()  // A circle.
    /// avatar.withRoundedCorners(radius: 12)  // A rounded square.
    /// avatar.withRoundedCorners(radius: -1)  // nil
    /// ```
    ///
    /// - Parameter radius: The corner radius, in points, or `nil` to round the corners as much as possible. The default
    ///   is `nil`.
    /// - Returns: The image with rounded corners, or `nil` if `radius` is negative or NaN, or the image has no area. On
    ///   watchOS, it's also `nil` if the image is too large for a bitmap.
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        guard size.width > 0, size.height > 0 else { return nil }
        let maxRadius = min(size.width, size.height) / 2
        var cornerRadius = maxRadius
        if let radius {
            guard radius >= 0 else { return nil }
            cornerRadius = min(radius, maxRadius)
        }
        let rect = CGRect(origin: .zero, size: size)
        #if os(watchOS)
        guard let pixelWidth = Int(exactly: (size.width * scale).rounded(.up)),
            let pixelHeight = Int(exactly: (size.height * scale).rounded(.up)),
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: pixelWidth, height: pixelHeight, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return nil }
        // Flips the bitmap to UIKit's top-left origin, in points.
        context.translateBy(x: 0, y: CGFloat(pixelHeight))
        context.scaleBy(x: scale, y: -scale)
        UIGraphicsPushContext(context)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up).withRenderingMode(renderingMode)
        #else
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: size, format: format)
            .image { _ in
                UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
                draw(in: rect)
            }
            .withRenderingMode(renderingMode)
        #endif
    }
}
#endif
