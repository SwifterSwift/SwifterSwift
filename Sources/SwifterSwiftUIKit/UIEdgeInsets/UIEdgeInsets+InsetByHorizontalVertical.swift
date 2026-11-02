// UIEdgeInsets+InsetByHorizontalVertical.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    /// SwifterSwift: Returns the insets with one amount added to both horizontal edges and one to both vertical edges.
    ///
    /// Each amount is added in full to both of its edges: a `horizontal` amount of 4 adds 4 to the left inset and 4 to
    /// the right inset. Pass negative amounts to reduce the insets.
    ///
    /// ```swift
    /// let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    /// insets.insetBy(horizontal: 4)  // UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
    /// insets.insetBy(horizontal: 4, vertical: -2)  // UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
    /// ```
    ///
    /// - Parameters:
    ///   - horizontal: The amount to add to both the left and the right insets.
    ///   - vertical: The amount to add to both the top and the bottom insets.
    /// - Returns: New edge insets with each edge increased by the matching amount.
    func insetBy(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> UIEdgeInsets {
        UIEdgeInsets(top: top + vertical, left: left + horizontal, bottom: bottom + vertical, right: right + horizontal)
    }
}
#endif
