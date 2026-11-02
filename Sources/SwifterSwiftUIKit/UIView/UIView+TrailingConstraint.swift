// UIView+TrailingConstraint.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: The first active constraint that involves the view's trailing edge.
    ///
    /// Auto Layout installs a constraint on the closest common ancestor of its views, so the search looks at this
    /// view's `constraints` first, then at each superview's, up to the root. A constraint matches when its first or
    /// second item is this view with the `.trailing` attribute, whichever side of the constraint the view is on.
    ///
    /// Only active constraints are found, because deactivated ones are removed from the hierarchy. The search also
    /// returns constraints UIKit creates, such as the ones from `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// ```swift
    /// container.addSubview(badge)
    /// container.trailingAnchor.constraint(equalTo: badge.trailingAnchor, constant: 16).isActive = true
    /// badge.trailingConstraint?.constant  // 16.0
    /// UIView().trailingConstraint  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of constraints installed on this view and its ancestors.
    var trailingConstraint: NSLayoutConstraint? {
        var candidate: UIView? = self
        while let current = candidate {
            let match = current.constraints.first { constraint in
                (constraint.firstAttribute == .trailing && constraint.firstItem === self)
                    || (constraint.secondAttribute == .trailing && constraint.secondItem === self)
            }
            if let match {
                return match
            }
            candidate = current.superview
        }
        return nil
    }
}
#endif
