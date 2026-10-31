// CATransform3D+Rotate.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Applies a rotation around an axis before this transform, in place.
    ///
    /// This is the in-place form of `rotated(by:x:y:z:)`: it replaces the transform with
    /// `CATransform3DRotate(self, angle, x, y, z)`. The rotation is applied first and the existing transform second, so
    /// an existing translation isn't rotated. The axis `(x, y, z)` doesn't need to be a unit vector, because only its
    /// direction matters.
    ///
    /// Core Animation leaves the result undefined for an axis of zero length. This method leaves the transform
    /// unchanged in that case. Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// var transform = CATransform3DMakeTranslation(10, 0, 0)
    /// transform.rotate(by: .pi / 2, x: 0, y: 0, z: 1)
    /// transform.m12  // 1.0
    /// transform.m41  // 10.0
    /// ```
    ///
    /// - Parameters:
    ///   - angle: The angle to rotate by, in radians.
    ///   - x: The x component of the axis to rotate around.
    ///   - y: The y component of the axis to rotate around.
    ///   - z: The z component of the axis to rotate around.
    mutating func rotate(by angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        if x == 0, y == 0, z == 0 {
            return
        }
        self = CATransform3DRotate(self, angle, x, y, z)
    }
}
#endif
