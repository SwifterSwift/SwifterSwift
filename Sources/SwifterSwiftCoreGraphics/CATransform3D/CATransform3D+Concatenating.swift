// CATransform3D+Concatenating.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

public extension CATransform3D {
    /// SwifterSwift: Returns the transform that applies this transform and then another one.
    ///
    /// This is the Swift spelling of `CATransform3DConcat(_:_:)`, matching `CGAffineTransform.concatenating(_:)`. The
    /// order matters: this transform is applied first and `transform` second.
    ///
    /// Core Animation isn't available on watchOS, so neither is this method.
    ///
    /// ```swift
    /// let move = CATransform3DMakeTranslation(10, 0, 0)
    /// let grow = CATransform3DMakeScale(2, 2, 1)
    /// move.concatenating(grow).m41  // 20.0
    /// grow.concatenating(move).m41  // 10.0
    /// ```
    ///
    /// - Parameter transform: The transform to apply after this one.
    /// - Returns: A transform that applies this transform and then `transform`.
    func concatenating(_ transform: CATransform3D) -> CATransform3D {
        CATransform3DConcat(self, transform)
    }
}
#endif
