// NSDirectionalEdgeInsets+InitAll.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: Creates directional edge insets with the same value on all four edges.
    ///
    /// ```swift
    /// NSDirectionalEdgeInsets(all: 8)  // NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    /// NSDirectionalEdgeInsets(all: -4)  // NSDirectionalEdgeInsets(top: -4, leading: -4, bottom: -4, trailing: -4)
    /// ```
    ///
    /// - Parameter inset: The inset to apply to the top, leading, bottom and trailing edges.
    init(all inset: CGFloat) {
        self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    }
}
#endif
