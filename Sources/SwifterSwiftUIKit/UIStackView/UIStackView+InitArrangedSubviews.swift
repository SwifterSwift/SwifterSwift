// UIStackView+InitArrangedSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIStackView {
    /// SwifterSwift: Creates a stack view that manages the given views and lays them out with the given settings.
    ///
    /// This is `init(arrangedSubviews:)` followed by setting `axis`, `spacing`, `alignment` and `distribution`, so the
    /// whole stack view can be configured in one expression. The defaults match a new `UIStackView`, except for `axis`,
    /// which is required. The views are arranged in order, and a view that already has a superview is moved here.
    ///
    /// ```swift
    /// let stack = UIStackView(arrangedSubviews: [iconView, titleLabel], axis: .horizontal, spacing: 8)
    /// stack.arrangedSubviews  // [iconView, titleLabel]
    /// stack.alignment  // .fill
    /// ```
    ///
    /// - Parameters:
    ///   - arrangedSubviews: The views to arrange, in order.
    ///   - axis: The axis along which the views are laid out.
    ///   - spacing: The distance between adjacent views, in points.
    ///   - alignment: The alignment of the views perpendicular to the axis.
    ///   - distribution: The distribution of the views along the axis.
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
#endif
