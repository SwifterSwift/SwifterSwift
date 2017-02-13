//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif

// MARK: - Properties
public extension String {
	
	/// SwifterSwift: String decoded from base64 (if applicable).
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
		let plainData = data(using: .utf8)
		return plainData?.base64EncodedString()
	}
	
	/// SwifterSwift: CamelCase of string.
	public var camelCased: String {
		let source = lowercased()
		if source.characters.contains(" ") {
			let first = source.substring(to: source.index(after: source.startIndex))
			let camel = source.capitalized.replacing(" ", with: "").replacing("\n", with: "")
			let rest = String(camel.characters.dropFirst())
			return first + rest
		}
		
		let first = source.lowercased().substring(to: source.index(after: source.startIndex))
		let rest = String(source.characters.dropFirst())
		return first + rest
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
	
	/// SwifterSwift: Check if string is a valid URL.
	public var isValidUrl: Bool {
		return URL(string: self) != nil
	}
	
	/// SwifterSwift: Check if string is a valid schemed URL.
	public var isValidSchemedUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme != nil
	}
	
	/// SwifterSwift: Check if string is a valid https URL.
	public var isValidHttpsUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme == "https"
	}
	
	/// SwifterSwift: Check if string is a valid http URL.
	public var isValidHttpUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme == "http"
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
	
	/// SwifterSwift: Number of characters in string.
	public var length: Int {
		return characters.count
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
		var mostCommonCount = 0
		for string in charSet {
			if count(of: string) > mostCommonCount {
				mostCommonCount = count(of: string)
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
		let selfLowercased = trimmed.lowercased()
		if selfLowercased == "true" || selfLowercased == "1" {
			return true
		} else if selfLowercased == "false" || selfLowercased == "0" {
			return false
		}
		return nil
	}
	
	/// SwifterSwift: Date object from "yyyy-MM-dd" formatted string
	public var date: Date? {
		let selfLowercased = trimmed.lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: selfLowercased)
	}
	
	/// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
	public var dateTime: Date? {
		let selfLowercased = trimmed.lowercased()
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
		return trimmingCharacters(in: .whitespacesAndNewlines)
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
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}
	
	/// SwifterSwift: String without spaces and new lines.
	public var withoutSpacesAndNewLines: String {
		return replacing(" ", with: "").replacing("\n", with: "")
	}
	
}


// MARK: - Methods
public extension String {
	
	/// SwifterSwift: Safely subscript string with index.
	///
	/// - Parameter i: index.
	public subscript(i: Int) -> String? {
		guard i >= 0 && i < characters.count else {
			return nil
		}
		return String(self[index(startIndex, offsetBy: i)])
	}
	
	/// SwifterSwift: Safely subscript string within a half-open range.
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
	
	/// SwifterSwift: Safely subscript string within a closed range.
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
	
