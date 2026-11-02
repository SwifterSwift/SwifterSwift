// CATransform3D+Invert.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Replaces this transform with the transform that undoes it.
    ///
    /// This is the in-place form of `inverted()`: it replaces the transform with `CATransform3DInvert(self)`. If the
    /// transform can't be inverted, for example because it scales an axis by 0, it's left unchanged. The identity
    /// transform is its own inverse, so it's also left unchanged.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// var transform = CATransform3DMakeScale(2, 4, 1)
    /// transform.invert()
    /// transform.m11  // 0.5
    /// transform.m22  // 0.25
    /// ```
    mutating func invert() {
        self = CATransform3DInvert(self)
    }
}
#endif
