// UIView+AncestorViewWhere.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Returns the closest ancestor of the view that satisfies the given predicate.
    ///
    /// The search starts at the view's superview and walks up to the root, so the view itself is never returned. The
    /// predicate isn't called once the root is passed, and the result is `nil` for a view without a superview.
    ///
    /// ```swift
    /// card.tag = 7
    /// card.addSubview(button)
    /// button.addSubview(icon)
    /// icon.ancestorView { $0.tag == 7 }  // card
    /// icon.ancestorView { $0 is UIButton }  // button
    /// icon.ancestorView { $0.tag == 99 }  // nil
    /// ```
    ///
    /// - Parameter predicate: A closure that takes an ancestor and returns whether it's the one to find.
    /// - Returns: The closest ancestor for which `predicate` returns `true`, or `nil` if there's none.
    /// - Throws: Rethrows any error thrown by `predicate`.
    /// - Complexity: O(*n*), where *n* is the number of ancestors of the view.
    func ancestorView(where predicate: (UIView) throws -> Bool) rethrows -> UIView? {
        var candidate = superview
        while let view = candidate {
            if try predicate(view) {
                return view
            }
            candidate = view.superview
        }
        return nil
    }
}
#endif
