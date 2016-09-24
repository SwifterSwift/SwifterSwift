//
//  UINavigationControllerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UINavigationController {
	/// Pop ViewController with completion handler.
	public func popViewController(completion: (()->Void)? = nil) {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popViewController(animated: true)
		CATransaction.commit()
	}
	
	/// Push ViewController with completion handler.
	public func pushViewController(viewController: UIViewController, completion: (()->Void)? = nil)  {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: true)
		CATransaction.commit()
	}
	
	/// Make navigation controller's navigation bar transparent
	func makeTransparent(withTint: UIColor = .white) {
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = true
		navigationBar.tintColor = withTint
		navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: withTint]
	}
	
}
