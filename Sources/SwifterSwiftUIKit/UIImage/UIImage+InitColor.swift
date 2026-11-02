// UIImage+InitColor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIImage {
    /// SwifterSwift: Creates an image of the given size filled with a single color.
    ///
    /// The image has a scale of `1`, so its size in pixels equals `size`, rounded up to whole pixels. A size without area,
    /// or with a component that's negative, infinite or NaN, gives an empty image (its `size` is `.zero`). A dynamic color
    /// such as `.systemBackground` is resolved with the current trait collection; call `resolvedColor(with:)` first to
    /// choose the appearance.
    ///
    /// The image is drawn with `UIGraphicsImageRenderer`. On watchOS, which doesn't have it, the image is drawn into an
    /// 8-bit sRGB bitmap instead, and a size too large for a bitmap also gives an empty image.
    ///
    /// ```swift
    /// let swatch = UIImage(color: .systemRed, size: CGSize(width: 20, height: 10))
    /// swatch.size  // (20.0, 10.0)
    /// UIImage(color: .red, size: .zero).size  // (0.0, 0.0)
    /// ```
    ///
    /// - Parameters:
    ///   - color: The color to fill the image with.
    ///   - size: The size of the image, in points and pixels.
    convenience init(color: UIColor, size: CGSize) {
        guard size.width > 0, size.height > 0, size.width.isFinite, size.height.isFinite else {
            self.init()
            return
        }
        #if os(watchOS)
        guard let width = Int(exactly: size.width.rounded(.up)), let height = Int(exactly: size.height.rounded(.up)),
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
            let context = CGContext(
                data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else {
            self.init()
            return
        }
        UIGraphicsPushContext(context)
        color.setFill()
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        guard let cgImage = context.makeImage() else {
            self.init()
            return
        }
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let image = UIGraphicsImageRenderer(size: size, format: format).image { context in
            color.setFill()
            context.fill(context.format.bounds)
        }
        guard let cgImage = image.cgImage else {
            self.init()
            return
        }
        #endif
        self.init(cgImage: cgImage)
    }
}
#endif
