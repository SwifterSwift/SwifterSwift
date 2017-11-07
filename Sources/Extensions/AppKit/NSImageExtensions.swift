//
//  NSImageExtensions.swift
//  SwifterSwift-macOS
//
//  Created by BUDDAx2 on 20.10.2017.
//  Copyright © 2017 SwifterSwift
//

#if os(macOS)
import AppKit

// MARK: - Methods
extension NSImage {
    
    /// SwifterSwift: NSImage scaled to maximum size with respect to aspect ratio
    ///
    /// - Parameter toMaxSize: maximum size
    /// - Returns: scaled NSImage
    public func scaled(toMaxSize: NSSize) -> NSImage {
        var ratio: Float = 0.0
        let imageWidth = Float(self.size.width)
        let imageHeight = Float(self.size.height)
        let maxWidth = Float(toMaxSize.width)
        let maxHeight = Float(toMaxSize.height)
        
        // Get ratio (landscape or portrait)
        if imageWidth > imageHeight {
            // Landscape
            ratio = maxWidth / imageWidth
        } else {
            // Portrait
            ratio = maxHeight / imageHeight
        }
        
        // Calculate new size based on the ratio
        let newWidth = imageWidth * ratio
        let newHeight = imageHeight * ratio
        
        // Create a new NSSize object with the newly calculated size
        let newSize: NSSize = NSSize(width: Int(newWidth), height: Int(newHeight))
        
        // Cast the NSImage to a CGImage
        var imageRect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        let imageRef = self.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
        
        // Create NSImage from the CGImage using the new size
        let imageWithNewSize = NSImage(cgImage: imageRef!, size: newSize)
        
        // Return the new image
        return imageWithNewSize
    }
}

#endif
