// UIView+FillToSuperview.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Pins all four edges of the view to its superview with Auto Layout.
    ///
    /// The method turns off `translatesAutoresizingMaskIntoConstraints`, then creates and activates a top, leading,
    /// bottom and trailing constraint. Leading and trailing follow the layout direction, so the insets flip in
    /// right-to-left languages. Positive insets move the view's edges inward; negative insets let it overflow.
    ///
    /// When `respectingSafeArea` is `true`, the edges are pinned to the superview's `safeAreaLayoutGuide` instead of
    /// its edges, which keeps the view clear of the status bar, the home indicator and the bars of a navigation or tab
    /// bar controller. A view without a superview is left untouched, and the result is empty.
    ///
    /// ```swift
    /// container.addSubview(contentView)
    /// let constraints = contentView.fillToSuperview(
    ///     insets: NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    /// )
    /// constraints.count  // 4
    /// ```
    ///
    /// - Parameters:
    ///   - insets: The distances between the view's edges and the superview's edges.
    ///   - respectingSafeArea: Whether to pin to the superview's safe area instead of its edges.
    /// - Returns: The activated top, leading, bottom and trailing constraints, in that order, or an empty array if the
    ///   view has no superview.
    @discardableResult
    func fillToSuperview(
        insets: NSDirectionalEdgeInsets = .zero,
        respectingSafeArea: Bool = false
    ) -> [NSLayoutConstraint] {
        guard let superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        let guide = superview.safeAreaLayoutGuide
        let constraints = [
            topAnchor.constraint(
                equalTo: respectingSafeArea ? guide.topAnchor : superview.topAnchor,
                constant: insets.top
            ),
            leadingAnchor.constraint(
                equalTo: respectingSafeArea ? guide.leadingAnchor : superview.leadingAnchor,
                constant: insets.leading
            ),
            bottomAnchor.constraint(
                equalTo: respectingSafeArea ? guide.bottomAnchor : superview.bottomAnchor,
                constant: -insets.bottom
            ),
            trailingAnchor.constraint(
                equalTo: respectingSafeArea ? guide.trailingAnchor : superview.trailingAnchor,
                constant: -insets.trailing
            )
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
#endif
