//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Properties
public extension String {
	
	/// SwifterSwift: String decoded from base64  (if applicable).
	public var base64Decoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		guard let decodedData = Data(base64Encoded: self) else {
			return nil
		}
		return String(data: decodedData, encoding: .utf8)
	}
	
	/// SwifterSwift: String encoded in base64 (if applicable).
	public var base64Encoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		let plainData = self.data(using: .utf8)
		return plainData?.base64EncodedString()
	}
	
	/// SwifterSwift: CamelCase of string.
	public var camelCased: String {
		let source = lowercased()
		if source.characters.contains(" ") {
			let first = source.substring(to: source.index(after: source.startIndex))
			let camel = source.capitalized.replacing(" ", with: "").replacing("\n", with: "")
			let rest = String(camel.characters.dropFirst())
			return "\(first)\(rest)"
		} else {
			let first = source.lowercased().substring(to: source.index(after: source.startIndex))
			let rest = String(source.characters.dropFirst())
			return "\(first)\(rest)"
			
		}
	}
	
	/// SwifterSwift: Check if string contains one or more emojis.
	public var containEmoji: Bool {
		// http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
		for scalar in unicodeScalars {
			switch scalar.value {
			case 0x3030, 0x00AE, 0x00A9, // Special Characters
			0x1D000...0x1F77F, // Emoticons
			0x2100...0x27BF, // Misc symbols and Dingbats
			0xFE00...0xFE0F, // Variation Selectors
			0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
				return true
			default:
				continue
			}
		}
		return false
	}
	
	/// SwifterSwift: First character of string (if applicable).
	public var firstCharacter: String? {
		return Array(characters).map({String($0)}).first
	}
	
	/// SwifterSwift: Check if string contains one or more letters.
	public var hasLetters: Bool {
		return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
	}
	
	/// SwifterSwift: Check if string contains one or more numbers.
	public var hasNumbers: Bool {
		return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
	}
	
	/// SwifterSwift: Check if string contains only letters.
	public var isAlphabetic: Bool {
		return  hasLetters && !hasNumbers
	}
	
	/// SwifterSwift: Check if string contains at least one letter and one number.
	public var isAlphaNumeric: Bool {
		return components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").characters.count == 0 && hasLetters && hasNumbers
	}
	
	/// SwifterSwift: Check if string is valid email format.
	public var isEmail: Bool {
		// http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: self)
	}
	
	/// SwifterSwift: Check if string is https URL.
	public var isHttpsUrl: Bool {
		guard start(with: "https://".lowercased()) else {
			return false
		}
		return URL(string: self) != nil
	}
	
	/// SwifterSwift: Check if string is http URL.
	public var isHttpUrl: Bool {
		guard start(with: "http://".lowercased()) else {
			return false
		}
		return URL(string: self) != nil
	}
	
	/// SwifterSwift: Check if string contains only numbers.
	public var isNumeric: Bool {
		return  !hasLetters && hasNumbers
	}
	
	/// SwifterSwift: Last character of string (if applicable).
	public var lastCharacter: String? {
		guard let last = characters.last else {
			return nil
		}
		return String(last)
	}
	
	/// SwifterSwift: Latinized string.
	public var latinized: String {
		return folding(options: .diacriticInsensitive, locale: Locale.current)
	}
	
	/// SwifterSwift: Array of strings separated by new lines.
	public var lines: [String] {
		var result:[String] = []
		enumerateLines { (line, stop) -> () in
			result.append(line)
		}
		return result
	}
	
	/// SwifterSwift: The most common character in string.
	public var mostCommonCharacter: String {
		var mostCommon = ""
		let charSet = Set(withoutSpacesAndNewLines.characters.map{String($0)})
		var count = 0
		for string in charSet {
			if self.count(of: string) > count {
				count = self.count(of: string)
				mostCommon = string
			}
		}
		return mostCommon
	}
	
	/// SwifterSwift: Reversed string.
	public var reversed: String {
		return String(characters.reversed())
	}
	
	/// SwifterSwift: Bool value from string (if applicable).
	public var bool: Bool? {
		let selfLowercased = self.trimmed.lowercased()
		if selfLowercased == "true" || selfLowercased == "1" {
			return true
		} else if selfLowercased == "false" || selfLowercased == "0" {
			return false
		} else {
			return nil
		}
	}
	
	/// SwifterSwift: Date object from "yyyy-MM-dd" formatted string
	public var date: Date? {
		let selfLowercased = self.trimmed.lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: selfLowercased)
	}
	
	/// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
	public var dateTime: Date? {
		let selfLowercased = self.trimmed.lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return formatter.date(from: selfLowercased)
	}
	
	/// SwifterSwift: Double value from string (if applicable).
	public var double: Double? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Double
	}
	
	/// SwifterSwift: Float value from string (if applicable).
	public var float: Float? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Float
	}
	
	/// SwifterSwift: Float32 value from string (if applicable).
	public var float32: Float32? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Float32
	}
	
	/// SwifterSwift: Float64 value from string (if applicable).
	public var float64: Float64? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Float64
	}
	
	/// SwifterSwift: Integer value from string (if applicable).
	public var int: Int? {
		return Int(self)
	}
	
	/// SwifterSwift: Int16 value from string (if applicable).
	public var int16: Int16? {
		return Int16(self)
	}
	
	/// SwifterSwift: Int32 value from string (if applicable).
	public var int32: Int32? {
		return Int32(self)
	}
	
	/// SwifterSwift: Int64 value from string (if applicable).
	public var int64: Int64? {
		return Int64(self)
	}
	
	/// SwifterSwift: Int8 value from string (if applicable).
	public var int8: Int8? {
		return Int8(self)
	}
	
	/// SwifterSwift: URL from string (if applicable).
	public var url: URL? {
		return URL(string: self)
	}
	
	/// SwifterSwift: String with no spaces or new lines in beginning and end.
	public var trimmed: String {
		return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	/// SwifterSwift: Array with unicodes for all characters in a string.
	public var unicodeArray: [Int] {
		return unicodeScalars.map({$0.hashValue})
	}
	
	/// SwifterSwift: Readable string from a URL string.
	public var urlDecoded: String {
		return removingPercentEncoding ?? self
	}
	
	/// SwifterSwift: URL escaped string.
	public var urlEncoded: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
	}
	
	/// SwifterSwift: String without spaces and new lines.
	public var withoutSpacesAndNewLines: String {
		return replacing(" ", with: "").replacing("\n", with: "")
	}
	
}


