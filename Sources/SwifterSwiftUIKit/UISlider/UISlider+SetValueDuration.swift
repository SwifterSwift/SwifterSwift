// UISlider+SetValueDuration.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import Foundation
import UIKit

public extension UISlider {
    /// SwifterSwift: Sets the slider's value, animating over a given duration, then calls a closure when done.
    ///
    /// UIKit's `setValue(_:animated:)` animates with a fixed system duration and has no completion. This method wraps
    /// it in a `UIView` animation of the duration you choose. When `animated` is `false`, the value is set right away
    /// and the closure is called before this method returns; when it's `true`, the closure is called when the
    /// animation ends.
    ///
    /// As with `setValue(_:animated:)`, the value is clamped to the slider's `minimumValue` and `maximumValue`. Setting
    /// the value doesn't send `.valueChanged` actions.
    ///
    /// ```swift
    /// slider.setValue(0.75, duration: 0.3) {
    ///     slider.value  // 0.75
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - value: The new value of the slider.
    ///   - animated: Whether to animate the change. The default is `true`.
    ///   - duration: The duration of the animation, in seconds. It's ignored when `animated` is `false`.
    ///   - completion: The closure to call after the value has changed, or `nil`.
    func setValue(
        _ value: Float,
        animated: Bool = true,
        duration: TimeInterval,
        completion: (@MainActor () -> Void)? = nil
    ) {
        guard animated else {
            setValue(value, animated: false)
            completion?()
            return
        }
        UIView.animate(
            withDuration: duration,
            animations: {
                self.setValue(value, animated: true)
            },
            completion: { _ in
                completion?()
            }
        )
    }
}
#endif
