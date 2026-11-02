// UIView+RemoveAllSubviews.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Removes every subview from the view.
    ///
    /// Each subview is removed with `removeFromSuperview()`, which also deactivates the constraints between it and the
    /// rest of the hierarchy, and removes it from `arrangedSubviews` when the view is a `UIStackView`.
    ///
    /// The method removes *all* direct subviews, including the ones UIKit adds to its own views. On a container such
    /// as `UITableViewCell`, `UICollectionViewCell` or `UIVisualEffectView`, call it on the `contentView` instead.
    ///
    /// ```swift
    /// card.addSubviews([titleLabel, imageView])
    /// card.removeAllSubviews()
    /// card.subviews  // []
    /// titleLabel.superview  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of subviews.
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
#endif
