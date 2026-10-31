// CATransform3D+Inverted.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Returns the transform that undoes this transform.
    ///
    /// This is the Swift spelling of `CATransform3DInvert(_:)`, matching `CGAffineTransform.inverted()`. If the
    /// transform can't be inverted, for example because it scales an axis by 0, the transform is returned unchanged.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// let transform = CATransform3DMakeScale(2, 4, 1).inverted()
    /// transform.m11  // 0.5
    /// transform.m22  // 0.25
    /// ```
    ///
    /// - Returns: The inverse of this transform, or this transform if it has no inverse.
    func inverted() -> CATransform3D {
        CATransform3DInvert(self)
    }
}
#endif
