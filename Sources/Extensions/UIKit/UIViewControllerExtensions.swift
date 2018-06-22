//
//  UIViewControllerExtensions.swift
//  SwifterSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Properties
public extension UIViewController {

	/// SwifterSwift: Check if ViewController is onscreen and not hidden.
	public var isVisible: Bool {
		// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
		return self.isViewLoaded && view.window != nil
	}

}

// MARK: - Methods
public extension UIViewController {

	/// SwifterSwift: Assign as listener to notification.
	///
	/// - Parameters:
	///   - name: notification name.
	///   - selector: selector to run with notified.
	public func addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}

	/// SwifterSwift: Unassign as listener to notification.
	///
	/// - Parameter name: notification name.
	public func removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}

	/// SwifterSwift: Unassign as listener from all notifications.
	public func removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}

    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    /// SwifterSwift: Replace the "navigationController?.pushViewController" method.
    ///
    /// - Parameters:
    ///   - viewController: viewController.
    ///   - animated: (Optional)The default value of “true”.
    public func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    /// SwifterSwift: Replace the "navigationController?.popViewController" method.
    ///
    /// - Parameters:
    ///   - animated: (Optional)The default value of “true”.
    @discardableResult public func pop(animated: Bool = true) -> UIViewController? {
        return navigationController?.popViewController(animated: animated)
    }
    /// SwifterSwift: Replace the "navigationController?.popToRootViewController" method.
    ///
    /// - Parameters:
    ///   - animated: (Optional)The default value of “true”.
    /// - Returns: [UIViewController]? (discardable).
    @discardableResult public func popToRoot(animated: Bool = true) -> [UIViewController]? {
        return navigationController?.popToRootViewController(animated: animated)
    }
    /// SwifterSwift: Replace the "navigationController?.popToViewController" method.
    ///
    /// - Parameters:
    ///   - viewController: viewController.
    ///   - animated: (Optional)The default value of “true”.
    /// - Returns: [UIViewController]? (discardable).
    @discardableResult public func popToViewController(_ viewController: UIViewController, animated: Bool = true) -> [UIViewController]? {
        return navigationController?.popToViewController(viewController, animated: animated)
    }
    /// SwifterSwift: Replace the "present" method.
    ///
    /// - Parameters:
    ///   - viewControllerToPresent: viewControllerToPresent.
    ///   - completion: (Optional)The default value of “nil”.
    public func present(_ viewControllerToPresent: UIViewController, _ completion: (() -> Swift.Void)? = nil) {
        present(viewControllerToPresent, animated: true, completion: completion)
    }
    /// SwifterSwift: Replace the "present" method.
    ///
    /// - Parameters:
    ///   - viewControllerToPresent: viewControllerToPresent.
    ///   - animated: animated.
    public func present(_ viewControllerToPresent: UIViewController, animated: Bool) {
        present(viewControllerToPresent, animated: animated, completion: nil)
    }
    /// SwifterSwift: Replace the "dismiss" method.
    ///
    /// - Parameters:
    ///   - completion: (Optional)The default value of “nil”.
    public func dismiss(_ completion: (() -> Swift.Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
    /// SwifterSwift: Replace the "dismiss" method.
    ///
    /// - Parameters:
    ///   - animated: animated.
    public func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}
#endif

#endif
