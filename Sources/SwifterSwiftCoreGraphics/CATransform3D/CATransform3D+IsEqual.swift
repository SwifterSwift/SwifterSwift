// CATransform3D+IsEqual.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Returns a Boolean value that indicates whether this transform is exactly equal to another one.
    ///
    /// This is the Swift spelling of `CATransform3DEqualToTransform(_:_:)`. Unlike `CGAffineTransform`,
    /// `CATransform3D` doesn't conform to `Equatable`, so `==` doesn't compile for it.
    ///
    /// All 16 elements are compared exactly, so two transforms that differ only by rounding aren't equal. Zero and
    /// negative zero are equal, but a transform with a NaN element isn't equal to any transform, not even itself. To
    /// check for the identity transform, use `CATransform3DIsIdentity(_:)`.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// let transform = CATransform3DMakeTranslation(10, 20, 0)
    /// transform.isEqual(to: CATransform3DTranslate(CATransform3DIdentity, 10, 20, 0))  // true
    ///
    /// let rounded = CATransform3DTranslate(CATransform3DMakeTranslation(0.1, 0, 0), 0.2, 0, 0)
    /// rounded.isEqual(to: CATransform3DMakeTranslation(0.3, 0, 0))  // false, m41 is 0.30000000000000004
    /// ```
    ///
    /// - Parameter transform: The transform to compare with.
    /// - Returns: `true` if every element of this transform is equal to the matching element of `transform`;
    ///   otherwise, `false`.
    func isEqual(to transform: CATransform3D) -> Bool {
        CATransform3DEqualToTransform(self, transform)
    }
}
#endif
