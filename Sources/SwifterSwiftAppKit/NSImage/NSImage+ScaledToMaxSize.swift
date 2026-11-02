// NSImage+ScaledToMaxSize.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreGraphics

public extension NSImage {
    /// SwifterSwift: Returns a copy of the image shrunk to fit within a maximum size, keeping its aspect ratio.
    ///
    /// The image is scaled by the smaller of the two ratios between `maxSize` and its own size, so both sides fit, and
    /// it's never enlarged: an image that already fits keeps its size. The new size is rounded down to whole points, and
    /// is at least 1 × 1.
    ///
    /// The copy is a new bitmap, resampled with high-quality interpolation, so it doesn't keep the original's pixels
    /// in memory. It has the pixel density of the image's sharpest bitmap, which doesn't depend on the screen: an image
    /// with a `@2x` bitmap gives a `@2x` result. Vector images, such as PDFs, are drawn at one pixel per point.
    ///
    /// ```swift
    /// let photo = NSImage(named: "Photo")!  // 200 × 100 points.
    /// photo.scaled(toMaxSize: NSSize(width: 300, height: 50))?.size  // (100.0, 50.0)
    /// photo.scaled(toMaxSize: NSSize(width: 1000, height: 1000))?.size  // (200.0, 100.0)
    /// photo.scaled(toMaxSize: .zero)  // nil
    /// ```
    ///
    /// - Parameter maxSize: The largest size the new image may have, in points.
    /// - Returns: The scaled image, or `nil` if `maxSize` is smaller than 1 × 1 or NaN, or the image has no area or no
    ///   representations.
    func scaled(toMaxSize maxSize: NSSize) -> NSImage? {
        guard size.width > 0, size.height > 0, maxSize.width >= 1, maxSize.height >= 1, !representations.isEmpty else {
            return nil
        }
        let ratio = min(1, maxSize.width / size.width, maxSize.height / size.height)
        let newSize = NSSize(
            width: max(1, (size.width * ratio).rounded(.down)),
            height: max(1, (size.height * ratio).rounded(.down))
        )

        // Measures the bitmaps themselves, because `pixelsWide` can depend on the screen. Vector representations report
        // 0 pixels and are left out.
        let sharpest =
            representations
            .filter { $0.pixelsWide > 0 }
            .compactMap { $0.cgImage(forProposedRect: nil, context: nil, hints: nil) }
            .max { $0.width < $1.width }
        let pixelsPerPoint = max(1, CGFloat(sharpest?.width ?? 0) / size.width)
        let pixelWidth = max(1, Int((newSize.width * pixelsPerPoint).rounded()))
        let pixelHeight = max(1, Int((newSize.height * pixelsPerPoint).rounded()))

        // Keeps the bitmap's RGB color space when an 8-bit bitmap supports it, and falls back to sRGB.
        let colorSpaces = [sharpest?.colorSpace, CGColorSpace(name: CGColorSpace.sRGB)].compactMap { $0 }
        let contexts = colorSpaces.lazy.filter { $0.model == .rgb }.compactMap { colorSpace in
            CGContext(
                data: nil, width: pixelWidth, height: pixelHeight, bitsPerComponent: 8, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        }
        guard let context = contexts.first else { return nil }
        context.scaleBy(x: CGFloat(pixelWidth) / newSize.width, y: CGFloat(pixelHeight) / newSize.height)

        // Lets the image pick the representation that best fits the new bitmap, and draw it there.
        let graphicsContext = NSGraphicsContext(cgContext: context, flipped: false)
        graphicsContext.imageInterpolation = .high
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = graphicsContext
        draw(in: NSRect(origin: .zero, size: newSize), from: .zero, operation: .copy, fraction: 1)
        NSGraphicsContext.restoreGraphicsState()

        guard let scaled = context.makeImage() else { return nil }
        return NSImage(cgImage: scaled, size: newSize)
    }
}
#endif
