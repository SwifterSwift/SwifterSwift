// UIEdgeInsets+Vertical.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    /// SwifterSwift: The sum of the top and bottom insets.
    ///
    /// Use it to find how much vertical space the insets take up, for example when sizing content to fit inside a
    /// container. Negative insets reduce the total.
    ///
    /// ```swift
    /// let insets = UIEdgeInsets(top: 8, left: 16, bottom: 12, right: 16)
    /// insets.vertical  // 20.0
    /// ```
    var vertical: CGFloat {
        top + bottom
    }
}
#endif
