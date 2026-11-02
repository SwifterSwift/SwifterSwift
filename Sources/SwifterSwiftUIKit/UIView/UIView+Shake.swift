// UIView+Shake.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Shakes the view back and forth along an axis, like a rejected password field.
    ///
    /// The view moves `amplitude` points to each side twice, then half and a quarter as far, and comes back to rest.
    /// The movement is a Core Animation keyframe animation on the layer's translation that's added on top of the view's
    /// current `transform`, so the view's frame, transform and constraints never change. Calling the method while a
    /// shake is running restarts it.
    ///
    /// A `duration` of `0` uses Core Animation's default duration of 0.25 seconds.
    ///
    /// ```swift
    /// passwordField.shake()
    /// passwordField.shake(direction: .vertical, amplitude: 8, duration: 0.4, timingFunction: .linear) {
    ///     passwordField.becomeFirstResponder()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - direction: The axis to shake the view along.
    ///   - amplitude: The largest distance the view moves from its position, in points.
    ///   - duration: The duration of the animation, in seconds.
    ///   - timingFunction: The pacing of the animation.
    ///   - completion: A closure to run when the animation ends or is removed.
    func shake(
        direction: NSLayoutConstraint.Axis = .horizontal,
        amplitude: CGFloat = 20,
        duration: TimeInterval = 1,
        timingFunction: CAMediaTimingFunctionName = .easeOut,
        completion: (() -> Void)? = nil
    ) {
        let keyPath = direction == .vertical ? "transform.translation.y" : "transform.translation.x"
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.values = [-1, 1, -1, 1, -0.5, 0.5, -0.25, 0.25, 0].map { $0 * amplitude }
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: timingFunction)
        animation.isAdditive = true
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
}
#endif
