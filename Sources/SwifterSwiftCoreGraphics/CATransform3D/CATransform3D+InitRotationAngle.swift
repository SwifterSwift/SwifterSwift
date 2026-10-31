// CATransform3D+InitRotationAngle.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Creates a transform that rotates by an angle around an axis.
    ///
    /// This is the Swift spelling of `CATransform3DMakeRotation(_:_:_:_:)`. The axis `(x, y, z)` doesn't need to be a
    /// unit vector, because only its direction matters. Rotating around the z-axis `(0, 0, 1)` gives the same rotation
    /// as `CGAffineTransform(rotationAngle:)`.
    ///
    /// Core Animation leaves the result undefined for an axis of zero length. This initializer returns the identity
    /// transform in that case. Core Animation isn't available on watchOS, so neither is this initializer.
    ///
    /// ```swift
    /// let flip = CATransform3D(rotationAngle: .pi / 4, x: 0, y: 1, z: 0)
    /// layer.transform = flip  // turns the layer around its vertical axis
    /// flip.m11  // 0.7071067811865476
    /// flip.m13  // -0.7071067811865475
    /// ```
    ///
    /// - Parameters:
    ///   - angle: The angle to rotate by, in radians.
    ///   - x: The x component of the axis to rotate around.
    ///   - y: The y component of the axis to rotate around.
    ///   - z: The z component of the axis to rotate around.
    init(rotationAngle angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        if x == 0, y == 0, z == 0 {
            self = CATransform3DIdentity
        } else {
            self = CATransform3DMakeRotation(angle, x, y, z)
        }
    }
}
#endif