// MARK: - Methods
public extension String {
	
	/// SwifterSwift: Subscript string with index.
	///
	/// - Parameter i: index.
	public subscript(i: Int) -> String? {
		guard i >= 0 && i < characters.count else {
			return nil
		}
		return String(self[index(startIndex, offsetBy: i)])
	}
	
	/// SwifterSwift: Subscript string within a half-open range.
	///
	/// - Parameter range: Half-open range.
	public subscript(range: CountableRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) else {
			return nil
		}
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
			return nil
		}
		return self[lowerIndex..<upperIndex]
	}
	
	/// SwifterSwift: Subscript string within a closed range.
	///
	/// - Parameter range: Closed range.
	public subscript(range: ClosedRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) else {
			return nil
		}
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else {
			return nil
		}
		return self[lowerIndex..<upperIndex]
	}
	
	/// SwifterSwift: Copy string to global pasteboard.
	func copyToPasteboard() {
		UIPasteboard.general.string = self
	}
	
	/// SwifterSwift: Converts string format to CamelCase.
	public mutating func camelize() {
		self = camelCased
	}
	
	/// SwifterSwift: Check if string contains one or more instance of substring.
	///
	/// - Parameters:
	///   - string: substring to search for.
	///   - caseSensitive: set true for case sensitive search (default is true).
	/// - Returns: true if string contains one or more instance of substring.
	public func contain(_ string: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return range(of: string, options: .caseInsensitive) != nil
		}
		return range(of: string) != nil
	}
	
	/// SwifterSwift: Count of substring in string.
	///
	/// - Parameters:
	///   - string: substring to search for.
	///   - caseSensitive: set true for case sensitive search (default is true).
	/// - Returns:  count of substring in string.
	public func count(of string: String, caseSensitive: Bool = true) -> Int {
		if !caseSensitive {
			return lowercased().components(separatedBy: string).count - 1
		}
		return components(separatedBy: string).count - 1
	}
	
	/// SwifterSwift: Check if string ends with substring.
	///
	/// - Parameters:
	///   - suffix: substring to search if string ends with.
	///   - caseSensitive: set true for case sensitive search (default is true).
	/// - Returns: true if string ends with substring.
	public func end(with suffix: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return lowercased().hasSuffix(suffix.lowercased())
		}
		return hasSuffix(suffix)
	}
	
	/// SwifterSwift: First index of substring in string.
	///
	/// - Parameter string: substring to search for.
	/// - Returns: first index of substring in string (if applicable).
	public func firstIndex(of string: String) -> Int? {
		return Array(self.characters).map({String($0)}).index(of: string)
	}
	
	/// SwifterSwift: Latinize string.
	public mutating func latinize() {
		self = latinized
	}
	
	/// SwifterSwift: Random string of given length.
	///
	/// - Parameter ofLength: number of characters in string.
	/// - Returns: random string of given length.
	public static func random(ofLength: Int) -> String {
		var string = ""
		guard ofLength > 0 else {
			return string
		}
		let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		for _ in 0..<ofLength {
			let randomIndex = arc4random_uniform(UInt32(base.characters.count))
			string += "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
		}
		return string
	}
	
	/// SwifterSwift: String by replacing part of string with another string.
	///
	/// - Parameters:
	///   - substring: old substring to find and replace
	///   - newString: new string to insert in old string place
	/// - Returns: string after replacing substring with newString
	public func replacing(_ substring: String, with newString: String) -> String {
		return replacingOccurrences(of: substring, with: newString)
	}
	
	/// SwifterSwift: Reverse string.
	public mutating func reverse() {
		self = String(characters.reversed())
	}
	
	/// SwifterSwift: Array of strings separated by given string.
	///
	/// - Parameter separator: separator to split string by.
	/// - Returns: array of strings separated by given string.
	public func splited(by separator: Character) -> [String] {
		return characters.split{$0 == separator}.map(String.init)
	}
	
	/// SwifterSwift: Check if string starts with substring.
	///
	/// - Parameters:
	///   - suffix: substring to search if string starts with.
	///   - caseSensitive: set true for case sensitive search (default is true).
	/// - Returns: true if string starts with substring.
	public func start(with prefix: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return lowercased().hasPrefix(prefix.lowercased())
		}
		return hasPrefix(prefix)
	}
	
	/// SwifterSwift: Date object from string of date format.
	///
	/// - Parameter format: date format
	/// - Returns: Date object from string (if applicable).
	public func date(withFormat format: String) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.date(from: self)
	}
	
	/// SwifterSwift: Removes spaces and new lines in beginning and end of string.
	public mutating func trim() {
		self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	/// SwifterSwift: Truncate string (cut it to a given number of characters).
	///
	/// - Parameters:
	///   - toLength: maximum number of charachters before cutting.
	///   - trailing: string to add at the end of truncated string.
	public mutating func truncate(toLength: Int, trailing: String? = "...") {
		guard toLength > 0 else {
			return
		}
		if self.characters.count > toLength {
			self = self.substring(to: self.index(startIndex, offsetBy: toLength)) + (trailing ?? "")
		}
	}
	
	/// SwifterSwift: Truncated string (limited to a given number of characters).
	/// Truncated string (cut to a given number of characters).
	///
	/// - Parameters:
	///   - toLength: maximum number of charachters before cutting.
	///   - trailing: string to add at the end of truncated string.
	/// - Returns: truncated string (this is an exa...).
	public func truncated(toLength: Int, trailing: String? = "...") -> String {
		guard self.characters.count > toLength, toLength > 0 else {
			return self
		}
		return self.substring(to: self.index(startIndex, offsetBy: toLength)) + (trailing ?? "")
	}
	
	/// SwifterSwift: Convert URL string to readable string.
	public mutating func urlDecode() {
		self = removingPercentEncoding ?? self
	}
	
	/// SwifterSwift: Escape string.
	public mutating func urlEncode() {
		self = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
	}
	
}


