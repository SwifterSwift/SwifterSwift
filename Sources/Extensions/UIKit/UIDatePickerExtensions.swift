//
//  UIDatePickerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 12/9/17.
//  Copyright © 2017 SwifterSwift
//

#if os(iOS)
import UIKit

// MARK: - Properties
public extension UIDatePicker {
	
	/// SwifterSwift: Text color of UIDatePicker.
	public var textColor: UIColor? {
		set {
			setValue(newValue, forKeyPath: "textColor")
		}
		get {
			return value(forKeyPath: "textColor") as? UIColor
		}
	}
	
}
#endif
