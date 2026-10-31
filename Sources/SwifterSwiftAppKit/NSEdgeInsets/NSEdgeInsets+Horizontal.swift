// NSEdgeInsets+Horizontal.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: The sum of the left and right insets.
    ///
    /// Use it to find how much horizontal space the insets take up, for example when sizing content to fit inside a
    /// container. Negative insets reduce the total.
    ///
    /// ```swift
    /// let insets = NSEdgeInsets(top: 8, left: 16, bottom: 8, right: 24)
    /// insets.horizontal  // 40.0
    /// ```
    var horizontal: CGFloat {
        left + right
    }
}
#endif
