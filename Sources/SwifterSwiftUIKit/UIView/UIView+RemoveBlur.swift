// UIView+RemoveBlur.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Removes every blur effect view from the view's direct subviews.
    ///
    /// A subview is removed when it's a `UIVisualEffectView` whose effect is a `UIBlurEffect`, such as the one
    /// `blur(withStyle:)` adds. Visual effect views with other effects, like `UIVibrancyEffect`, and blur views deeper in
    /// the hierarchy are kept.
    ///
    /// ```swift
    /// photoView.blur(withStyle: .dark)
    /// photoView.removeBlur()
    /// photoView.subviews.contains { $0 is UIVisualEffectView }  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of subviews.
    func removeBlur() {
        for case let effectView as UIVisualEffectView in subviews where effectView.effect is UIBlurEffect {
            effectView.removeFromSuperview()
        }
    }
}
#endif
