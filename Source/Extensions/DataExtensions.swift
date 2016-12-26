//
//  DataExtensions.swift
//  SSTests
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension Data {

	/// SwifterSwift: NSAttributedString from Data (if applicable).
	var attributedString: NSAttributedString? {
		// http://stackoverflow.com/questions/39248092/nsattributedstring-extension-in-swift-3
		do {
			return try NSAttributedString(data: self, options: [
				NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
				NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
		} catch _ {
			return nil
		}
	}

}
