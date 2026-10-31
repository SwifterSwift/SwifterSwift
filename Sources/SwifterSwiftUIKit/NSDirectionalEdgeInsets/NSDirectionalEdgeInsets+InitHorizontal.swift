// NSDirectionalEdgeInsets+InitHorizontal.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: Creates insets with the same leading and trailing inset and the same top and bottom inset.
    ///
    /// Each value is applied in full to both of its edges, the same way SwiftUI's `padding(.horizontal, _:)` works: a
    /// `horizontal` value of 16 insets the leading edge by 16 and the trailing edge by 16. Either argument can be left
    /// out.
    ///
    /// ```swift
    /// NSDirectionalEdgeInsets(horizontal: 16, vertical: 8)
    /// // NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    /// NSDirectionalEdgeInsets(horizontal: 16)
    /// // NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    /// ```
    ///
    /// - Parameters:
    ///   - horizontal: The inset to apply to both the leading and the trailing edges.
    ///   - vertical: The inset to apply to both the top and the bottom edges.
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
#endif
