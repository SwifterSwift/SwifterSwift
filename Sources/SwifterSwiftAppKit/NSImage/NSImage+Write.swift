// NSImage+Write.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreGraphics
import Foundation

public extension NSImage {
    /// SwifterSwift: Encodes the image in a bitmap file format and writes it to a URL.
    ///
    /// The image's sharpest bitmap is encoded as is, whatever the screen's resolution, so an image with a `@2x` bitmap
    /// is written at full resolution. Vector images, such as PDFs, are drawn at one pixel per point. The file records the
    /// image's size in points as its resolution (for example 144 dpi for `@2x`), so `NSImage(contentsOf:)` reads it back
    /// at the same size. It's written atomically, replacing any file at `url`.
    ///
    /// `compressionFactor` applies only to JPEG and JPEG 2000. JPEG has no alpha channel, so transparent pixels lose
    /// their transparency.
    ///
    /// ```swift
    /// let url = URL.temporaryDirectory.appending(path: "thumbnail.png")
    /// try image.write(to: url, fileType: .png)
    /// try image.write(to: url.deletingPathExtension().appendingPathExtension("jpg"), compressionFactor: 0.8)
    /// ```
    ///
    /// - Parameters:
    ///   - url: The file URL to write to.
    ///   - fileType: The file format to encode the image in. The default is `.jpeg`.
    ///   - compressionFactor: The JPEG quality, from `0` (smallest file) to `1` (best quality). The default is `1`.
    /// - Throws: `CocoaError(.fileWriteUnknown)` if the image has no area or can't be encoded in `fileType`, or the
    ///   error from writing the file, for example when the folder doesn't exist.
    func write(to url: URL, fileType: NSBitmapImageRep.FileType = .jpeg, compressionFactor: Double = 1) throws {
        // Measures the bitmaps themselves, because `pixelsWide` can depend on the screen. Vector representations report
        // 0 pixels and are left out.
        let sharpest =
            representations
            .filter { $0.pixelsWide > 0 }
            .compactMap { $0.cgImage(forProposedRect: nil, context: nil, hints: nil) }
            .max { $0.width < $1.width }
        var rect = CGRect(origin: .zero, size: size)
        guard size.width > 0, size.height > 0,
            let cgImage = sharpest ?? cgImage(forProposedRect: &rect, context: nil, hints: [.ctm: NSAffineTransform()])
        else {
            throw CocoaError(.fileWriteUnknown, userInfo: [NSURLErrorKey: url])
        }

        let representation = NSBitmapImageRep(cgImage: cgImage)
        representation.size = size
        let properties: [NSBitmapImageRep.PropertyKey: Any] = [.compressionFactor: NSNumber(value: compressionFactor)]
        guard let data = representation.representation(using: fileType, properties: properties) else {
            throw CocoaError(.fileWriteUnknown, userInfo: [NSURLErrorKey: url])
        }
        try data.write(to: url, options: .atomic)
    }
}
#endif
