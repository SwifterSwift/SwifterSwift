// NSEdgeInsets+Vertical.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: The sum of the top and bottom insets.
    ///
    /// Use it to find how much vertical space the insets take up, for example when sizing content to fit inside a
    /// container. Negative insets reduce the total.
    ///
    /// ```swift
    /// let insets = NSEdgeInsets(top: 8, left: 16, bottom: 12, right: 16)
    /// insets.vertical  // 20.0
    /// ```
    var vertical: CGFloat {
        top + bottom
    }
}
#endif
