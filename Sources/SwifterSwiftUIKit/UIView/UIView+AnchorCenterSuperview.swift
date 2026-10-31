// UIView+AnchorCenterSuperview.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Centers the view in its superview with Auto Layout.
    ///
    /// The method turns off `translatesAutoresizingMaskIntoConstraints`, then creates and activates two constraints
    /// that align the view's center X and center Y with its superview's. A view without a superview is left untouched,
    /// and the result is empty.
    ///
    /// ```swift
    /// container.addSubview(spinner)
    /// spinner.anchorCenterSuperview().count  // 2
    /// UIView().anchorCenterSuperview()  // []
    /// ```
    ///
    /// - Returns: The activated center X and center Y constraints, in that order, or an empty array if the view has no
    ///   superview.
    @discardableResult
    func anchorCenterSuperview() -> [NSLayoutConstraint] {
        guard let superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
#endif
