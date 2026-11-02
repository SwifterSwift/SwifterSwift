// CATransform3D+InitScaleX.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Creates a transform that scales by the given factors along the x, y and z axes.
    ///
    /// This is the Swift spelling of `CATransform3DMakeScale(_:_:_:)`, matching `CGAffineTransform(scaleX:y:)`. The
    /// factors are stored on the diagonal, in `m11`, `m22` and `m33`. A factor of 1 leaves that axis unchanged, a
    /// negative factor mirrors along it, and a factor of 0 flattens it, which makes the transform non-invertible.
    ///
    /// Core Animation isn't available on watchOS, so neither is this initializer.
    ///
    /// ```swift
    /// let transform = CATransform3D(scaleX: 2, y: 0.5, z: 1)
    /// layer.transform = transform
    /// transform.m11  // 2.0
    /// transform.m22  // 0.5
    /// ```
    ///
    /// - Parameters:
    ///   - x: The factor to scale by along the x-axis.
    ///   - y: The factor to scale by along the y-axis.
    ///   - z: The factor to scale by along the z-axis.
    init(scaleX x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DMakeScale(x, y, z)
    }
}
#endif
