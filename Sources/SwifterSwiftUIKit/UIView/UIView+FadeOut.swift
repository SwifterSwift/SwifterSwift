// UIView+FadeOut.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIView {
    /// SwifterSwift: Animates the view's alpha to `0`, then hides it.
    ///
    /// When the animation ends, the view's `isHidden` is set to `true`, so it stops taking part in layout when it's an
    /// arranged subview of a `UIStackView`. The view isn't hidden when its alpha was changed again before the animation
    /// ended, for example by `fadeIn(duration:completion:)`. A view that's already hidden stays hidden and never
    /// flashes on screen.
    ///
    /// ```swift
    /// toastView.fadeOut(duration: 0.3) { _ in
    ///     toastView.isHidden  // true
    ///     toastView.alpha  // 0.0
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - duration: The duration of the animation, in seconds.
    ///   - completion: A closure to run when the animation ends, after the view is hidden. Its argument is `false` if
    ///     the animation was interrupted.
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: duration,
            animations: { self.alpha = 0 },
            completion: { finished in
                if self.alpha == 0 {
                    self.isHidden = true
                }
                completion?(finished)
            }
        )
    }
}
#endif