// MARK: - Operators
public extension String {
	
	/// SwifterSwift: Repeat string multiple times.
	///
	/// - Parameters:
	///   - lhs: string to repeat.
	///   - rhs: number of times to repeat character.
	/// - Returns: string with character repeated n times.
	static public func * (lhs: String, rhs: Int) -> String {
		var newString = ""
		for _ in 0 ..< rhs {
			newString += lhs
		}
		return newString
	}
	
	/// SwifterSwift: Repeat string multiple times.
	///
	/// - Parameters:
	///   - lhs: number of times to repeat character.
	///   - rhs: string to repeat.
	/// - Returns: string with character repeated n times.
	static public func * (lhs: Int, rhs: String) -> String {
		var newString = ""
		for _ in 0 ..< lhs {
			newString += rhs
		}
		return newString
	}
	
}


// MARK: - Initializers
public extension String {
	
	/// SwifterSwift: Create a new string from a base64 string (if applicable).
	///
	/// - Parameter base64: base64 string.
	init?(base64: String) {
		if let str = base64.base64Decoded {
			self.init(str)
			return
		}
		return nil
	}
	
}


// MARK: - NSAttributedString extensions
public extension String {
	
	/// SwifterSwift: Bold string.
	public var bold: NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
	}
	
	/// SwifterSwift: Underlined string
	public var underline: NSAttributedString {
		return NSAttributedString(string: self, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
	}
	
	/// SwifterSwift: Strikethrough string.
	public var strikethrough: NSAttributedString {
		return NSAttributedString(string: self, attributes: [NSStrikethroughStyleAttributeName: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
	}
	
	/// SwifterSwift: Italic string.
	public var italic: NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
	
	/// SwifterSwift: Add color to string.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString versions of string colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
	}
	
}


//MARK: - NSString extensions
public extension String {
	
	/// SwifterSwift: NSString from a string
	public var nsString: NSString {
		return NSString(string: self)
	}
	
	/// SwifterSwift: NSString lastPathComponent
	public var lastPathComponent: String {
		return (self as NSString).lastPathComponent
	}
	
	/// SwifterSwift: NSString pathExtension
	public var pathExtension: String {
		return (self as NSString).pathExtension
	}
	
	/// SwifterSwift: NSString deletingLastPathComponent
	public var deletingLastPathComponent: String {
		return (self as NSString).deletingLastPathComponent
	}
	
	/// SwifterSwift: NSString deletingPathExtension
	public var deletingPathExtension: String {
		return (self as NSString).deletingPathExtension
	}
	
	/// SwifterSwift: NSString pathComponents
	public var pathComponents: [String] {
		return (self as NSString).pathComponents
	}
	
	/// SwifterSwift: NSString appendingPathComponent(str: String)
	public func appendingPathComponent(_ str: String) -> String {
		return (self as NSString).appendingPathComponent(str)
	}
	
	/// SwifterSwift: NSString appendingPathExtension(str: String) (if applicable).
	public func appendingPathExtension(_ str: String) -> String? {
		return (self as NSString).appendingPathExtension(str)
	}
	
}
