// UITextField+AddPaddingRight.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UITextField {
    /// SwifterSwift: Adds empty space after the text on the right side of the text field.
    ///
    /// UITextField has no text inset property, so the padding is an empty `rightView` of the given width, shown with
    /// `rightViewMode` set to `.always`. This replaces any existing right view, such as a clear button set as the
    /// right view. Negative values are treated as `0`.
    ///
    /// ```swift
    /// let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    /// textField.addPaddingRight(12)
    /// textField.rightView?.frame.width  // 12.0
    /// textField.rightViewMode  // .always
    /// ```
    ///
    /// - Parameter padding: The width of the space, in points.
    func addPaddingRight(_ padding: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: max(0, padding), height: bounds.height))
        rightViewMode = .always
    }
}
#endif
