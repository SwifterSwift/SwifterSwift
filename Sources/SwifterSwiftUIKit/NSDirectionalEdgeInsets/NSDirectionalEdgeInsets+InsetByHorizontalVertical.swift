// NSDirectionalEdgeInsets+InsetByHorizontalVertical.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: Returns the insets with one amount added to both horizontal edges and one to both vertical edges.
    ///
    /// Each amount is added in full to both of its edges: a `horizontal` amount of 4 adds 4 to the leading inset and 4
    /// to the trailing inset. Pass negative amounts to reduce the insets.
    ///
    /// ```swift
    /// let insets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    /// insets.insetBy(horizontal: 4)
    /// // NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
    /// insets.insetBy(horizontal: 4, vertical: -2)
    /// // NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14)
    /// ```
    ///
    /// - Parameters:
    ///   - horizontal: The amount to add to both the leading and the trailing insets.
    ///   - vertical: The amount to add to both the top and the bottom insets.
    /// - Returns: New directional edge insets with each edge increased by the matching amount.
    func insetBy(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(
            top: top + vertical,
            leading: leading + horizontal,
            bottom: bottom + vertical,
            trailing: trailing + horizontal
        )
    }
}
#endif
