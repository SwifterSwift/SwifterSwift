// UIStackView+RemoveArrangedSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIStackView {
    /// SwifterSwift: Removes all arranged subviews from the stack view and from the view hierarchy.
    ///
    /// `removeArrangedSubview(_:)` alone only stops the stack view from managing a view: the view stays a subview,
    /// so it's still drawn, without any layout. This method also removes each view from its superview, so the stack
    /// view ends up empty. Subviews that aren't arranged, such as a background view you added, are kept.
    ///
    /// ```swift
    /// let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    /// stack.removeArrangedSubviews()
    /// stack.arrangedSubviews  // []
    /// titleLabel.superview  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of arranged subviews.
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
#endif
