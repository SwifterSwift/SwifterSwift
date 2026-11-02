// UIViewController+ShowAlert.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIViewController {
    /// SwifterSwift: Presents an alert with the given buttons and reports which one the user tapped.
    ///
    /// The alert uses the `.alert` style, and all its buttons use the `.default` style, in the order of
    /// `buttonTitles`. The completion receives the index of the tapped button in `buttonTitles`, which stays reliable
    /// even when two buttons share a title. With no button titles, the alert shows a single
    /// `String(localized: "OK")` button, looked up in the `Localizable` table of your app's main bundle, so it's
    /// translated when your app provides a translation and reads "OK" otherwise.
    ///
    /// The alert is presented from this view controller, with animation. As with any presentation, UIKit doesn't
    /// present it when this view controller isn't in a window or is already presenting another view controller. An
    /// out-of-range `highlightedButtonIndex` is ignored.
    ///
    /// ```swift
    /// showAlert(
    ///     title: "Delete photo?",
    ///     message: "This can't be undone.",
    ///     buttonTitles: ["Cancel", "Delete"],
    ///     highlightedButtonIndex: 1
    /// ) { index in
    ///     if index == 1 { deletePhoto() }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - title: The title of the alert, or `nil`.
    ///   - message: The message of the alert, or `nil`.
    ///   - buttonTitles: The titles of the alert's buttons, in order. The default is no titles, which shows one
    ///     localized "OK" button.
    ///   - highlightedButtonIndex: The index of the button to make the alert's `preferredAction`, or `nil` for none.
    ///   - completion: The closure to call with the index of the tapped button, or `nil`.
    /// - Returns: The alert that was presented.
    @discardableResult
    func showAlert(
        title: String?,
        message: String?,
        buttonTitles: [String] = [],
        highlightedButtonIndex: Int? = nil,
        completion: ((Int) -> Void)? = nil
    ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let titles = buttonTitles.isEmpty ? [String(localized: "OK")] : buttonTitles
        for (index, buttonTitle) in titles.enumerated() {
            let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
                completion?(index)
            }
            alertController.addAction(action)
            if index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true)
        return alertController
    }
}
#endif
