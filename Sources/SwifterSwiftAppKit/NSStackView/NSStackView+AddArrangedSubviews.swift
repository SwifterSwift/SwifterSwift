// NSStackView+AddArrangedSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSStackView {
    /// SwifterSwift: Adds the given views to the end of the stack view's arranged subviews, in order.
    ///
    /// Each view is added with `addArrangedSubview(_:)`, which also makes it a subview of the stack view, moving it from
    /// any previous superview.
    ///
    /// ```swift
    /// let stack = NSStackView()
    /// stack.addArrangedSubviews([titleField, subtitleField, button])
    /// stack.arrangedSubviews  // [titleField, subtitleField, button]
    /// ```
    ///
    /// - Parameter views: The views to arrange, in order.
    /// - Complexity: O(*n*), where *n* is the number of views.
    func addArrangedSubviews(_ views: [NSView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
#endif
