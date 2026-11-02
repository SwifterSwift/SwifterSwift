// UIView+FadeIn.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIView {
    /// SwifterSwift: Shows the view and animates its alpha to `1`.
    ///
    /// A hidden view is first made transparent and then shown, so it fades in instead of appearing at once. A view
    /// that's already visible fades from its current alpha. Showing a hidden view changes layout when it's an arranged
    /// subview of a `UIStackView`. This is the counterpart of `fadeOut(duration:completion:)`.
    ///
    /// ```swift
    /// toastView.isHidden = true
    /// toastView.fadeIn(duration: 0.3)
    /// toastView.isHidden  // false
    /// toastView.alpha  // 1.0
    /// ```
    ///
    /// - Parameters:
    ///   - duration: The duration of the animation, in seconds.
    ///   - completion: A closure to run when the animation ends. Its argument is `false` if the animation was
    ///     interrupted.
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            alpha = 0
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: { self.alpha = 1 }, completion: completion)
    }
}
#endif
