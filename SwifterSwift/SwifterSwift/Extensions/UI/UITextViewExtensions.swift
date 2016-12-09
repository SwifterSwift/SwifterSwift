//
//  UITextViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UITextView {
	
	/// SwifterSwift: Scroll to the bottom of text view
	public func scrollToBottom() {
		let range = NSMakeRange((text as NSString).length - 1, 1)
		scrollRangeToVisible(range)
	}
	
	/// SwifterSwift: Scroll to the top of text view
	public func scrollToTop() {
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}
	
}
