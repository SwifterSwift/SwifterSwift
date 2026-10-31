// UITextField+SetPlaceholderColor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UITextField {
    /// SwifterSwift: Sets the color of the text field's current placeholder.
    ///
    /// The color is applied to the whole `attributedPlaceholder`, and every other attribute, such as a font or a
    /// paragraph style, is kept. A text field with no placeholder, or an empty one, is left unchanged.
    ///
    /// The color is applied to the placeholder as it is now. Whether a later change of `placeholder` keeps it is up to
    /// UIKit, so call this method again after changing the placeholder text.
    ///
    /// ```swift
    /// textField.placeholder = "Email"
    /// textField.setPlaceholderColor(.secondaryLabel)
    /// textField.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil)  // .secondaryLabel
    /// ```
    ///
    /// - Parameter color: The color of the placeholder text.
    func setPlaceholderColor(_ color: UIColor) {
        guard let placeholder = attributedPlaceholder, placeholder.length > 0 else { return }
        let coloredPlaceholder = NSMutableAttributedString(attributedString: placeholder)
        coloredPlaceholder.addAttribute(
            .foregroundColor,
            value: color,
            range: NSRange(location: 0, length: coloredPlaceholder.length)
        )
        attributedPlaceholder = coloredPlaceholder
    }
}
#endif
