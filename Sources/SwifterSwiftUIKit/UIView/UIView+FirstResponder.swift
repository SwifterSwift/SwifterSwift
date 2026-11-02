// UIView+FirstResponder.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Returns the first responder in the view hierarchy rooted at this view.
    ///
    /// UIKit has no public API that returns the current first responder. This method searches the view and all of its
    /// descendants breadth-first, so it returns the view itself when the view is the first responder. Only views are
    /// checked: when the first responder is a view controller or lives outside this hierarchy, the result is `nil`.
    ///
    /// ```swift
    /// emailField.becomeFirstResponder()
    /// formView.firstResponder()  // emailField
    /// emailField.resignFirstResponder()
    /// formView.firstResponder()  // nil
    /// ```
    ///
    /// - Returns: The view in this hierarchy that is the first responder, or `nil` if there's none.
    /// - Complexity: O(*n*), where *n* is the number of views in the hierarchy.
    func firstResponder() -> UIView? {
        var queue: [UIView] = [self]
        var index = 0
        while index < queue.count {
            let view = queue[index]
            if view.isFirstResponder {
                return view
            }
            queue.append(contentsOf: view.subviews)
            index += 1
        }
        return nil
    }
}
#endif
