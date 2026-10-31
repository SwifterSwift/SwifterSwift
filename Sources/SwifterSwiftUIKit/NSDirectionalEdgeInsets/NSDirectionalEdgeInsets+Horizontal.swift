// NSDirectionalEdgeInsets+Horizontal.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension NSDirectionalEdgeInsets {
    /// SwifterSwift: The sum of the leading and trailing insets.
    ///
    /// Use it to find how much horizontal space the insets take up, for example when sizing content to fit inside a
    /// container. The total is the same for left-to-right and right-to-left layouts. Negative insets reduce the total.
    ///
    /// ```swift
    /// let insets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 24)
    /// insets.horizontal  // 40.0
    /// ```
    var horizontal: CGFloat {
        leading + trailing
    }
}
#endif
