// NSEdgeInsets+InsetByTopLeftBottomRight.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: Returns the insets with the given amounts added to their edges.
    ///
    /// Each amount is added to the matching edge, and edges you leave out keep their value. Pass negative amounts to
    /// reduce an edge.
    ///
    /// ```swift
    /// let insets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    /// insets.insetBy(top: 5)  // NSEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
    /// insets.insetBy(left: 4, right: -4)  // NSEdgeInsets(top: 10, left: 14, bottom: 10, right: 6)
    /// ```
    ///
    /// - Parameters:
    ///   - top: The amount to add to the top inset.
    ///   - left: The amount to add to the left inset.
    ///   - bottom: The amount to add to the bottom inset.
    ///   - right: The amount to add to the right inset.
    /// - Returns: New edge insets with each edge increased by the matching amount.
    func insetBy(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> NSEdgeInsets {
        NSEdgeInsets(
            top: self.top + top, left: self.left + left, bottom: self.bottom + bottom, right: self.right + right)
    }
}
#endif
