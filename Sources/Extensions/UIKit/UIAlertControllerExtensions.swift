//
//  UIAlertControllerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)
import UIKit

#if canImport(AudioToolbox)
import AudioToolbox
#endif

#if !os(watchOS)
// MARK: - Methodss
public extension UIAlertController {

  // swiftlint:disable next cyclomatic_complexity
  /// SwifterSwift: Present alert view controller.
  ///
  /// - Parameters:
  ///   - viewController: a custom view controller to be presented (default is the rootViewController of application's key window).
  ///   - anchor: specify the anchor for the popover’s arrow points to (default is nil).
  ///   - arrowDirection: specify the permitted arrow directions for the popover (default is UIPopoverArrowDirection.any).
  ///   - animated: set true to animate presentation of alert controller (default is true).
  ///   - vibrate: set true to vibrate the device while presenting the alert (default is false).
  ///   - completion: an optional completion handler to be called after presenting alert controller (default is nil).
  public func show(in viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController, anchor: AnyObject? = nil, arrowDirection: UIPopoverArrowDirection = .any, animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil) {
    // https://github.com/steipete/PSTAlertController/blob/master/PSTAlertController/PSTAlertController.m#L278
    // We absolutely need a controller going forward.
    guard var viewController = viewController else {
      assertionFailure("Can't show alert because there is no root view controller.")
      return
    }

    // Use the frontmost viewController for presentation.
    while let frontViewController = viewController.presentedViewController, !frontViewController.isBeingDismissed {
      viewController = frontViewController
    }

    // If it has already been set, we should not overwrite it. Will do nothing on iPhone since the popover is nil.
    if let popover = popoverPresentationController, popover.sourceView == nil, popover.barButtonItem == nil {
      switch anchor {
      case let value as UIBarButtonItem:
        popover.barButtonItem = value
      case let value as UIView:
        popover.sourceView = value
        popover.sourceRect = value.bounds
      case let value as NSValue:
        popover.sourceView = viewController.view
        popover.sourceRect = value.cgRectValue
      default:
        popover.sourceView = viewController.view
        popover.sourceRect = viewController.view.bounds
      }

      // Workaround for rdar://18921595. Unsatisfiable constraints when presenting UIAlertController.
      // If the rect is too large, the action sheet can't be displayed.
      let sourceRect: CGRect = popover.sourceRect
      let screen: CGRect = UIScreen.main.bounds
      if sourceRect.height > screen.height * 0.5 || sourceRect.width > screen.width * 0.5 {
        popover.sourceRect = CGRect(x: sourceRect.origin.x + sourceRect.width / 2.0, y: sourceRect.origin.y + sourceRect.height / 2.0, width: 1.0, height: 1.0)
      }

      // Optimize arrow positioning for up and down.
      popover.permittedArrowDirections = arrowDirection
      switch arrowDirection {
      case .down:
        popover.sourceRect = CGRect(x: sourceRect.origin.x + sourceRect.size.width / 2.0, y: sourceRect.origin.y, width: 1.0, height: 1.0)
      case .up:
        popover.sourceRect = CGRect(x: sourceRect.origin.x + sourceRect.size.width / 2.0, y: sourceRect.origin.y + sourceRect.size.height, width: 1.0, height: 1.0)
      // Left and right is too buggy.
      default:
        break
      }
    }

    viewController.present(self, animated: animated, completion: completion)

    if vibrate {
      #if canImport(AudioToolbox)
      AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
      #endif
    }
  }

	/// SwifterSwift: Add an action to Alert
	///
	/// - Parameters:
	///   - title: action title
	///   - style: action style (default is UIAlertActionStyle.default)
	///   - isEnabled: isEnabled status for action (default is true)
	///   - handler: optional action handler to be called when button is tapped (default is nil)
	/// - Returns: action created by this method
	@discardableResult public func addAction(title: String, style: UIAlertActionStyle = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
		let action = UIAlertAction(title: title, style: style, handler: handler)
		action.isEnabled = isEnabled
		addAction(action)
		return action
	}

	/// SwifterSwift: Add a text field to Alert
	///
	/// - Parameters:
	///   - text: text field text (default is nil)
	///   - placeholder: text field placeholder text (default is nil)
	///   - editingChangedTarget: an optional target for text field's editingChanged
	///   - editingChangedSelector: an optional selector for text field's editingChanged
	public func addTextField(text: String? = nil, placeholder: String? = nil, editingChangedTarget: Any?, editingChangedSelector: Selector?) {
		addTextField { textField in
			textField.text = text
			textField.placeholder = placeholder
			if let target = editingChangedTarget, let selector = editingChangedSelector {
				textField.addTarget(target, action: selector, for: .editingChanged)
			}
		}
	}

}

// MARK: - Initializers
public extension UIAlertController {

	/// SwifterSwift: Create new alert view controller with default OK action.
	///
	/// - Parameters:
	///   - title: alert controller's title.
	///   - message: alert controller's message (default is nil).
	///   - defaultActionButtonTitle: default action button title (default is "OK")
	///   - tintColor: alert controller's tint color (default is nil)
	public convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
		self.init(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
		addAction(defaultAction)
		if let color = tintColor {
			view.tintColor = color
		}
	}

	/// SwifterSwift: Create new error alert view controller from Error with default OK action.
	///
	/// - Parameters:
	///   - title: alert controller's title (default is "Error").
	///   - error: error to set alert controller's message to it's localizedDescription.
	///   - defaultActionButtonTitle: default action button title (default is "OK")
	///   - tintColor: alert controller's tint color (default is nil)
	public convenience init(title: String = "Error", error: Error, defaultActionButtonTitle: String = "OK", preferredStyle: UIAlertControllerStyle = .alert, tintColor: UIColor? = nil) {
		self.init(title: title, message: error.localizedDescription, preferredStyle: preferredStyle)
		let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
		addAction(defaultAction)
		if let color = tintColor {
			view.tintColor = color
		}
	}

}
#endif

#endif
