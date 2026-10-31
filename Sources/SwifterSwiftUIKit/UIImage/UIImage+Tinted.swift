// UIImage+Tinted.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIImage {
    /// SwifterSwift: Returns a copy of the image drawn over a solid color with the given blend mode.
    ///
    /// The whole image area is first filled with `color`, then the image is drawn on top using `blendMode` and `alpha`.
    /// The image is the source of the blend and the color is the destination, so for example:
    ///
    /// - `.multiply` darkens the color with the image, which tints a light image.
    /// - `.destinationIn` keeps the color only where the image is opaque, giving a solid silhouette.
    /// - `.normal` with an `alpha` below `1` shows the color through the image.
    ///
    /// To recolor a template image for display, `withTintColor(_:renderingMode:)` is usually simpler. The copy keeps the
    /// image's size, `scale` and pixel format. A dynamic color is resolved with the current trait collection; call
    /// `resolvedColor(with:)` first to choose the appearance. An image without area is returned unchanged.
    ///
    /// On watchOS, which doesn't have `UIGraphicsImageRenderer`, the copy is drawn into an 8-bit sRGB bitmap instead,
    /// keeping the size and `scale`, and an image too large for a bitmap is returned unchanged.
    ///
    /// ```swift
    /// let icon = UIImage(named: "Icon")!
    /// let silhouette = icon.tinted(.systemRed, blendMode: .destinationIn)  // A red icon shape.
    /// let washed = icon.tinted(.white, blendMode: .normal, alpha: 0.5)  // The icon faded over white.
    /// ```
    ///
    /// - Parameters:
    ///   - color: The color to fill the image area with before drawing the image.
    ///   - blendMode: The blend mode to draw the image with.
    ///   - alpha: The opacity to draw the image with, from `0` (invisible) to `1` (opaque). The default is `1`.
    /// - Returns: The tinted image.
    func tinted(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1) -> UIImage {
        guard size.width > 0, size.height > 0 else { return self }
        let rect = CGRect(origin: .zero, size: size)
        #if os(watchOS)
        guard let pixelWidth = Int(exactly: (size.width * scale).rounded(.up)),
            let pixelHeight = Int(exactly: (size.height * scale).rounded(.up)),
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: pixelWidth, height: pixelHeight, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return self }
        // Flips the bitmap to UIKit's top-left origin, in points.
        context.translateBy(x: 0, y: CGFloat(pixelHeight))
        context.scaleBy(x: scale, y: -scale)
        UIGraphicsPushContext(context)
        color.setFill()
        context.fill(rect)
        draw(in: rect, blendMode: blendMode, alpha: alpha)
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else { return self }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
        #else
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            color.setFill()
            context.fill(rect)
            draw(in: rect, blendMode: blendMode, alpha: alpha)
        }
        #endif
    }
}
#endif
