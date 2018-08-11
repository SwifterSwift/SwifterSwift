//
//  DictionaryExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/24/16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Methods
public extension Dictionary {

    /// SwifterSwift: Check if key exists in dictionary.
    ///
    ///		let dict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///		dict.has(key: "testKey") -> true
    ///		dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for
    /// - Returns: true if key exists in dictionary.
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    /// SwifterSwift: Remove all keys contained in the keys parameter from the dictionary.
    ///
    ///		var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///		dict.removeAll(keys: ["key1", "key2"])
    ///		dict.keys.contains("key3") -> true
    ///		dict.keys.contains("key1") -> false
    ///		dict.keys.contains("key2") -> false
    ///
    /// - Parameter keys: keys to be removed
    public mutating func removeAll<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { removeValue(forKey: $0) }
    }

    /// SwifterSwift: Remove a value for a random key from the dictionary.
    @discardableResult public mutating func removeValueForRandomKey() -> Value? {
        guard !isEmpty else { return nil }
        let key = Array(keys)[Int(arc4random_uniform(UInt32(keys.count)))]
        return removeValue(forKey: key)
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
    ///		dict.jsonString() -> "{"testKey":"testValue","testArrayKey":[1,2,3,4,5]}"
    ///
    ///		dict.jsonString(prettify: true)
    ///		/*
    ///		returns the following string:
    ///
    ///		"{
    ///		"testKey" : "testValue",
    ///		"testArrayKey" : [
    ///			1,
    ///			2,
    ///			3,
    ///			4,
    ///			5
    ///		]
    ///		}"
    ///
    ///		*/
    ///
    /// - Parameter prettify: set true to prettify string (default is false).
    /// - Returns: optional JSON String (if applicable).
    public func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }

}

// MARK: - Methods (ExpressibleByStringLiteral)
public extension Dictionary where Key: StringProtocol {

    /// SwifterSwift: Lowercase all keys in dictionary.
    ///
    ///        var dict = ["tEstKeY": "value"]
    ///        dict.lowercaseAllKeys()
    ///        print(dict) // prints "["testkey": "value"]"
    ///
    public mutating func lowercaseAllKeys() {
        // http://stackoverflow.com/questions/33180028/extend-dictionary-where-key-is-of-type-string
        for key in keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = removeValue(forKey: key)
            }
        }
    }

}

// MARK: - Operators
public extension Dictionary {

    /// SwifterSwift: Merge the keys/values of two dictionaries.
    ///
    ///		let dict : [String : String] = ["key1" : "value1"]
    ///		let dict2 : [String : String] = ["key2" : "value2"]
    ///		let result = dict + dict2
    ///		result["key1"] -> "value1"
    ///		result["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: An dictionary with keys and values from both.
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }

    // MARK: - Operators

    /// SwifterSwift: Append the keys and values from the second dictionary into the first one.
    ///
    ///		var dict : [String : String] = ["key1" : "value1"]
    ///		let dict2 : [String : String] = ["key2" : "value2"]
    ///		dict += dict2
    ///		dict["key1"] -> "value1"
    ///		dict["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1}
    }

    /// SwifterSwift: Remove keys contained in the sequence from the dictionary
    ///
    ///		let dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///		let result = dict-["key1", "key2"]
    ///		result.keys.contains("key3") -> true
    ///		result.keys.contains("key1") -> false
    ///		result.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    /// - Returns: a new dictionary with keys removed.
    public static func - <S: Sequence>(lhs: [Key: Value], keys: S) -> [Key: Value] where S.Element == Key {
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }

    /// SwifterSwift: Remove keys contained in the sequence from the dictionary
    ///
    ///		var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///		dict-=["key1", "key2"]
    ///		dict.keys.contains("key3") -> true
    ///		dict.keys.contains("key1") -> false
    ///		dict.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    public static func -= <S: Sequence>(lhs: inout [Key: Value], keys: S) where S.Element == Key {
        lhs.removeAll(keys: keys)
    }

}
