// CGRect+Center.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGRect {
    /// SwifterSwift: The point at the center of the rectangle.
    ///
    /// The center is built from `midX` and `midY`, so it's also correct for rectangles with a negative width or height.
    ///
    /// ```swift
    /// let frame = CGRect(x: 10, y: 20, width: 100, height: 50)
    /// frame.center  // (60.0, 45.0)
    /// ```
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
#endif
