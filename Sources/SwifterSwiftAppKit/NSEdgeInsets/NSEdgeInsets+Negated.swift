// NSEdgeInsets+Negated.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: Returns the insets with the sign of every edge flipped.
    ///
    /// Negated insets push content outward instead of inward, for example to let a view extend past its margins.
    ///
    /// ```swift
    /// let insets = NSEdgeInsets(top: 8, left: -4, bottom: 0, right: 16)
    /// insets.negated()  // NSEdgeInsets(top: -8, left: 4, bottom: 0, right: -16)
    /// ```
    ///
    /// - Returns: New edge insets where each edge is the negation of the matching edge.
    func negated() -> NSEdgeInsets {
        NSEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}
#endif
