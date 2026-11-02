// NSEdgeInsets+InitAll.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation

public extension NSEdgeInsets {
    /// SwifterSwift: Creates edge insets with the same value on all four edges.
    ///
    /// ```swift
    /// NSEdgeInsets(all: 8)  // NSEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    /// NSEdgeInsets(all: -4)  // NSEdgeInsets(top: -4, left: -4, bottom: -4, right: -4)
    /// ```
    ///
    /// - Parameter inset: The inset to apply to the top, left, bottom and right edges.
    init(all inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
}
#endif
