// UITextField+AddToolbar.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

public extension UITextField {
    /// SwifterSwift: Shows a toolbar with the given items above the keyboard while the text field is being edited.
    ///
    /// The toolbar becomes the text field's `inputAccessoryView`, replacing any existing one. It's sized with
    /// `sizeToFit()`, so it gets the standard toolbar height, and the system stretches it to the width of the keyboard.
    /// Customize the returned toolbar if you need a different look. Pass an empty array for an empty toolbar.
    ///
    /// Toolbars and input accessory views aren't available on tvOS and visionOS, so this method isn't either.
    ///
    /// ```swift
    /// let done = UIBarButtonItem(systemItem: .done, primaryAction: UIAction { _ in textField.resignFirstResponder() })
    /// textField.addToolbar(items: [.flexibleSpace(), done])
    /// textField.inputAccessoryView is UIToolbar  // true
    /// ```
    ///
    /// - Parameter items: The items to show in the toolbar, from leading to trailing.
    /// - Returns: The toolbar that was added.
    @discardableResult
    func addToolbar(items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.items = items
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
        return toolbar
    }
}
#endif
