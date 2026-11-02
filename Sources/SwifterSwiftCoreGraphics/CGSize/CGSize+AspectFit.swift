// CGSize+AspectFit.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: Returns the largest size with this size's aspect ratio that fits inside a bounding size.
    ///
    /// One dimension of the result is exactly the matching dimension of `boundingSize`, and the other one is at most
    /// its counterpart. The size is scaled up as well as down, like `UIView.ContentMode.scaleAspectFit`. To get a
    /// centered rectangle instead of a size, AVFoundation offers `AVMakeRect(aspectRatio:insideRect:)`.
    ///
    /// If this size's width or height isn't a positive, finite number, it has no aspect ratio to keep, and the result
    /// is `.zero`. The result is also `.zero` if `boundingSize` has a negative or NaN dimension. An infinite bounding
    /// dimension places no limit on that side.
    ///
    /// ```swift
    /// let photo = CGSize(width: 120, height: 80)
    /// photo.aspectFit(to: CGSize(width: 100, height: 50))  // (75.0, 50.0)
    /// photo.aspectFit(to: CGSize(width: 240, height: 240))  // (240.0, 160.0)
    /// CGSize.zero.aspectFit(to: CGSize(width: 100, height: 50))  // (0.0, 0.0)
    /// ```
    ///
    /// - Parameter boundingSize: The size to fit inside.
    /// - Returns: This size scaled to fit inside `boundingSize`, or `.zero` if either size is invalid.
    func aspectFit(to boundingSize: CGSize) -> CGSize {
        guard width > 0, width.isFinite, height > 0, height.isFinite,
            boundingSize.width >= 0, boundingSize.height >= 0
        else { return .zero }
        let widthScale = boundingSize.width / width
        let heightScale = boundingSize.height / height
        if widthScale < heightScale {
            return CGSize(width: boundingSize.width, height: height * widthScale)
        }
        return CGSize(width: width * heightScale, height: boundingSize.height)
    }
}
#endif
