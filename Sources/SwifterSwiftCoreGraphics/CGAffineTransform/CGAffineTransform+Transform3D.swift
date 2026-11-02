// CGAffineTransform+Transform3D.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CGAffineTransform {
    /// SwifterSwift: Returns the 3D transform that has the same effect as this affine transform.
    ///
    /// This is the Swift spelling of `CATransform3DMakeAffineTransform(_:)`. The affine values fill the x and y parts
    /// of the 4x4 matrix and the z axis is left unchanged, so the result can be assigned to `CALayer.transform`.
    /// Converting it back with `CATransform3DGetAffineTransform(_:)` gives the original transform.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// let transform = CGAffineTransform(translationX: 10, y: 20).transform3D()
    /// layer.transform = transform
    /// transform.m41  // 10.0
    /// transform.m42  // 20.0
    /// ```
    ///
    /// - Returns: A `CATransform3D` with the same effect as this transform.
    func transform3D() -> CATransform3D {
        CATransform3DMakeAffineTransform(self)
    }
}
#endif