	#if os(iOS) || os(macOS)
	/// SwifterSwift: Copy string to global pasteboard.
	func copyToPasteboard() {
		#if os(iOS)
			UIPasteboard.general.string = self
		#elseif os(macOS)
			NSPasteboard.general().clearContents()
			NSPasteboard.general().setString(self, forType: NSPasteboardTypeString)
		#endif
	}
	#endif
	
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
	/// - Returns: count of appearance of substring in string.
	public func count(of string: String, caseSensitive: Bool = true) -> Int {
		if !caseSensitive {
			return lowercased().components(separatedBy: string.lowercased()).count - 1
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
		return Array(characters).map({String($0)}).index(of: string)
	}
	
	/// SwifterSwift: Latinize string.
	public mutating func latinize() {
		self = latinized
	}
	
	/// SwifterSwift: Random string of given length.
	///
	/// - Parameter length: number of characters in string.
	/// - Returns: random string of given length.
	public static func random(ofLength length: Int) -> String {
		guard length > 0 else { return "" }
		let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		return (0..<length).reduce("") {
			let randomIndex = arc4random_uniform(UInt32(base.characters.count))
			let randomCharacter = "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
			return $0.0 + randomCharacter
		}
	}
	
	/// SwifterSwift: String by replacing part of string with another string.
	///
	/// - Parameters:
	///   - substring: old substring to find and replace.
	///   - newString: new string to insert in old string place.
	/// - Returns: string after replacing substring with newString.
	public func replacing(_ substring: String, with newString: String) -> String {
		return replacingOccurrences(of: substring, with: newString)
	}
	
	/// SwifterSwift: Reverse string.
	public mutating func reverse() {
		self = String(characters.reversed())
	}
	
	/// SwifterSwift: Sliced string from a start index with length.
	///
	/// - Parameters:
	///   - i: string index the slicing should start from.
	///   - length: amount of characters to be sliced after given index.
	/// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World")
	public func slicing(from i: Int, length: Int) -> String? {
		guard length >= 0, i >= 0, i < characters.count  else {
			return nil
		}
		guard i.advanced(by: length) <= characters.count else {
			return slicing(at: i)
		}
		guard length > 0 else {
			return ""
		}
		return self[i..<i.advanced(by: length)]
	}
	
	/// SwifterSwift: Slice given string from a start index with length (if applicable).
	///
	/// - Parameters:
	///   - i: string index the slicing should start from.
	///   - length: amount of characters to be sliced after given index.
	public mutating func slice(from i: Int, length: Int) {
		if let str = slicing(from: i, length: length) {
			self = str
		}
	}
	
	/// SwifterSwift: Sliced string from a start index to an end index.
	///
	/// - Parameters:
	///   - start: string index the slicing should start from.
	///   - end: string index the slicing should end at.
	/// - Returns: sliced substring starting from start index, and ends at end index (if applicable) (example: "Hello World".slicing(from: 6, to: 11) -> "World")
	public func slicing(from start: Int, to end: Int) -> String? {
		guard end >= start else {
			return nil
		}
		return self[start..<end]
	}
	
	/// SwifterSwift: Slice given string from a start index to an end index (if applicable).
	///
	/// - Parameters:
	///   - start: string index the slicing should start from.
	///   - end: string index the slicing should end at.
	public mutating func slice(from start: Int, to end: Int) {
		if let str = slicing(from: start, to: end) {
			self = str
		}
	}
	
	/// SwifterSwift: Sliced string from a start index.
	///
	/// - Parameter i: string index the slicing should start from.
	/// - Returns: sliced substring starting from start index (if applicable) (example: "Hello world".slicing(at: 6) -> "world")
	public func slicing(at i: Int) -> String? {
		guard i < characters.count else {
			return nil
		}
		return self[i..<characters.count]
	}
	
	/// SwifterSwift: Slice given string from a start index (if applicable).
	///
	/// - Parameter i: string index the slicing should start from.
	public mutating func slice(at i: Int) {
		if let str = slicing(at: i) {
			self = str
		}
	}
	
	/// SwifterSwift: Array of strings separated by given string.
	///
	/// - Parameter separator: separator to split string by.
	/// - Returns: array of strings separated by given string.
	public func splitted(by separator: Character) -> [String] {
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
	/// - Parameter format: date format.
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
	///   - toLength: maximum number of characters before cutting.
	///   - trailing: string to add at the end of truncated string (default is "...").
	public mutating func truncate(toLength: Int, trailing: String? = "...") {
		guard toLength > 0 else {
			return
		}
		if characters.count > toLength {
			self = substring(to: index(startIndex, offsetBy: toLength)) + (trailing ?? "")
		}
	}
	
	/// SwifterSwift: Truncated string (limited to a given number of characters).
	///
	/// - Parameters:
	///   - toLength: maximum number of characters before cutting.
	///   - trailing: string to add at the end of truncated string.
	/// - Returns: truncated string (this is an extr...).
	public func truncated(toLength: Int, trailing: String? = "...") -> String {
		guard 1..<characters.count ~= toLength else { return self }
		return substring(to: index(startIndex, offsetBy: toLength)) + (trailing ?? "")
	}
	
	/// SwifterSwift: Convert URL string to readable string.
	public mutating func urlDecode() {
		if let decoded = removingPercentEncoding {
			self = decoded
		}
	}
	
	/// SwifterSwift: Escape string.
	public mutating func urlEncode() {
		if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
			self = encoded
		}
	}
	
}


// MARK: - Operators
public extension String {
	
