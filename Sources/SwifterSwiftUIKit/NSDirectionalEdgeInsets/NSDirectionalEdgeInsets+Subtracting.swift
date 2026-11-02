// NSDirectionalEdgeInsets+Subtracting.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: Returns the edge-by-edge difference of these insets and the given insets.
    ///
    /// Edges can become negative when `other` is larger.
    ///
    /// ```swift
    /// let insets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 32)
    /// let padding = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 12)
    /// insets.subtracting(padding)  // NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
    /// ```
    ///
    /// - Parameter other: The insets to subtract.
    /// - Returns: New directional edge insets where each edge is this edge minus the matching edge of `other`.
    func subtracting(_ other: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(
            top: top - other.top,
            leading: leading - other.leading,
            bottom: bottom - other.bottom,
            trailing: trailing - other.trailing
        )
    }
}
#endif
