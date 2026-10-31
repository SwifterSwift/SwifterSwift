// NSStackView+RemoveArrangedSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSStackView {
    /// SwifterSwift: Removes all arranged subviews from the stack view, and from its view hierarchy.
    ///
    /// `removeArrangedSubview(_:)` alone only stops the stack view from managing a view: the view stays a subview, still
    /// visible but no longer laid out. This method also removes each view from the stack view's subviews. Subviews that
    /// aren't arranged, such as ones added with `addSubview(_:)`, are kept.
    ///
    /// ```swift
    /// let stack = NSStackView(views: [titleField, subtitleField])
    /// stack.removeArrangedSubviews()
    /// stack.arrangedSubviews  // []
    /// stack.subviews  // []
    /// titleField.superview  // nil
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
