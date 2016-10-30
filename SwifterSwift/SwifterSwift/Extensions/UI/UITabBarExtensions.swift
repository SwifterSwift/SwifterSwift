//
//  UITabBarExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UITabBar {
	// Set tabBar colors
	public func setColors(background: UIColor? = nil,
	               selectedBackground: UIColor? = nil,
	               item: UIColor? = nil,
	               selectedItem: UIColor? = nil) {
		
		// background
		self.barTintColor = background ?? self.barTintColor
		
		// selectedItem
		self.tintColor = selectedItem ?? self.tintColor
		//		self.shadowImage = UIImage()
		self.backgroundImage = UIImage()
		self.isTranslucent = false
		
		// selectedBackgoundColor
		
		if let selectedbg = selectedBackground {
			let rect = CGSize(width: self.frame.width/CGFloat(self.items!.count), height: self.frame.height)
			self.selectionIndicatorImage = UIImage(color: selectedbg, size: rect)
		}
		
		if let itemColor = item {
			for barItem in self.items! as [UITabBarItem] {
				// item
				if let image = barItem.image {
					barItem.image = image.filled(withColor: itemColor).withRenderingMode(.alwaysOriginal)
					barItem.setTitleTextAttributes([NSForegroundColorAttributeName : itemColor], for: .normal)
					barItem.setTitleTextAttributes([NSForegroundColorAttributeName : itemColor], for: .selected)
				}
			}
		}
	}
}
