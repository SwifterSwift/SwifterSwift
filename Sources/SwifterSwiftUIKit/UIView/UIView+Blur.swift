// UIView+Blur.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Blurs the view's content with a visual effect view that fills its bounds.
    ///
    /// The first call adds a `UIVisualEffectView` with a `UIBlurEffect` on top of the existing subviews. It fills the
    /// view's bounds and resizes with the view. Calling the method again doesn't stack another effect view: it reuses
    /// the view's existing blur effect view, changes its style, and returns it. Remove the blur with `removeBlur()`, or
    /// by removing the returned view from its superview.
    ///
    /// The blur doesn't clip anything. To round its corners, set `layer.cornerRadius` and `clipsToBounds` on the
    /// returned view.
    ///
    /// ```swift
    /// let blurView = photoView.blur(withStyle: .dark)
    /// blurView.frame == photoView.bounds  // true
    /// photoView.blur(withStyle: .light) === blurView  // true
    /// ```
    ///
    /// - Parameter style: The style of the blur effect.
    /// - Returns: The visual effect view that blurs the view.
    /// - Complexity: O(*n*), where *n* is the number of subviews.
    @discardableResult
    func blur(withStyle style: UIBlurEffect.Style = .light) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: style)
        for case let effectView as UIVisualEffectView in subviews where effectView.effect is UIBlurEffect {
            effectView.effect = effect
            return effectView
        }
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(effectView)
        return effectView
    }
}
#endif