	/// SwifterSwift: Repeat string multiple times.
	///
	/// - Parameters:
	///   - lhs: string to repeat.
	///   - rhs: number of times to repeat character.
	/// - Returns: new string with given string repeated n times.
	static public func * (lhs: String, rhs: Int) -> String {
		guard rhs > 0 else {
			return ""
		}
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
	/// - Returns: new string with given string repeated n times.
	static public func * (lhs: Int, rhs: String) -> String {
		guard lhs > 0 else {
			return ""
		}
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
	public init?(base64: String) {
		if let str = base64.base64Decoded {
			self.init(str)
			return
		}
		return nil
	}
	
	/// SwifterSwift: Create a new random string of given length.
	///
	/// - Parameter length: number of characters in string.
	public init(randomOfLength length: Int) {
		self = String.random(ofLength: length)
	}
	
}


// MARK: - NSAttributedString extensions
public extension String {
	
	#if !os(tvOS) && !os(watchOS)
	/// SwifterSwift: Bold string.
	public var bold: NSAttributedString {
		#if os(macOS)
			return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize())])
		#else
			return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
		#endif
	}
	#endif
	
	/// SwifterSwift: Underlined string
	public var underline: NSAttributedString {
		return NSAttributedString(string: self, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
	}
	
	/// SwifterSwift: Strikethrough string.
	public var strikethrough: NSAttributedString {
		return NSAttributedString(string: self, attributes: [NSStrikethroughStyleAttributeName: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
	}
	
	#if os(iOS)
	/// SwifterSwift: Italic string.
	public var italic: NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [NSFontAttributeName: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif
	
	#if os(macOS)
	/// SwifterSwift: Add color to string.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString versions of string colored with given color.
	public func colored(with color: NSColor) -> NSAttributedString {
	return NSMutableAttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
	}
	#else
	/// SwifterSwift: Add color to string.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString versions of string colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
	}
	#endif
	
}


//MARK: - NSString extensions
public extension String {
	
	/// SwifterSwift: NSString from a string.
	public var nsString: NSString {
		return NSString(string: self)
	}
	
	/// SwifterSwift: NSString lastPathComponent.
	public var lastPathComponent: String {
		return (self as NSString).lastPathComponent
	}
	
	/// SwifterSwift: NSString pathExtension.
	public var pathExtension: String {
		return (self as NSString).pathExtension
	}
	
	/// SwifterSwift: NSString deletingLastPathComponent.
	public var deletingLastPathComponent: String {
		return (self as NSString).deletingLastPathComponent
	}
	
	/// SwifterSwift: NSString deletingPathExtension.
	public var deletingPathExtension: String {
		return (self as NSString).deletingPathExtension
	}
	
	/// SwifterSwift: NSString pathComponents.
	public var pathComponents: [String] {
		return (self as NSString).pathComponents
	}
	
	/// SwifterSwift: NSString appendingPathComponent(str: String)
	///
	/// - Parameter str: the path component to append to the receiver.
	/// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
	public func appendingPathComponent(_ str: String) -> String {
		return (self as NSString).appendingPathComponent(str)
	}
	
	/// SwifterSwift: NSString appendingPathExtension(str: String)
	///
	/// - Parameter str: The extension to append to the receiver.
	/// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
	public func appendingPathExtension(_ str: String) -> String? {
		return (self as NSString).appendingPathExtension(str)
	}
	
}
