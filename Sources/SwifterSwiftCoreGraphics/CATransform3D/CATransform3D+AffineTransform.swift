// CATransform3D+AffineTransform.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Returns the affine transform with the same effect as this transform, if there is one.
    ///
    /// This is the Swift spelling of `CATransform3DGetAffineTransform(_:)`. Core Animation leaves that function's
    /// result undefined when the transform isn't affine, so this method checks `CATransform3DIsAffine(_:)` first, and
    /// returns `nil` for a transform that uses the z-axis or perspective.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// CATransform3DMakeTranslation(10, 20, 0).affineTransform()  // CGAffineTransform(translationX: 10, y: 20)
    /// CATransform3DMakeTranslation(10, 20, 5).affineTransform()  // nil
    /// ```
    ///
    /// - Returns: The equivalent `CGAffineTransform`, or `nil` if this transform can't be represented as one.
    func affineTransform() -> CGAffineTransform? {
        guard CATransform3DIsAffine(self) else { return nil }
        return CATransform3DGetAffineTransform(self)
    }
}
#endif
