// UIAlertController+AddActionTitle.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIAlertController {
    /// SwifterSwift: Creates an action with the given title, adds it to the alert, and returns it.
    ///
    /// This replaces the usual three steps of creating a `UIAlertAction`, setting its `isEnabled`, and passing it to
    /// `addAction(_:)`. The returned action is the one the alert holds, so you can keep it to enable it later or to
    /// make it the alert's `preferredAction`.
    ///
    /// Actions appear in the order you add them. As with `addAction(_:)`, an alert can have only one action with the
    /// `.cancel` style; UIKit raises an exception when you add a second one.
    ///
    /// ```swift
    /// let alert = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
    /// alert.addAction(title: "Cancel", style: .cancel)
    /// let save = alert.addAction(title: "Save", isEnabled: false) { _ in saveChanges() }
    /// alert.preferredAction = save
    /// alert.actions.count  // 2
    /// save.isEnabled  // false
    /// ```
    ///
    /// - Parameters:
    ///   - title: The text of the action's button.
    ///   - style: The style of the action. The default is `.default`.
    ///   - isEnabled: Whether the action starts out enabled. The default is `true`.
    ///   - handler: The closure to run when the user selects the action, or `nil` to only dismiss the alert.
    /// - Returns: The action that was added to the alert.
    @discardableResult
    func addAction(
        title: String,
        style: UIAlertAction.Style = .default,
        isEnabled: Bool = true,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }
}
#endif
