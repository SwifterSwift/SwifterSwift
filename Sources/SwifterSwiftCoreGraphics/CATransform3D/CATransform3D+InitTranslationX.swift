// CATransform3D+InitTranslationX.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Creates a transform that translates by the given distances along the x, y and z axes.
    ///
    /// This is the Swift spelling of `CATransform3DMakeTranslation(_:_:_:)`, matching
    /// `CGAffineTransform(translationX:y:)`. The distances are stored in `m41`, `m42` and `m43`, and the rest of the
    /// matrix is the identity.
    ///
    /// Core Animation isn't available on watchOS, so neither is this initializer.
    ///
    /// ```swift
    /// let transform = CATransform3D(translationX: 10, y: 20, z: 0)
    /// layer.transform = transform
    /// transform.m41  // 10.0
    /// transform.m42  // 20.0
    /// ```
    ///
    /// - Parameters:
    ///   - x: The distance to move along the x-axis.
    ///   - y: The distance to move along the y-axis.
    ///   - z: The distance to move along the z-axis.
    init(translationX x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DMakeTranslation(x, y, z)
    }
}
#endif
