// NSDirectionalEdgeInsets+Adding.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: Returns the edge-by-edge sum of these insets and the given insets.
    ///
    /// Use it to combine insets, for example a layout's base margins with extra padding.
    ///
    /// ```swift
    /// let margins = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
    /// let padding = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 12)
    /// margins.adding(padding)  // NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 32)
    /// ```
    ///
    /// - Parameter other: The insets to add.
    /// - Returns: New directional edge insets where each edge is the sum of the matching edges of both insets.
    func adding(_ other: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(
            top: top + other.top,
            leading: leading + other.leading,
            bottom: bottom + other.bottom,
            trailing: trailing + other.trailing
        )
    }
}
#endif
