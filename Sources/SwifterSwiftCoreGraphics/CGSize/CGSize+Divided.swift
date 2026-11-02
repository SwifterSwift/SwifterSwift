// CGSize+Divided.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: Returns the size with both dimensions divided by a scalar.
    ///
    /// Use it to scale a size down uniformly, for example to convert a size in pixels to points with a display scale,
    /// or to split a size into equal parts. A negative scalar gives negative dimensions. Each dimension is divided
    /// directly instead of being multiplied by `1 / scalar`, so it's rounded only once.
    ///
    /// Dividing never traps, not even by zero, because it follows IEEE 754 floating-point rules. A non-zero dimension
    /// divided by zero becomes an infinity, negative when exactly one of the dimension and the zero is negative, and a
    /// zero dimension divided by zero becomes NaN. Dividing a finite size by an infinite scalar gives zero dimensions.
    /// Check that `scalar` isn't zero first if you need a finite result.
    ///
    /// ```swift
    /// let pixels = CGSize(width: 1179, height: 2556)
    /// pixels.divided(by: 3)  // (393.0, 852.0)
    /// CGSize(width: 10, height: 0).divided(by: 0)  // (inf, nan)
    /// ```
    ///
    /// - Parameter scalar: The value to divide both dimensions by.
    /// - Returns: A size with `width` equal to `self.width / scalar` and `height` equal to `self.height / scalar`.
    func divided(by scalar: CGFloat) -> CGSize {
        CGSize(width: width / scalar, height: height / scalar)
    }
}
#endif
