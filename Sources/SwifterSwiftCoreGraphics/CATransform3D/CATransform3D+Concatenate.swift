// CATransform3D+Concatenate.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Appends another transform to this one, in place.
    ///
    /// This is the in-place form of `concatenating(_:)`: it replaces the transform with
    /// `CATransform3DConcat(self, transform)`. The order matters: the existing transform is applied first and
    /// `transform` second.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// var transform = CATransform3DMakeTranslation(10, 0, 0)
    /// transform.concatenate(CATransform3DMakeScale(2, 2, 1))
    /// transform.m11  // 2.0
    /// transform.m41  // 20.0
    /// ```
    ///
    /// - Parameter transform: The transform to apply after this one.
    mutating func concatenate(_ transform: CATransform3D) {
        self = CATransform3DConcat(self, transform)
    }
}
#endif
