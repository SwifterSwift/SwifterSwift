// UILabel+RequiredHeight.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UILabel {
    /// SwifterSwift: The height the label needs to show its text at its current width.
    ///
    /// The height is measured with `sizeThatFits(_:)` for the label's current `bounds.width` and an unlimited height,
    /// so it accounts for the label's text or attributed text, font, `numberOfLines` and `lineBreakMode`. A label with
    /// `numberOfLines` set to `1` reports the height of one line, however long its text.
    ///
    /// A label with no text needs no height, so the result is `0`. A label with a width of `0` doesn't wrap, so it
    /// reports the height of its text on a single line.
    ///
    /// ```swift
    /// let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 0))
    /// label.numberOfLines = 0
    /// label.text = "A long text that needs several lines"
    /// label.requiredHeight  // the height of all the lines at a width of 100
    /// ```
    var requiredHeight: CGFloat {
        sizeThatFits(CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
    }
}
#endif
