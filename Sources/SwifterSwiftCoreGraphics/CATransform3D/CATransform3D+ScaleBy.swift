// CATransform3D+ScaleBy.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Applies a scale before this transform, in place.
    ///
    /// This is the in-place form of `scaledBy(x:y:z:)`: it replaces the transform with
    /// `CATransform3DScale(self, x, y, z)`. The scale is applied first and the existing transform second, so an
    /// existing translation isn't scaled. A factor of 0 flattens that axis, which makes the transform non-invertible.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// var transform = CATransform3DMakeTranslation(10, 0, 0)
    /// transform.scaleBy(x: 2, y: 2, z: 1)
    /// transform.m11  // 2.0
    /// transform.m41  // 10.0
    /// ```
    ///
    /// - Parameters:
    ///   - x: The factor to scale by along the x-axis.
    ///   - y: The factor to scale by along the y-axis.
    ///   - z: The factor to scale by along the z-axis.
    mutating func scaleBy(x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DScale(self, x, y, z)
    }
}
#endif
