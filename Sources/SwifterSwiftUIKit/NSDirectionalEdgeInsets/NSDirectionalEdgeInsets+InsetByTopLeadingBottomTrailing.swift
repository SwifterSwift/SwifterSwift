// NSDirectionalEdgeInsets+InsetByTopLeadingBottomTrailing.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: Returns the insets with the given amounts added to their edges.
    ///
    /// Each amount is added to the matching edge, and edges you leave out keep their value. Pass negative amounts to
    /// reduce an edge.
    ///
    /// ```swift
    /// let insets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    /// insets.insetBy(top: 5)
    /// // NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10)
    /// insets.insetBy(leading: 4, trailing: -4)
    /// // NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 6)
    /// ```
    ///
    /// - Parameters:
    ///   - top: The amount to add to the top inset.
    ///   - leading: The amount to add to the leading inset.
    ///   - bottom: The amount to add to the bottom inset.
    ///   - trailing: The amount to add to the trailing inset.
    /// - Returns: New directional edge insets with each edge increased by the matching amount.
    func insetBy(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(
            top: self.top + top,
            leading: self.leading + leading,
            bottom: self.bottom + bottom,
            trailing: self.trailing + trailing
        )
    }
}
#endif
