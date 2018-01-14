//
//  UILabelExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/23/16.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - Methods
public extension UILabel {
	
	/// SwifterSwift: Initialize a UILabel with text
	public convenience init(text: String?) {
		self.init()
		self.text = text
	}
	
	/// SwifterSwift: Required height for a label
	public var requiredHeight: CGFloat {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = text
		label.attributedText = attributedText
		label.sizeToFit()
		return label.frame.height
	}
    
    /// SwifterSwift: Add limit to number of character in UILabel text
    /// replace characters after limit to '...'
    func addLimit(charracters: Int) {
        if let count = text?.count, count >= charracters, let startIndex = text?.startIndex,
            let index = text?.index(startIndex, offsetBy: charracters) {
            let textAfterAddingLimit = text?[...index]
            text = String.init(textAfterAddingLimit!)
            text = text?.appending("...")
        }
    }
    
    /// SwifterSwift: Add limit to number of character in UILabel text
    /// without replacing characters after limit to '...'
    func justAddLimit(charracters: Int) {
        if let count = text?.count, count >= charracters, let startIndex = text?.startIndex,
            let index = text?.index(startIndex, offsetBy: charracters) {
            let textAfterAddingLimit = text?[...index]
            text = String.init(textAfterAddingLimit!)
        }
    }
	
}
#endif
