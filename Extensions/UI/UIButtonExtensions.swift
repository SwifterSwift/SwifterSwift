//
//  UIButtonExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIButton {
	/// Set image for all states.
	public func setImageForAllStates(_ image: UIImage) {
		setImage(image, for: .normal)
		setImage(image, for: .selected)
		setImage(image, for: .highlighted)
		setImage(image, for: .disabled)
	}
	
	/// Image of disabled state for button; also inspectable from Storyboard.
	@IBInspectable
	public var imageForDisabled: UIImage? {
		get {
			return image(for: .disabled)
		}
		set {
			setImage(newValue, for: .disabled)
		}
	}
	
	/// Image of highlighted state for button; also inspectable from Storyboard.
	@IBInspectable
	public var imageForHighlighted: UIImage? {
		get {
			return image(for: .highlighted)
		}
		set {
			setImage(newValue, for: .highlighted)
		}
	}
	
	/// Image of normal state for button; also inspectable from Storyboard.
	@IBInspectable
	public var imageForNormal: UIImage? {
		get {
			return image(for: .normal)
		}
		set {
			setImage(newValue, for: .normal)
		}
	}
	
	/// Image of selected state for button; also inspectable from Storyboard.
	@IBInspectable
	public var imageForSelected: UIImage? {
		get {
			return image(for: .selected)
		}
		set {
			setImage(newValue, for: .selected)
		}
	}
	
	/// Set title color for all states.
	public func setTitleColorForAllStates(_ color: UIColor) {
		setTitleColor(color, for: .normal)
		setTitleColor(color, for: .selected)
		setTitleColor(color, for: .highlighted)
		setTitleColor(color, for: .disabled)
	}
	
	/// Title color of disabled state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleColorForDisabled: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}
	
	/// Title color of highlighted state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleColorForHighlighted: UIColor? {
		get {
			return titleColor(for: .highlighted)
		}
		set {
			setTitleColor(newValue, for: .highlighted)
		}
	}
	
	/// Title color of normal state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleColorForNormal: UIColor? {
		get {
			return titleColor(for: .normal)
		}
		set {
			setTitleColor(newValue, for: .normal)
		}
	}
	
	/// Title color of selected state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleColorForSelected: UIColor? {
		get {
			return titleColor(for: .selected)
		}
		set {
			setTitleColor(newValue, for: .selected)
		}
	}
	
	/// Set title for all states.
	public func setTitleForAllStates(_ title: String) {
		setTitle(title, for: .normal)
		setTitle(title, for: .selected)
		setTitle(title, for: .highlighted)
		setTitle(title, for: .disabled)
	}
	
	/// Title of disabled state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleForDisabled: String? {
		get {
			return title(for: .disabled)
		}
		set {
			setTitle(newValue, for: .disabled)
		}
	}
	
	/// Title of highlighted state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleForHighlighted: String? {
		get {
			return title(for: .highlighted)
		}
		set {
			setTitle(newValue, for: .highlighted)
		}
	}
	
	/// Title of normal state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleForNormal: String? {
		get {
			return title(for: .normal)
		}
		set {
			setTitle(newValue, for: .normal)
		}
	}
	
	/// Title of selected state for button; also inspectable from Storyboard.
	@IBInspectable
	public var titleForSelected: String? {
		get {
			return title(for: .selected)
		}
		set {
			setTitle(newValue, for: .selected)
		}
	}
}
