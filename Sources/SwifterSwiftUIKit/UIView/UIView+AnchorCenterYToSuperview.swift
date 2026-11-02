// UIView+AnchorCenterYToSuperview.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIView {
    /// SwifterSwift: Centers the view vertically in its superview with Auto Layout.
    ///
    /// The method turns off `translatesAutoresizingMaskIntoConstraints`, then creates and activates a constraint
    /// between the view's center Y and its superview's. A positive constant moves the view down. A view without a
    /// superview is left untouched, and the result is `nil`.
    ///
    /// ```swift
    /// card.addSubview(titleLabel)
    /// titleLabel.anchorCenterYToSuperview(constant: -20)?.constant  // -20.0
    /// UIView().anchorCenterYToSuperview()  // nil
    /// ```
    ///
    /// - Parameter constant: The vertical offset of the view's center from its superview's center.
    /// - Returns: The activated constraint, or `nil` if the view has no superview.
    @discardableResult
    func anchorCenterYToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview else { return nil }
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
}
#endif
