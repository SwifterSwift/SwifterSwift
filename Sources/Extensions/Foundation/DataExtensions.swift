//
//  DataExtensions.swift
//  SSTests
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif


// MARK: - Properties
public extension Data {
	
	/// SwifterSwift: NSAttributedString from Data (if applicable).
	public var attributedString: NSAttributedString? {
		// http://stackoverflow.com/questions/39248092/nsattributedstring-extension-in-swift-3
		return try? NSAttributedString(data: self, options: [
			NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
			NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
	}
	
	/// SwifterSwift: Return data as an array of bytes.
	public var bytes: [UInt8] {
		//http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
		return [UInt8](self)
	}
}

// MARK: - Methods
public extension Data {
	
	/// SwifterSwift: String by encoding Data using the given encoding (if applicable).
	///
	/// - Parameter encoding: encoding.
	/// - Returns: String by encoding Data using the given encoding (if applicable).
	public func string(encoding: String.Encoding) -> String? {
		return String(data: self, encoding: encoding)
	}
	
}

