//
//  UISliderExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UISlider {
	
	// Set slide bar value with completion handler
	public func setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.setValue(value, animated: true)
				}, completion: { finished in
					completion?()
			})
		} else {
			setValue(value, animated: false)
			completion?()
		}
	}
}
