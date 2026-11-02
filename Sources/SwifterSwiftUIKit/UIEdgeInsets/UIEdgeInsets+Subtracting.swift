// UIEdgeInsets+Subtracting.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    /// SwifterSwift: Returns the edge-by-edge difference of these insets and the given insets.
    ///
    /// Edges can become negative when `other` is larger.
    ///
    /// ```swift
    /// let insets = UIEdgeInsets(top: 67, left: 16, bottom: 42, right: 16)
    /// let padding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    /// insets.subtracting(padding)  // UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0)
    /// ```
    ///
    /// - Parameter other: The insets to subtract.
    /// - Returns: New edge insets where each edge is this edge minus the matching edge of `other`.
    func subtracting(_ other: UIEdgeInsets) -> UIEdgeInsets {
        UIEdgeInsets(
            top: top - other.top, left: left - other.left, bottom: bottom - other.bottom, right: right - other.right)
    }
}
#endif
