//
//  UILabelExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UILabel {
	
	/// Return required height for a label
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
}
