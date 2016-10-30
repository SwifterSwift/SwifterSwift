//
//  UINavigationBarExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UINavigationBar {
	
	/// Set Navigation Bar title, title color and font.
	public func setTitleFont(font: UIFont, with color: UIColor = UIColor.black) {
		var attrs = [String: AnyObject]()
		attrs[NSFontAttributeName] = font
		attrs[NSForegroundColorAttributeName] = color
		titleTextAttributes = attrs
	}
	
	/// Make navigation bar transparent
	func makeTransparent(withTint: UIColor = .white) {
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
		isTranslucent = true
		tintColor = withTint
		titleTextAttributes = [NSForegroundColorAttributeName: withTint]
	}
	
	/// Set navigationBar background and text colors
	func setColors(background: UIColor, text: UIColor) {
		self.isTranslucent = false
		self.backgroundColor = background
		self.barTintColor = background
		self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.tintColor = text
		self.titleTextAttributes = [NSForegroundColorAttributeName: text]
	}
}
