// CATransform3D+IsAffine.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: A Boolean value that indicates whether the transform is exactly a 2D affine transform.
    ///
    /// This is the Swift spelling of `CATransform3DIsAffine(_:)`. A transform is affine when it only moves, scales,
    /// rotates or skews in the x-y plane. Any translation or scale along the z-axis, rotation around the x- or y-axis,
    /// or perspective (a non-zero `m34`) makes it non-affine.
    ///
    /// Core Animation isn't available on watchOS, so neither is this property.
    ///
    /// ```swift
    /// CATransform3DMakeRotation(.pi / 4, 0, 0, 1).isAffine  // true
    /// CATransform3DMakeRotation(.pi / 4, 0, 1, 0).isAffine  // false
    /// ```
    var isAffine: Bool {
        CATransform3DIsAffine(self)
    }
}
#endif
