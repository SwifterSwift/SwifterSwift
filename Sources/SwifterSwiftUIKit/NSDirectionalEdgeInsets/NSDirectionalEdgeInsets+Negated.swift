// NSDirectionalEdgeInsets+Negated.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: Returns the insets with the sign of every edge flipped.
    ///
    /// Negated insets push content outward instead of inward, for example to let a view extend past its margins.
    ///
    /// ```swift
    /// let insets = NSDirectionalEdgeInsets(top: 8, leading: -4, bottom: 0, trailing: 16)
    /// insets.negated()  // NSDirectionalEdgeInsets(top: -8, leading: 4, bottom: 0, trailing: -16)
    /// ```
    ///
    /// - Returns: New directional edge insets where each edge is the negation of the matching edge.
    func negated() -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
    }
}
#endif
