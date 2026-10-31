// UIEdgeInsets+Horizontal.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    /// SwifterSwift: The sum of the left and right insets.
    ///
    /// Use it to find how much horizontal space the insets take up, for example when sizing content to fit inside a
    /// container. Negative insets reduce the total.
    ///
    /// ```swift
    /// let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 24)
    /// insets.horizontal  // 40.0
    /// ```
    var horizontal: CGFloat {
        left + right
    }
}
#endif
