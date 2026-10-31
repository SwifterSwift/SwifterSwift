// UIEdgeInsets+InitHorizontal.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    /// SwifterSwift: Creates edge insets with the same left and right inset and the same top and bottom inset.
    ///
    /// Each value is applied in full to both of its edges, the same way SwiftUI's `padding(.horizontal, _:)` works: a
    /// `horizontal` value of 16 insets the left edge by 16 and the right edge by 16. Either argument can be left out.
    ///
    /// ```swift
    /// UIEdgeInsets(horizontal: 16, vertical: 8)  // UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    /// UIEdgeInsets(horizontal: 16)  // UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    /// UIEdgeInsets(vertical: 8)  // UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    /// ```
    ///
    /// - Parameters:
    ///   - horizontal: The inset to apply to both the left and the right edges.
    ///   - vertical: The inset to apply to both the top and the bottom edges.
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
#endif
