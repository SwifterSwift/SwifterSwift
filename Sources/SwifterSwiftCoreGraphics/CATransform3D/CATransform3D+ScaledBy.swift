// CATransform3D+ScaledBy.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Returns the transform with a scale applied before it.
    ///
    /// This is the Swift spelling of `CATransform3DScale(_:_:_:_:)`, matching `CGAffineTransform.scaledBy(x:y:)`. The
    /// scale is applied first and this transform second, so an existing translation isn't scaled. A factor of 0
    /// flattens that axis, which makes the transform non-invertible.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// let transform = CATransform3DMakeTranslation(10, 0, 0).scaledBy(x: 2, y: 2, z: 1)
    /// transform.m11  // 2.0
    /// transform.m41  // 10.0
    /// ```
    ///
    /// - Parameters:
    ///   - x: The factor to scale by along the x-axis.
    ///   - y: The factor to scale by along the y-axis.
    ///   - z: The factor to scale by along the z-axis.
    /// - Returns: A transform that scales and then applies this transform.
    func scaledBy(x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
        CATransform3DScale(self, x, y, z)
    }
}
#endif
