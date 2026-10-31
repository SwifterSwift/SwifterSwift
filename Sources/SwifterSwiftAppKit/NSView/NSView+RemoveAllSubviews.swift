// NSView+RemoveAllSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSView {
    /// SwifterSwift: Removes all of the view's subviews.
    ///
    /// Each subview is removed with `removeFromSuperview()`, so it also loses its constraints to this view and its
    /// descendants. Only direct subviews are removed; their own subviews stay attached to them.
    ///
    /// ```swift
    /// let card = NSView()
    /// card.addSubview(titleField)
    /// card.addSubview(imageView)
    /// card.removeAllSubviews()
    /// card.subviews  // []
    /// titleField.superview  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of subviews.
    func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}
#endif
