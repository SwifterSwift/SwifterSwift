// UIAlertController+InitTitleMessage.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIAlertController {
    /// SwifterSwift: Creates an alert with a title, an optional message, and a single button that dismisses it.
    ///
    /// The alert uses the `.alert` style, and its one action uses the `.default` style with no handler, so tapping it
    /// only dismisses the alert. Add more actions with `addAction(_:)` if you need them.
    ///
    /// The default button title is `String(localized: "OK")`. It's looked up in the `Localizable` table of your app's
    /// main bundle, so it's translated when your app provides a translation for "OK", and reads "OK" otherwise. Pass
    /// your own title to control the text and its localization.
    ///
    /// ```swift
    /// let alert = UIAlertController(title: "Saved", message: "Your changes were saved.")
    /// alert.actions.map(\.title)  // ["OK"]
    /// present(alert, animated: true)
    /// ```
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert, or `nil` for no message.
    ///   - defaultActionButtonTitle: The title of the button that dismisses the alert.
    ///   - tintColor: The tint color of the alert's view, or `nil` to keep the system tint.
    convenience init(
        title: String,
        message: String? = nil,
        defaultActionButtonTitle: String = String(localized: "OK"),
        tintColor: UIColor? = nil
    ) {
        self.init(title: title, message: message, preferredStyle: .alert)
        addAction(UIAlertAction(title: defaultActionButtonTitle, style: .default))
        if let tintColor {
            view.tintColor = tintColor
        }
    }
}
#endif
