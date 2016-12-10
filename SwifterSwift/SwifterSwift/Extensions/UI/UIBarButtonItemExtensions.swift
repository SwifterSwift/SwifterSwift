//
//  UIBarButtonItemExtensions.swift
//  SSTests
//
//  Created by Omar Albeik on 08/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UIBarButtonItem {

	/// SwifterSwift: Add Target to UIBarButtonItem
	///
	/// - Parameters:
	///   - target: target.
	///   - action: selector to run when button is tapped.
	public func addTargetForAction(target: AnyObject, action: Selector) {
		self.target = target
		self.action = action
	}

}
