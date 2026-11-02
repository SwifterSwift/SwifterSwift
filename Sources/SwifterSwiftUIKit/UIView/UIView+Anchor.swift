// UIView+Anchor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIView {
    /// SwifterSwift: Anchors any of the view's edges and sizes with Auto Layout, and returns the new constraints.
    ///
    /// The method creates and activates one constraint for each anchor or size you pass, and turns off
    /// `translatesAutoresizingMaskIntoConstraints` when it creates at least one. Edges you leave `nil` aren't
    /// constrained. A width or height of `0` creates a zero-size constraint; leave it `nil` to skip it.
    ///
    /// Positive constants move the view's edges inward: `topConstant` and `leadingConstant` are added, while
    /// `bottomConstant` and `trailingConstant` are subtracted. Leading and trailing follow the layout direction, so pass
    /// leading and trailing anchors for them. UIKit raises an exception for a constraint between a leading or trailing
    /// anchor and a left or right anchor.
    ///
    /// ```swift
    /// avatarView.anchor(
    ///     top: card.topAnchor,
    ///     leading: card.leadingAnchor,
    ///     topConstant: 16,
    ///     leadingConstant: 16,
    ///     widthConstant: 40,
    ///     heightConstant: 40
    /// ).count  // 4
    /// ```
    ///
    /// - Parameters:
    ///   - top: The anchor to pin the view's top edge to.
    ///   - leading: The anchor to pin the view's leading edge to.
    ///   - bottom: The anchor to pin the view's bottom edge to.
    ///   - trailing: The anchor to pin the view's trailing edge to.
    ///   - topConstant: The distance from `top` to the view's top edge.
    ///   - leadingConstant: The distance from `leading` to the view's leading edge.
    ///   - bottomConstant: The distance from the view's bottom edge to `bottom`.
    ///   - trailingConstant: The distance from the view's trailing edge to `trailing`.
    ///   - widthConstant: The width of the view, or `nil` to leave it unconstrained.
    ///   - heightConstant: The height of the view, or `nil` to leave it unconstrained.
    /// - Returns: The activated constraints, in the order top, leading, bottom, trailing, width, height, skipping the
    ///   ones that weren't requested.
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leadingConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        trailingConstant: CGFloat = 0,
        widthConstant: CGFloat? = nil,
        heightConstant: CGFloat? = nil
    ) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if let top {
            constraints.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let leading {
            constraints.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }
        if let bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        if let trailing {
            constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }
        if let widthConstant {
            constraints.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if let heightConstant {
            constraints.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        if !constraints.isEmpty {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
}
#endif
