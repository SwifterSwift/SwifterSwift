// NSImageExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

// MARK: - Methods

public extension NSImage {
    /// SwifterSwift: NSImage scaled to maximum size with respect to aspect ratio.
    ///
    /// - Parameter maxSize: maximum size
    /// - Returns: scaled NSImage
    func scaled(toMaxSize maxSize: NSSize) -> NSImage {
        let imageWidth = size.width
        let imageHeight = size.height

        guard imageHeight > 0 else { return self }

        // Get ratio (landscape or portrait)
        let ratio: CGFloat = if imageWidth > imageHeight {
            // Landscape
            maxSize.width / imageWidth
        } else {
            // Portrait
            maxSize.height / imageHeight
        }

        // Calculate new size based on the ratio
        let newWidth = imageWidth * ratio
        let newHeight = imageHeight * ratio

        // Create a new NSSize object with the newly calculated size
        let newSize = NSSize(width: newWidth.rounded(.down), height: newHeight.rounded(.down))

        // Cast the NSImage to a CGImage
        var imageRect = CGRect(origin: .zero, size: size)
        guard let imageRef = cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else { return self }

        return NSImage(cgImage: imageRef, size: newSize)
    }

    /// SwifterSwift: Write NSImage to url.
    ///
    /// - Parameters:
    ///   - url: Desired file URL.
    ///   - type: Type of image (default is .jpeg).
    ///   - compressionFactor: used only for JPEG files. The value is a float between 0.0 and 1.0, with 1.0 resulting in
    /// no compression and 0.0 resulting in the maximum compression possible.
    func write(to url: URL, fileType type: NSBitmapImageRep.FileType = .jpeg, compressionFactor: NSNumber = 1.0) {
        // https://stackoverflow.com/a/45042611/3882644

        guard let data = tiffRepresentation else { return }
        guard let imageRep = NSBitmapImageRep(data: data) else { return }

        guard let imageData = imageRep.representation(using: type, properties: [.compressionFactor: compressionFactor]) else { return }
        try? imageData.write(to: url)
    }
}

#endif
