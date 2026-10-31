// UITextField+AddPaddingLeft.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UITextField {
    /// SwifterSwift: Adds empty space before the text on the left side of the text field.
    ///
    /// UITextField has no text inset property, so the padding is an empty `leftView` of the given width, shown with
    /// `leftViewMode` set to `.always`. This replaces any existing left view. Negative values are treated as `0`.
    ///
    /// ```swift
    /// let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    /// textField.addPaddingLeft(12)
    /// textField.leftView?.frame.width  // 12.0
    /// textField.leftViewMode  // .always
    /// ```
    ///
    /// - Parameter padding: The width of the space, in points.
    func addPaddingLeft(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: max(0, padding), height: bounds.height))
        leftViewMode = .always
    }
}
#endif
