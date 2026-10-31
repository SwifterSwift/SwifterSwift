// UIAlertController+InitTitleError.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIAlertController {
    /// SwifterSwift: Creates an alert that shows an error's description, with a single button that dismisses it.
    ///
    /// The alert's message is the error's `localizedDescription`, so conform your errors to `LocalizedError` to show
    /// a meaningful message. The alert always uses the `.alert` style: unlike an action sheet, it needs no popover
    /// anchor, so it's safe to present on iPad.
    ///
    /// The default title and button title are `String(localized: "Error")` and `String(localized: "OK")`. They're
    /// looked up in the `Localizable` table of your app's main bundle, so they're translated when your app provides
    /// translations, and stay in English otherwise. Pass your own titles to control the text and its localization.
    ///
    /// ```swift
    /// do {
    ///     try document.save()
    /// } catch {
    ///     let alert = UIAlertController(error: error)
    ///     alert.title  // "Error"
    ///     alert.message  // error.localizedDescription
    ///     present(alert, animated: true)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - error: The error whose `localizedDescription` becomes the alert's message.
    ///   - defaultActionButtonTitle: The title of the button that dismisses the alert.
    ///   - tintColor: The tint color of the alert's view, or `nil` to keep the system tint.
    convenience init(
        title: String = String(localized: "Error"),
        error: any Error,
        defaultActionButtonTitle: String = String(localized: "OK"),
        tintColor: UIColor? = nil
    ) {
        self.init(title: title, message: error.localizedDescription, preferredStyle: .alert)
        addAction(UIAlertAction(title: defaultActionButtonTitle, style: .default))
        if let tintColor {
            view.tintColor = tintColor
        }
    }
}
#endif
