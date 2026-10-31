// CATransform3D+TranslatedBy.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Returns the transform with a translation applied before it.
    ///
    /// This is the Swift spelling of `CATransform3DTranslate(_:_:_:_:)`, matching
    /// `CGAffineTransform.translatedBy(x:y:)`. The translation is applied first and this transform second, so the
    /// distances are measured in this transform's coordinate space: after a scale by 2, a translation by 10 moves the
    /// layer by 20.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// let transform = CATransform3DMakeScale(2, 2, 1).translatedBy(x: 10, y: 0, z: 0)
    /// transform.m11  // 2.0
    /// transform.m41  // 20.0
    /// ```
    ///
    /// - Parameters:
    ///   - x: The distance to move along the x-axis.
    ///   - y: The distance to move along the y-axis.
    ///   - z: The distance to move along the z-axis.
    /// - Returns: A transform that translates and then applies this transform.
    func translatedBy(x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
        CATransform3DTranslate(self, x, y, z)
    }
}
#endif
