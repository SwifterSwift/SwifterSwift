// NSEdgeInsets+Subtracting.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: Returns the edge-by-edge difference of these insets and the given insets.
    ///
    /// Edges can become negative when `other` is larger.
    ///
    /// ```swift
    /// let insets = NSEdgeInsets(top: 36, left: 16, bottom: 8, right: 16)
    /// let padding = NSEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    /// insets.subtracting(padding)  // NSEdgeInsets(top: 28, left: 0, bottom: 0, right: 0)
    /// ```
    ///
    /// - Parameter other: The insets to subtract.
    /// - Returns: New edge insets where each edge is this edge minus the matching edge of `other`.
    func subtracting(_ other: NSEdgeInsets) -> NSEdgeInsets {
        NSEdgeInsets(
            top: top - other.top, left: left - other.left, bottom: bottom - other.bottom, right: right - other.right)
    }
}
#endif
