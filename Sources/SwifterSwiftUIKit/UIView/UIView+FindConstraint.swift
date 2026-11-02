// UIView+FindConstraint.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Returns the first active constraint that involves the given attribute of the given view.
    ///
    /// Auto Layout installs a constraint on the closest common ancestor of its views, so the search looks at this
    /// view's `constraints` first, then at each superview's, up to the root. A constraint matches when its first or
    /// second item is `view` with `attribute`. Call the method on `view` itself or one of its descendants: constraints
    /// installed on a view's own subviews aren't searched.
    ///
    /// Only active constraints are found, because deactivated ones are removed from the hierarchy. The search also
    /// returns constraints UIKit creates, such as the ones from `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// ```swift
    /// container.addSubview(badge)
    /// NSLayoutConstraint.activate([
    ///     badge.widthAnchor.constraint(equalToConstant: 20),
    ///     badge.topAnchor.constraint(equalTo: container.topAnchor, constant: 8)
    /// ])
    /// badge.findConstraint(attribute: .width, for: badge)?.constant  // 20.0
    /// badge.findConstraint(attribute: .top, for: badge)?.constant  // 8.0
    /// badge.findConstraint(attribute: .height, for: badge)  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - attribute: The layout attribute to look for.
    ///   - view: The view whose constraint to find.
    /// - Returns: The first matching constraint, or `nil` if there's none.
    /// - Complexity: O(*n*), where *n* is the number of constraints installed on this view and its ancestors.
    func findConstraint(attribute: NSLayoutConstraint.Attribute, for view: UIView) -> NSLayoutConstraint? {
        var candidate: UIView? = self
        while let current = candidate {
            let match = current.constraints.first { constraint in
                (constraint.firstAttribute == attribute && constraint.firstItem === view)
                    || (constraint.secondAttribute == attribute && constraint.secondItem === view)
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
