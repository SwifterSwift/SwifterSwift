// CATransform3D+Rotated.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Returns the transform with a rotation around an axis applied before it.
    ///
    /// This is the Swift spelling of `CATransform3DRotate(_:_:_:_:_:)`, matching `CGAffineTransform.rotated(by:)`. The
    /// rotation is applied first and this transform second, so an existing translation isn't rotated. The axis
    /// `(x, y, z)` doesn't need to be a unit vector, because only its direction matters.
    ///
    /// Core Animation leaves the result undefined for an axis of zero length. This method returns the transform
    /// unchanged in that case. Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// let transform = CATransform3DMakeTranslation(10, 0, 0).rotated(by: .pi / 2, x: 0, y: 0, z: 1)
    /// transform.m12  // 1.0
    /// transform.m41  // 10.0
    /// ```
    ///
    /// - Parameters:
    ///   - angle: The angle to rotate by, in radians.
    ///   - x: The x component of the axis to rotate around.
    ///   - y: The y component of the axis to rotate around.
    ///   - z: The z component of the axis to rotate around.
    /// - Returns: A transform that rotates and then applies this transform.
    func rotated(by angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
        if x == 0, y == 0, z == 0 {
            return self
        }
        return CATransform3DRotate(self, angle, x, y, z)
    }
}
#endif
