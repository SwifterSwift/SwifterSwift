//
//  DictionaryExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/24/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


// MARK: - Methods
public extension Dictionary {
	
	/// SwifterSwift: Check if key exists in dictionary.
	///
	/// - Parameter key: key to search for
	/// - Returns: true if key exists in dictionary.
	func has(key: Key) -> Bool {
		return index(forKey: key) != nil
	}
	
	/// SwifterSwift: JSON Data from dictionary.
	///
	/// - Parameter prettify: set true to prettify data (default is false).
	/// - Returns: optional JSON Data (if applicable).
	public func jsonData(prettify: Bool = false) -> Data? {
		guard JSONSerialization.isValidJSONObject(self) else {
			return nil
		}
		let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
		return try? JSONSerialization.data(withJSONObject: self, options: options)
	}
	
	/// SwifterSwift: JSON String from dictionary.
	///
	/// - Parameter prettify: set true to prettify string (default is false).
	/// - Returns: optional JSON String (if applicable).
	public func jsonString(prettify: Bool = false) -> String? {
		guard JSONSerialization.isValidJSONObject(self) else {
			return nil
		}
		let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
		let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options)
		return jsonData?.string(encoding: .utf8)
	}
	
}


// MARK: - Methods (ExpressibleByStringLiteral)
public extension Dictionary where Key: ExpressibleByStringLiteral {
	
	/// SwifterSwift: Lowercase all keys in dictionary.
	public mutating func lowercaseAllKeys() {
		// http://stackoverflow.com/questions/33180028/extend-dictionary-where-key-is-of-type-string
		for key in keys {
			if let lowercaseKey = String(describing: key).lowercased() as? Key {
				self[lowercaseKey] = removeValue(forKey: key)
			}
		}
	}
	
}
