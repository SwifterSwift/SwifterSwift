// UIImage+WithBackgroundColor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIImage {
    /// SwifterSwift: Returns a copy of the image drawn over a solid background color.
    ///
    /// The background shows through wherever the image is transparent or translucent, so an opaque background gives an
    /// opaque image, for example before saving as JPEG, which has no alpha channel. The copy keeps the image's size,
    /// `scale` and pixel format. A dynamic color is resolved with the current trait collection; call
    /// `resolvedColor(with:)` first to choose the appearance. An image without area is returned unchanged.
    ///
    /// On watchOS, which doesn't have `UIGraphicsImageRenderer`, the copy is drawn into an 8-bit sRGB bitmap instead,
    /// keeping the size and `scale`, and an image too large for a bitmap is returned unchanged.
    ///
    /// ```swift
    /// let logo = UIImage(named: "Logo")!  // A logo on a transparent background.
    /// let flattened = logo.withBackgroundColor(.white)  // The logo on white.
    /// ```
    ///
    /// - Parameter backgroundColor: The color to draw behind the image.
    /// - Returns: The image over `backgroundColor`.
    func withBackgroundColor(_ backgroundColor: UIColor) -> UIImage {
        guard size.width > 0, size.height > 0 else { return self }
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
        backgroundColor.setFill()
        context.fill(CGRect(origin: .zero, size: size))
        draw(at: .zero)
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else { return self }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
        #else
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            backgroundColor.setFill()
            context.fill(context.format.bounds)
            draw(at: .zero)
        }
        #endif
    }
}
#endif
