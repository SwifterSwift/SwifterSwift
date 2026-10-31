// UIStackView+AddArrangedSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIStackView {
    /// SwifterSwift: Adds the given views to the end of the stack view's arranged subviews, in order.
    ///
    /// Each view is added with `addArrangedSubview(_:)`, which also makes it a subview of the stack view. A view that
    /// has another superview is moved here, and a view that's already arranged here is moved to the end.
    ///
    /// ```swift
    /// let stack = UIStackView()
    /// stack.addArrangedSubviews([titleLabel, subtitleLabel])
    /// stack.arrangedSubviews  // [titleLabel, subtitleLabel]
    /// ```
    ///
    /// - Parameter views: The views to arrange, in order.
    /// - Complexity: O(*n*), where *n* is the number of views.
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
#endif
