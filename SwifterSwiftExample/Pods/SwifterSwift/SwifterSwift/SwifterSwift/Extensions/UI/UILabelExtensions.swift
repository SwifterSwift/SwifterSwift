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
	
	//	/// Add a strike through text to label
	//	public func setStrikethrough(text:String, color:UIColor = UIColor.black) {
	//		let attributedText = NSAttributedString(string: text , attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSStrikethroughColorAttributeName: color])
	//		self.text = text
	//		self.attributedText = attributedText
	//	}
	//
	//	/// Strike through label's current text
	//	public func strikethroughText(color:UIColor = UIColor.black) {
	//		guard let string = self.text else {
	//			return
	//		}
	//		setStrikethrough(text: string, color: color)
	//	}
	
	//	/// Add a text with charachter spacing to label
	//	public func set(text:String, charactersSpacing: CGFloat) {
	//		let attributedString = NSMutableAttributedString(string: text)
	//		attributedString.addAttribute(NSKernAttributeName, value: charactersSpacing, range: NSMakeRange(0, text.characters.count))
	//		self.text = text
	//		self.attributedText = attributedString
	//	}
	//
	//	/// Add a strike through text to label
	//	public func setCharactersSpacing(of spacing: CGFloat) {
	//		guard let string = self.text else {
	//			return
	//		}
	//		set(text: string, charactersSpacing: spacing)
	//	}
	
	//	/// Set vertical spacing between lines in a label
	//	func setLineHeight(lineHeight: CGFloat) {
	//		if let string = text {
	//			let attributeString = NSMutableAttributedString(string: string)
	//			let style = NSMutableParagraphStyle()
	//			style.lineSpacing = lineHeight
	//			attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, string.characters.count))
	//			self.attributedText = attributeString
	//		}
	//	}
}
