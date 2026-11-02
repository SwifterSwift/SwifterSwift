// CGRect+InitCenter.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGRect {
    /// SwifterSwift: Creates a rectangle with the given size, centered on a point.
    ///
    /// The origin is `center` minus half of `size`, so the new rectangle's `midX` and `midY` equal `center`, and its
    /// `size` is exactly `size`. A negative width or height is kept as is, and the rectangle is still centered on
    /// `center`, because Core Graphics measures the midpoint on the standardized rectangle.
    ///
    /// ```swift
    /// let rect = CGRect(center: CGPoint(x: 50, y: 50), size: CGSize(width: 20, height: 10))
    /// rect.origin  // (40.0, 45.0)
    /// rect.size  // (20.0, 10.0)
    /// ```
    ///
    /// - Parameters:
    ///   - center: The point at the center of the rectangle.
    ///   - size: The width and height of the rectangle.
    init(center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2),
            size: size
        )
    }
}
#endif
