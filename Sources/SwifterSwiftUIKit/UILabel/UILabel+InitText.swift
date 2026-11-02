// UILabel+InitText.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UILabel {
    /// SwifterSwift: Creates a label with the given text, using the preferred font for a text style.
    ///
    /// The font comes from `UIFont.preferredFont(forTextStyle:)`, and `adjustsFontForContentSizeCategory` is turned
    /// on, so the label follows the user's Dynamic Type setting and updates live when it changes. Setting only `font`
    /// to a preferred font isn't enough for that: the font keeps the size it had when you set it.
    ///
    /// ```swift
    /// let titleLabel = UILabel(text: "Settings", style: .headline)
    /// titleLabel.font  // the preferred headline font
    /// titleLabel.adjustsFontForContentSizeCategory  // true
    /// ```
    ///
    /// - Parameters:
    ///   - text: The text of the label.
    ///   - style: The text style that determines the label's font.
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init()
        font = UIFont.preferredFont(forTextStyle: style)
        adjustsFontForContentSizeCategory = true
        self.text = text
    }
}
#endif
