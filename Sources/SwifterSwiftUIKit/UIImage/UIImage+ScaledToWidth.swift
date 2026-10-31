// UIImage+ScaledToWidth.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIImage {
    /// SwifterSwift: Returns a copy of the image resized to the given width, keeping its aspect ratio.
    ///
    /// The height is scaled by the same factor as the width, and the image can grow as well as shrink. The copy is
    /// redrawn with `UIGraphicsImageRenderer`, keeping the image's `scale`, pixel format and `renderingMode`, so a template
    /// image stays a template; its `imageOrientation` is `.up`. On watchOS, which doesn't have `UIGraphicsImageRenderer`,
    /// the copy is drawn into an 8-bit sRGB bitmap instead, keeping the `scale` and `renderingMode`.
    ///
    /// Pass `true` for `opaque` when the image has no transparency, to save memory and speed up drawing. Transparent
    /// pixels then turn black.
    ///
    /// ```swift
    /// let photo = UIImage(named: "Photo")!  // 300 × 200 points.
    /// photo.scaled(toWidth: 150)?.size  // (150.0, 100.0)
    /// photo.scaled(toWidth: 0)  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - width: The width of the new image, in points.
    ///   - opaque: `true` if the new image has no alpha channel; `false` to keep transparency. The default is `false`.
    /// - Returns: The resized image, or `nil` if `width` isn't a positive finite number or the image has no area. On
    ///   watchOS, it's also `nil` if the new image is too large for a bitmap.
    func scaled(toWidth width: CGFloat, opaque: Bool = false) -> UIImage? {
        guard width > 0, width.isFinite, size.width > 0, size.height > 0 else { return nil }
        let newSize = CGSize(width: width, height: size.height * width / size.width)
        #if os(watchOS)
        guard let pixelWidth = Int(exactly: (newSize.width * scale).rounded(.up)),
            let pixelHeight = Int(exactly: (newSize.height * scale).rounded(.up)),
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: pixelWidth, height: pixelHeight, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: (opaque ? CGImageAlphaInfo.noneSkipLast : .premultipliedLast).rawValue)
        else { return nil }
        // Flips the bitmap to UIKit's top-left origin, in points.
        context.translateBy(x: 0, y: CGFloat(pixelHeight))
        context.scaleBy(x: scale, y: -scale)
        UIGraphicsPushContext(context)
        draw(in: CGRect(origin: .zero, size: newSize))
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else { return nil }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up).withRenderingMode(renderingMode)
        #else
        let format = imageRendererFormat
        format.opaque = opaque
        return UIGraphicsImageRenderer(size: newSize, format: format)
            .image { _ in draw(in: CGRect(origin: .zero, size: newSize)) }
            .withRenderingMode(renderingMode)
        #endif
    }
}
#endif
