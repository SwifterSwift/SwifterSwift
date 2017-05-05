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
	public func has(key: Key) -> Bool {
		return index(forKey: key) != nil
	}
	
    /// SwifterSwift: Remove all keys of the dictionary.
    ///
    /// - Parameter keys: keys to be removed
    public mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
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
	
    
    
    // MARK: - Operators
    
    /// SwifterSwift: Merge the keys/values of two dictionaries.
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: An dictionary with keys and values from both.
    public static func +(lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach{ result[$0] = $1 }
        return result
    }
    
    // MARK: - Operators
    
    /// SwifterSwift: Append the keys and values from the second dictionary into the first one.
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    public static func +=(lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach({ lhs[$0] = $1})
    }
    
    
    /// SwifterSwift: Remove contained in the array from the dictionary
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    /// - Returns: a new dictionary with keys removed.
    public static func -(lhs: [Key: Value], keys: [Key]) -> [Key: Value]{
        var result = lhs
		result.removeAll(keys: keys)
        return result
    }
    
    /// SwifterSwift: Remove contained in the array from the dictionary
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    public static func -=(lhs: inout [Key: Value], keys: [Key]) {
		lhs.removeAll(keys: keys)
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

