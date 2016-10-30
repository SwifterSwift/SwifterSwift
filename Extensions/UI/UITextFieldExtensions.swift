//
//  UITextFieldExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit
public extension UITextField {
	
	/// Return true if text field is empty.
	public var isEmpty: Bool {
		if let text = self.text {
			return text.characters.isEmpty
		}
		return true
	}
	
	/// Return text with no spaces or new lines in beginning and end.
	var trimmedText: String? {
		return text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	/// Set place holder text color
	public func setPlaceHolderTextColor(_ color: UIColor) {
		self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
	}
	
	/// Left view tint color
	@IBInspectable
	var leftViewTintColor: UIColor? {
		get {
			guard let iconView = self.leftView as? UIImageView else {
				return nil
			}
			return iconView.tintColor
		}
		set {
			guard let iconView = self.leftView as? UIImageView else {
				return
			}
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}
	
	/// Right view tint color
	@IBInspectable
	var rightViewTintColor: UIColor? {
		get {
			guard let iconView = self.rightView as? UIImageView else {
				return nil
			}
			return iconView.tintColor
		}
		set {
			guard let iconView = self.rightView as? UIImageView else {
				return
			}
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}
}
