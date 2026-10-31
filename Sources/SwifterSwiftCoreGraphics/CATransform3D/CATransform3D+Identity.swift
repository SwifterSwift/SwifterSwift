// CATransform3D+Identity.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: The identity transform, which leaves a layer unchanged.
    ///
    /// This is the `CATransform3DIdentity` constant spelled as a static property, like `CGAffineTransform.identity`,
    /// so it works with type inference and as the start of a chain of transforms.
    ///
    /// Core Animation isn't available on watchOS, so neither is this property.
    ///
    /// ```swift
    /// layer.transform = .identity
    /// CATransform3D.identity.m11  // 1.0
    /// CATransform3D.identity.m41  // 0.0
    /// ```
    static var identity: CATransform3D {
        CATransform3DIdentity
    }
}
#endif
