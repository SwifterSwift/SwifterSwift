// UIEdgeInsets+Negated.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    /// SwifterSwift: Returns the insets with the sign of every edge flipped.
    ///
    /// Negated insets grow a rectangle instead of shrinking it, so `rect.inset(by: insets.negated())` undoes
    /// `rect.inset(by: insets)`.
    ///
    /// ```swift
    /// let insets = UIEdgeInsets(top: 8, left: -4, bottom: 0, right: 16)
    /// insets.negated()  // UIEdgeInsets(top: -8, left: 4, bottom: 0, right: -16)
    /// ```
    ///
    /// - Returns: New edge insets where each edge is the negation of the matching edge.
    func negated() -> UIEdgeInsets {
        UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}
#endif
