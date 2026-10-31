// CGSize+Multiplied.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: Returns the size with both dimensions multiplied by a scalar.
    ///
    /// Use it to scale a size uniformly, for example to convert points to pixels with a display scale. A negative
    /// scalar gives negative dimensions. It's equivalent to
    /// `size.applying(CGAffineTransform(scaleX: scalar, y: scalar))`, without going through a matrix.
    ///
    /// ```swift
    /// let size = CGSize(width: 320, height: 180)
    /// size.multiplied(by: 3)  // (960.0, 540.0)
    /// size.multiplied(by: 0.5)  // (160.0, 90.0)
    /// ```
    ///
    /// - Parameter scalar: The value to multiply both dimensions by.
    /// - Returns: A size with `width` equal to `self.width * scalar` and `height` equal to `self.height * scalar`.
    func multiplied(by scalar: CGFloat) -> CGSize {
        CGSize(width: width * scalar, height: height * scalar)
    }
}
#endif
