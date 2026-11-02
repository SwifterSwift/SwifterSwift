// UIView+AnchorCenterXToSuperview.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIView {
    /// SwifterSwift: Centers the view horizontally in its superview with Auto Layout.
    ///
    /// The method turns off `translatesAutoresizingMaskIntoConstraints`, then creates and activates a constraint
    /// between the view's center X and its superview's. A positive constant moves the view to the right, in every
    /// layout direction. A view without a superview is left untouched, and the result is `nil`.
    ///
    /// ```swift
    /// card.addSubview(titleLabel)
    /// titleLabel.anchorCenterXToSuperview(constant: 10)?.constant  // 10.0
    /// UIView().anchorCenterXToSuperview()  // nil
    /// ```
    ///
    /// - Parameter constant: The horizontal offset of the view's center from its superview's center.
    /// - Returns: The activated constraint, or `nil` if the view has no superview.
    @discardableResult
    func anchorCenterXToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview else { return nil }
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
}
#endif
