// UIView+Scale.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import UIKit

public extension UIView {
    /// SwifterSwift: Scales the view by the given factors, relative to its current scale.
    ///
    /// The scale is applied to the view's `transform`, around its center, and keeps any rotation or translation the
    /// transform already has. A factor of `1` keeps that axis unchanged, `2` doubles it, and a negative factor also
    /// mirrors the view. The view's `frame` changes with the transform, but its `bounds` don't.
    ///
    /// When `animated` is `false`, the transform changes at once and `completion` runs before the method returns.
    /// Otherwise the change is animated with a linear curve.
    ///
    /// ```swift
    /// let badge = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    /// badge.scale(byX: 2, y: 0.5)
    /// badge.frame.size  // (40.0, 10.0)
    /// badge.bounds.size  // (20.0, 20.0)
    /// ```
    ///
    /// - Parameters:
    ///   - x: The factor to scale the view's width by.
    ///   - y: The factor to scale the view's height by.
    ///   - animated: Whether to animate the change.
    ///   - duration: The duration of the animation, in seconds. It's ignored when `animated` is `false`.
    ///   - completion: A closure to run when the change ends. Its argument is `false` if the animation was
    ///     interrupted.
    func scale(
        byX x: CGFloat,
        y: CGFloat,
        animated: Bool = false,
        duration: TimeInterval = 1,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard animated else {
            transform = transform.scaledBy(x: x, y: y)
            completion?(true)
            return
        }
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .curveLinear,
            animations: { self.transform = self.transform.scaledBy(x: x, y: y) },
            completion: completion
        )
    }
}
#endif
