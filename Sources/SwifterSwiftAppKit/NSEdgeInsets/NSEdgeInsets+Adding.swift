// NSEdgeInsets+Adding.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: Returns the edge-by-edge sum of these insets and the given insets.
    ///
    /// Use it to combine insets, for example a view's safe area insets with its own padding.
    ///
    /// ```swift
    /// let safeArea = NSEdgeInsets(top: 28, left: 0, bottom: 0, right: 0)
    /// let padding = NSEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    /// safeArea.adding(padding)  // NSEdgeInsets(top: 36, left: 16, bottom: 8, right: 16)
    /// ```
    ///
    /// - Parameter other: The insets to add.
    /// - Returns: New edge insets where each edge is the sum of the matching edges of both insets.
    func adding(_ other: NSEdgeInsets) -> NSEdgeInsets {
        NSEdgeInsets(
            top: top + other.top, left: left + other.left, bottom: bottom + other.bottom, right: right + other.right)
    }
}
#endif
