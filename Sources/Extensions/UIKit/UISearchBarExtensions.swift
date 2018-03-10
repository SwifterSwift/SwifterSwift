//
//  UISearchBarExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - Properties
public extension UISearchBar {
	
	/// SwifterSwift: Text field inside search bar (if applicable).
	public var textField: UITextField? {
		let subViews = subviews.flatMap { $0.subviews }
		guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
			return nil
		}
		return textField
	}
	
	/// SwifterSwift: Text with no spaces or new lines in beginning and end (if applicable).
	public var trimmedText: String? {
		return text?.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
}

// MARK: - Methods
public extension UISearchBar {
	
	/// SwifterSwift: Clear text.
	public func clear() {
		text = ""
	}
	
}
#endif
