//
//  UITabBarExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - Methods
public extension UITabBar {
	
	/// SwifterSwift: Set tabBar colors.
	///
	/// - Parameters:
	///   - background: background color.
	///   - selectedBackground: background color for selected tab.
	///   - item: icon tint color for items.
	///   - selectedItem: icon tint color for item.
	public func setColors(background: UIColor? = nil,
	                      selectedBackground: UIColor? = nil,
	                      item: UIColor? = nil,
	                      selectedItem: UIColor? = nil) {
		
		// background
		barTintColor = background ?? barTintColor
		
		// selectedItem
		tintColor = selectedItem ?? tintColor
		// shadowImage = UIImage()
		backgroundImage = UIImage()
		isTranslucent = false
		
		// selectedBackgoundColor
		
		if let selectedbg = selectedBackground {
			let rect = CGSize(width: frame.width/CGFloat(items!.count), height: frame.height)
			selectionIndicatorImage = UIImage(color: selectedbg, size: rect)
		}
		
		if let itemColor = item {
			for barItem in items! as [UITabBarItem] {
				// item
				if let image = barItem.image {
					barItem.image = image.filled(withColor: itemColor).withRenderingMode(.alwaysOriginal)
					barItem.setTitleTextAttributes([NSForegroundColorAttributeName : itemColor], for: .normal)
					if let selected = selectedItem {
						barItem.setTitleTextAttributes([NSForegroundColorAttributeName : selected], for: .selected)
					}
				}
			}
		}
	}
}
#endif
