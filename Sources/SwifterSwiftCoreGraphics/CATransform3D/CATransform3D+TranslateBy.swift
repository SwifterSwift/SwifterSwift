// CATransform3D+TranslateBy.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Applies a translation before this transform, in place.
    ///
    /// This is the in-place form of `translatedBy(x:y:z:)`: it replaces the transform with
    /// `CATransform3DTranslate(self, x, y, z)`. The translation is applied first and the existing transform second, so
    /// the distances are measured in the transform's own coordinate space: after a scale by 2, a translation by 10
    /// moves the layer by 20.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// var transform = CATransform3DMakeScale(2, 2, 1)
    /// transform.translateBy(x: 10, y: 0, z: 0)
    /// transform.m11  // 2.0
    /// transform.m41  // 20.0
    /// ```
    ///
    /// - Parameters:
    ///   - x: The distance to move along the x-axis.
    ///   - y: The distance to move along the y-axis.
    ///   - z: The distance to move along the z-axis.
    mutating func translateBy(x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DTranslate(self, x, y, z)
    }
}
#endif
