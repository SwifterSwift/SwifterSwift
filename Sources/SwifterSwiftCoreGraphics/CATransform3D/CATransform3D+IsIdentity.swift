// CATransform3D+IsIdentity.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: A Boolean value that indicates whether the transform is the identity transform.
    ///
    /// This is the Swift spelling of `CATransform3DIsIdentity(_:)`, matching `CGAffineTransform.isIdentity`. Every
    /// element is compared exactly, so a transform that's only close to the identity isn't the identity.
    ///
    /// Core Animation isn't available on watchOS, so neither is this property.
    ///
    /// ```swift
    /// CATransform3DIdentity.isIdentity  // true
    /// CATransform3DMakeScale(2, 2, 1).isIdentity  // false
    /// ```
    var isIdentity: Bool {
        CATransform3DIsIdentity(self)
    }
}
#endif
