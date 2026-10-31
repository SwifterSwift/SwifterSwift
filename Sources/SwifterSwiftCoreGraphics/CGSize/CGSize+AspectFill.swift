// CGSize+AspectFill.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: Returns the smallest size with this size's aspect ratio that covers a bounding size.
    ///
    /// One dimension of the result is exactly the matching dimension of `boundingSize`, and the other one is at least
    /// its counterpart, so the result usually extends past `boundingSize` on one side. The size is scaled up as well
    /// as down, like `UIView.ContentMode.scaleAspectFill` before clipping.
    ///
    /// If this size's width or height isn't a positive, finite number, it has no aspect ratio to keep, and the result
    /// is `.zero`. The result is also `.zero` if `boundingSize` has a negative or NaN dimension. An infinite bounding
    /// dimension makes the result infinite.
    ///
    /// ```swift
    /// let banner = CGSize(width: 20, height: 120)
    /// banner.aspectFill(to: CGSize(width: 100, height: 60))  // (100.0, 600.0)
    /// let photo = CGSize(width: 120, height: 80)
    /// photo.aspectFill(to: CGSize(width: 100, height: 50))  // (100.0, 66.66666666666667)
    /// ```
    ///
    /// - Parameter boundingSize: The size to cover.
    /// - Returns: This size scaled to cover `boundingSize`, or `.zero` if either size is invalid.
    func aspectFill(to boundingSize: CGSize) -> CGSize {
        guard width > 0, width.isFinite, height > 0, height.isFinite,
            boundingSize.width >= 0, boundingSize.height >= 0
        else { return .zero }
        let widthScale = boundingSize.width / width
        let heightScale = boundingSize.height / height
        if widthScale > heightScale {
            return CGSize(width: boundingSize.width, height: height * widthScale)
        }
        return CGSize(width: width * heightScale, height: boundingSize.height)
    }
}
#endif
