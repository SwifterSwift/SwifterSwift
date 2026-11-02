// NSView+AddSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSView {
    /// SwifterSwift: Adds the given views to the end of the view's list of subviews, in order.
    ///
    /// Each view is added with `addSubview(_:)`, so a view that already has a superview is moved here, and a view that
    /// is already a subview is moved to the front.
    ///
    /// ```swift
    /// let card = NSView()
    /// card.addSubviews([titleField, subtitleField, imageView])
    /// card.subviews  // [titleField, subtitleField, imageView]
    /// ```
    ///
    /// - Parameter views: The views to add, from back to front.
    func addSubviews(_ views: [NSView]) {
        for view in views {
            addSubview(view)
        }
    }
}
#endif
