// NSEdgeInsets+Zero.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: Edge insets whose top, left, bottom and right values are all 0.
    ///
    /// `UIEdgeInsets` has a `zero` property, but Foundation only offers the global constant `NSEdgeInsetsZero` for
    /// `NSEdgeInsets`. This property gives AppKit code the same spelling.
    ///
    /// ```swift
    /// let insets = NSEdgeInsets.zero
    /// insets.top  // 0.0
    /// insets.left  // 0.0
    /// ```
    static var zero: NSEdgeInsets {
        NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
#endif
