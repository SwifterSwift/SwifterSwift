//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//
#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif

// MARK: - Properties
public extension String {
	
	/// SwifterSwift: String decoded from base64 (if applicable).
	///
	///		"SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
	///
	public var base64Decoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		guard let decodedData = Data(base64Encoded: self) else {
			return nil
		}
		return String(data: decodedData, encoding: .utf8)
	}
	
	/// SwifterSwift: String encoded in base64 (if applicable).
	///
	///		"Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
	///
	public var base64Encoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		let plainData = data(using: .utf8)
		return plainData?.base64EncodedString()
	}
	
	/// SwifterSwift: Array of characters of a string.
	///
	public var charactersArray: [Character] {
		return Array(characters)
	}
	
	/// SwifterSwift: CamelCase of string.
	///
	///		"sOme vAriable naMe".camelCased -> "someVariableName"
	///
	public var camelCased: String {
		let source = lowercased()
		let first = source[..<source.index(after: source.startIndex)]
		if source.characters.contains(" ") {
			let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
			let camel = connected.replacingOccurrences(of: "\n", with: "")
			let rest = String(camel.characters.dropFirst())
			return first + rest
		}
		let rest = String(source.characters.dropFirst())
		return first + rest
	}
	
	/// SwifterSwift: Check if string contains one or more emojis.
	///
	///		"Hello 😀".containEmoji -> true
	///
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
	///
	///		"Hello".firstCharacterAsString -> Optional("H")
	///		"".firstCharacterAsString -> nil
	///
	public var firstCharacterAsString: String? {
		guard let first = characters.first else {
			return nil
		}
		return String(first)
	}
	
	/// SwifterSwift: Check if string contains one or more letters.
	///
	///		"123abc".hasLetters -> true
	///		"123".hasLetters -> false
	///
	public var hasLetters: Bool {
		return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
	}
	
	/// SwifterSwift: Check if string contains one or more numbers.
	///
	///		"abcd".hasNumbers -> false
	///		"123abc".hasNumbers -> true
	///
	public var hasNumbers: Bool {
		return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
	}
	
	/// SwifterSwift: Check if string contains only letters.
	///
	///		"abc".isAlphabetic -> true
	///		"123abc".isAlphabetic -> false
	///
	public var isAlphabetic: Bool {
		let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
		let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
		return hasLetters && !hasNumbers
	}
	
	/// SwifterSwift: Check if string contains at least one letter and one number.
	///
	///		// useful for passwords
	///		"123abc".isAlphaNumeric -> true
	///		"abc".isAlphaNumeric -> false
	///
	public var isAlphaNumeric: Bool {
		let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
		let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
		let comps = components(separatedBy: .alphanumerics)
		return comps.joined(separator: "").characters.count == 0 && hasLetters && hasNumbers
	}
	
	/// SwifterSwift: Check if string is valid email format.
	///
	///		"john@doe.com".isEmail -> true
	///
	public var isEmail: Bool {
		// http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
		return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
	}
	
	/// SwifterSwift: Check if string is a valid URL.
	///
	///		"https://google.com".isValidUrl -> true
	///
	public var isValidUrl: Bool {
		return URL(string: self) != nil
	}
	
	/// SwifterSwift: Check if string is a valid schemed URL.
	///
	///		"https://google.com".isValidSchemedUrl -> true
	///		"google.com".isValidSchemedUrl -> false
	///
	public var isValidSchemedUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme != nil
	}
	
	/// SwifterSwift: Check if string is a valid https URL.
	///
	///		"https://google.com".isValidHttpsUrl -> true
	///
	public var isValidHttpsUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme == "https"
	}
	
	/// SwifterSwift: Check if string is a valid http URL.
	///
	///		"http://google.com".isValidHttpUrl -> true
	///
	public var isValidHttpUrl: Bool {
		guard let url = URL(string: self) else {
			return false
		}
		return url.scheme == "http"
	}
	
	/// SwifterSwift: Check if string is a valid file URL.
	///
	///		"file://Documents/file.txt".isValidFileUrl -> true
	///
	public var isValidFileUrl: Bool {
		return URL(string: self)?.isFileURL ?? false
	}
	
	/// SwifterSwift: Check if string contains only numbers.
	///
	///		"123".isNumeric -> true
	///		"abc".isNumeric -> false
	///
	public var isNumeric: Bool {
		let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
		let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
		return  !hasLetters && hasNumbers
	}
	
	/// SwifterSwift: Last character of string (if applicable).
	///
	///		"Hello".lastCharacterAsString -> Optional("o")
	///		"".lastCharacterAsString -> nil
	///
	public var lastCharacterAsString: String? {
		guard let last = characters.last else {
			return nil
		}
		return String(last)
	}
	
	/// SwifterSwift: Latinized string.
	///
	///		"Hèllö Wórld!".latinized -> "Hello World!"
	///
	public var latinized: String {
		return folding(options: .diacriticInsensitive, locale: Locale.current)
	}
	
	/// SwifterSwift: Number of characters in string.
	///
	///		"Hello world!".length -> 12
	///
	public var length: Int {
		return characters.count
	}
	
	/// SwifterSwift: Bool value from string (if applicable).
	///
	///		"1".bool -> true
	///		"False".bool -> false
	///		"Hello".bool = nil
	///
	public var bool: Bool? {
		let selfLowercased = trimmed.lowercased()
		if selfLowercased == "true" || selfLowercased == "1" {
			return true
		} else if selfLowercased == "false" || selfLowercased == "0" {
			return false
		}
		return nil
	}
	
	/// SwifterSwift: Date object from "yyyy-MM-dd" formatted string.
	///
	///		"2007-06-29".date -> Optional(Date)
	///
	public var date: Date? {
		let selfLowercased = trimmed.lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: selfLowercased)
	}
	
	/// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
	///
	///		"2007-06-29 14:23:09".dateTime -> Optional(Date)
	///
	public var dateTime: Date? {
		let selfLowercased = trimmed.lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return formatter.date(from: selfLowercased)
	}
	
	/// SwifterSwift: Integer value from string (if applicable).
	///
	///		"101".int -> 101
	///
	public var int: Int? {
		return Int(self)
	}
	
	/// SwifterSwift: URL from string (if applicable).
	///
	///		"https://google.com".url -> URL(string: "https://google.com")
	///		"not url".url -> nil
	///
	public var url: URL? {
		return URL(string: self)
	}
	
	/// SwifterSwift: String with no spaces or new lines in beginning and end.
	///
	///		"   hello  \n".trimmed -> "hello"
	///
	public var trimmed: String {
		return trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	/// SwifterSwift: Readable string from a URL string.
	///
	///		"it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
	///
	public var urlDecoded: String {
		return removingPercentEncoding ?? self
	}
	
	/// SwifterSwift: URL escaped string.
	///
	///		"it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
	///
	public var urlEncoded: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}
	
	/// SwifterSwift: String without spaces and new lines.
	///
	///		"   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
	///
	public var withoutSpacesAndNewLines: String {
		return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
	}
	
}

// MARK: - Methods
public extension String {
	
	/// Float value from string (if applicable).
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional Float value from given string.
	public func float(locale: Locale = .current) -> Float? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Float
	}
	
	/// Double value from string (if applicable).
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional Double value from given string.
	public func double(locale: Locale = .current) -> Double? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? Double
	}
	
	/// CGFloat value from string (if applicable).
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional CGFloat value from given string.
	public func cgFloat(locale: Locale = .current) -> CGFloat? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self) as? CGFloat
	}
	
	/// SwifterSwift: Array of strings separated by new lines.
	///
	///		"Hello\ntest".lines() -> ["Hello", "test"]
	///
	/// - Returns: Strings separated by new lines.
	public func lines() -> [String] {
		var result = [String]()
		enumerateLines { line, _ in
			result.append(line)
		}
		return result
	}
    
    /// SwifterSwift: Returns a localized string, with an optional comment for translators.
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
	
	/// SwifterSwift: The most common character in string.
	///
	///		"This is a test, since e is appearing everywhere e should be the common character".mostCommonCharacter() -> "e"
	///
	/// - Returns: The most common character.
	public func mostCommonCharacter() -> String {
		let mostCommon = withoutSpacesAndNewLines.characters.reduce([Character: Int]()) {
			var counts = $0
			counts[$1] = ($0[$1] ?? 0) + 1
			return counts
			}.max { $0.1 < $1.1 }?.0
		return mostCommon?.string ?? ""
	}
	
	/// SwifterSwift: Reversed string.
	///
	///		"foo".reversed() -> "oof"
	///
	/// - Returns: The reversed string.
	public func reversed() -> String {
		return String(characters.reversed())
	}
	
	/// SwifterSwift: Array with unicodes for all characters in a string.
	///
	///		"SwifterSwift".unicodeArray -> [83, 119, 105, 102, 116, 101, 114, 83, 119, 105, 102, 116]
	///
	/// - Returns: The unicodes for all characters in a string.
	public func unicodeArray() -> [Int] {
		return unicodeScalars.map({ $0.hashValue })
	}
	
	/// SwifterSwift: an array of all words in a string
	///
	///		"Swift is amazing".words() -> ["Swift", "is", "amazing"]
	///
	/// - Returns: The words contained in a string.
	public func words() -> [String] {
		// https://stackoverflow.com/questions/42822838
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let comps = components(separatedBy: chararacterSet)
		return comps.filter { !$0.isEmpty }
	}
	
	/// SwifterSwift: Count of words in a string.
	///
	///		"Swift is amazing".wordsCount() -> 3
	///
	/// - Returns: The count of words contained in a string.
	public func wordCount() -> Int {
		// https://stackoverflow.com/questions/42822838
		return words().count
	}
	
	/// SwifterSwift: Safely subscript string with index.
	///
	///		"Hello World!"[3] -> "l"
	///		"Hello World!"[20] -> nil
	///
	/// - Parameter i: index.
	public subscript(safe i: Int) -> String? {
		guard i >= 0 && i < characters.count else {
			return nil
		}
		return String(self[index(startIndex, offsetBy: i)])
	}
	
	/// SwifterSwift: Safely subscript string within a half-open range.
	///
	///		"Hello World!"[6..<11] -> "World"
	///		"Hello World!"[21..<110] -> nil
	///
	/// - Parameter range: Half-open range.
	public subscript(safe range: CountableRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
			return nil
		}
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
			return nil
		}
		return String(self[lowerIndex..<upperIndex])
	}
	
	/// SwifterSwift: Safely subscript string within a closed range.
	///
	///		"Hello World!"[6...11] -> "World!"
	///		"Hello World!"[21...110] -> nil
	///
	/// - Parameter range: Closed range.
	public subscript(safe range: ClosedRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
			return nil
		}
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else {
			return nil
		}
		return String(self[lowerIndex..<upperIndex])
	}
	
	#if os(iOS) || os(macOS)
	/// SwifterSwift: Copy string to global pasteboard.
	///
	///		"SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
	///
	public func copyToPasteboard() {
		#if os(iOS)
			UIPasteboard.general.string = self
		#elseif os(macOS)
			NSPasteboard.general.clearContents()
			NSPasteboard.general.setString(self, forType: .string)
		#endif
	}
	#endif
	
	/// SwifterSwift: Converts string format to CamelCase.
	///
	///		var str = "sOme vaRiabLe Name"
	///		str.camelize()
	///		print(str) // prints "someVariableName"
	///
	public mutating func camelize() {
		self = camelCased
	}
	
	/// SwifterSwift: Check if string contains only unique characters.
	///
	public func hasUniqueCharacters() -> Bool {
		guard self.characters.count > 0 else { return false }
		var uniqueChars = Set<String>()
		for char in self.characters {
			if uniqueChars.contains(String(char)) {
				return false
			}
			uniqueChars.insert(String(char))
		}
		return true
	}
	
	/// SwifterSwift: Check if string contains one or more instance of substring.
	///
	///		"Hello World!".contain("O") -> false
	///		"Hello World!".contain("o", caseSensitive: false) -> true
	///
	/// - Parameters:
	///   - string: substring to search for.
	///   - caseSensitive: set true for case sensitive search (default is true).
	/// - Returns: true if string contains one or more instance of substring.
	public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return range(of: string, options: .caseInsensitive) != nil
		}
		return range(of: string) != nil
	}
	
	/// SwifterSwift: Count of substring in string.
	///
	///		"Hello World!".count(of: "o") -> 2
	///		"Hello World!".count(of: "L", caseSensitive: false) -> 3
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
	///		"Hello World!".ends(with: "!") -> true
	///		"Hello World!".ends(with: "WoRld!", caseSensitive: false) -> true
	///
	/// - Parameters:
	///   - suffix: substring to search if string ends with.
	///   - caseSensitive: set true for case sensitive search (default is true).
	/// - Returns: true if string ends with substring.
	public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return lowercased().hasSuffix(suffix.lowercased())
		}
		return hasSuffix(suffix)
	}
	
	/// SwifterSwift: First index of substring in string.
	///
	///		"Hello World!".firstIndex(of: "l") -> 2
	///		"Hello World!".firstIndex(of: "s") -> nil
	///
	/// - Parameter string: substring to search for.
	/// - Returns: first index of substring in string (if applicable).
	public func firstIndex(of string: String) -> Int? {
		return Array(characters).map({String($0)}).index(of: string)
	}
	
	/// SwifterSwift: Latinize string.
	///
	///		var str = "Hèllö Wórld!"
	///		str.latinize()
	///		print(str) // prints "Hello World!"
	///
	public mutating func latinize() {
		self = latinized
	}
	
	/// SwifterSwift: Random string of given length.
	///
	///		String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
	///
	/// - Parameter length: number of characters in string.
	/// - Returns: random string of given length.
	public static func random(ofLength length: Int) -> String {
		guard length > 0 else { return "" }
		let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		var randomString = ""
		for _ in 1...length {
			let randomIndex = arc4random_uniform(UInt32(base.characters.count))
			let randomCharacter = base.charactersArray[Int(randomIndex)]
			randomString.append(randomCharacter)
		}
		return randomString
	}
	
	/// SwifterSwift: Reverse string.
	public mutating func reverse() {
		self = String(characters.reversed())
	}
	
	/// SwifterSwift: Sliced string from a start index with length.
	///
	///		"Hello World".slicing(from: 6, length: 5) -> "World"
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
		return self[safe: i..<i.advanced(by: length)]
	}
	
	/// SwifterSwift: Slice given string from a start index with length (if applicable).
	///
	///		var str = "Hello World"
	///		str.slice(from: 6, length: 5)
	///		print(str) // prints "World"
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
	///		"Hello World".slicing(from: 6, to: 11) -> "World"
	///
	/// - Parameters:
	///   - start: string index the slicing should start from.
	///   - end: string index the slicing should end at.
	/// - Returns: sliced substring starting from start index, and ends at end index (if applicable) (example: "Hello World".slicing(from: 6, to: 11) -> "World")
	public func slicing(from start: Int, to end: Int) -> String? {
		guard end >= start else {
			return nil
		}
		return self[safe: start..<end]
	}
	
	/// SwifterSwift: Slice given string from a start index to an end index (if applicable).
	///
	///		var str = "Hello World"
	///		str.slice(from: 6, to: 11)
	///		print(str) // prints "World"
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
	///		"Hello World".slicing(at: 6) -> "World"
	///
	/// - Parameter i: string index the slicing should start from.
	/// - Returns: sliced substring starting from start index (if applicable) (example: "Hello world".slicing(at: 6) -> "world")
	public func slicing(at i: Int) -> String? {
		guard i < characters.count else {
			return nil
		}
		return self[safe: i..<characters.count]
	}
	
	/// SwifterSwift: Slice given string from a start index (if applicable).
	///
	///		var str = "Hello World"
	///		str.slice(at: 6)
	///		print(str) // prints "World"
	///
	/// - Parameter i: string index the slicing should start from.
	public mutating func slice(at i: Int) {
		if let str = slicing(at: i) {
			self = str
		}
	}
	
	/// SwifterSwift: Array of strings separated by given string.
	///
	///		"hello World".splited(by: " ") -> ["hello", "World"]
	///
	/// - Parameter separator: separator to split string by.
	/// - Returns: array of strings separated by given string.
	public func splitted(by separator: Character) -> [String] {
		return characters.split { $0 == separator }.map(String.init)
	}
	
	/// SwifterSwift: Check if string starts with substring.
	///
	///		"hello World".starts(with: "h") -> true
	///		"hello World".starts(with: "H", caseSensitive: false) -> true
	///
	/// - Parameters:
	///   - suffix: substring to search if string starts with.
	///   - caseSensitive: set true for case sensitive search (default is true).
	/// - Returns: true if string starts with substring.
	public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
		if !caseSensitive {
			return lowercased().hasPrefix(prefix.lowercased())
		}
		return hasPrefix(prefix)
	}
	
	/// SwifterSwift: Date object from string of date format.
	///
	///		"2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
	///		"not date string".date(withFormat: "yyyy-MM-dd") -> nil
	///
	/// - Parameter format: date format.
	/// - Returns: Date object from string (if applicable).
	public func date(withFormat format: String) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.date(from: self)
	}
	
	/// SwifterSwift: Removes spaces and new lines in beginning and end of string.
	///
	///		var str = "  \n Hello World \n\n\n"
	///		str.trim()
	///		print(str) // prints "Hello World"
	///
	public mutating func trim() {
		self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	/// SwifterSwift: Truncate string (cut it to a given number of characters).
	///
	///		var str = "This is a very long sentence"
	///		str.truncate(toLength: 14)
	///		print(str) // prints "This is a very..."
	///
	/// - Parameters:
	///   - toLength: maximum number of characters before cutting.
	///   - trailing: string to add at the end of truncated string (default is "...").
	public mutating func truncate(toLength length: Int, trailing: String? = "...") {
		guard length > 0 else {
			return
		}
		if characters.count > length {
			self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
		}
	}
	
	/// SwifterSwift: Truncated string (limited to a given number of characters).
	///
	///		"This is a very long sentence".truncated(toLength: 14) -> "This is a very..."
	///		"Short sentence".truncated(toLength: 14) -> "Short sentence"
	///
	/// - Parameters:
	///   - toLength: maximum number of characters before cutting.
	///   - trailing: string to add at the end of truncated string.
	/// - Returns: truncated string (this is an extr...).
	public func truncated(toLength length: Int, trailing: String? = "...") -> String {
		guard 1..<characters.count ~= length else { return self }
		return self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
	}
	
	/// SwifterSwift: Convert URL string to readable string.
	///
	///		var str = "it's%20easy%20to%20decode%20strings"
	///		str.urlDecode()
	///		print(str) // prints "it's easy to decode strings"
	///
	public mutating func urlDecode() {
		if let decoded = removingPercentEncoding {
			self = decoded
		}
	}
	
	/// SwifterSwift: Escape string.
	///
	///		var str = "it's easy to encode strings"
	///		str.urlEncode()
	///		print(str) // prints "it's%20easy%20to%20encode%20strings"
	///
	public mutating func urlEncode() {
		if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
			self = encoded
		}
	}
	
	/// SwifterSwift: Verify if string matches the regex pattern.
	///
	/// - Parameter pattern: Pattern to verify.
	/// - Returns: true if string matches the pattern.
	func matches(pattern: String) -> Bool {
		return range(of: pattern,
		             options: String.CompareOptions.regularExpression,
		             range: nil, locale: nil) != nil
	}
	
}

// MARK: - Operators
public extension String {
	
	/// SwifterSwift: Repeat string multiple times.
	///
	///		'bar' * 3 -> "barbarbar"
	///
	/// - Parameters:
	///   - lhs: string to repeat.
	///   - rhs: number of times to repeat character.
	/// - Returns: new string with given string repeated n times.
	public static func * (lhs: String, rhs: Int) -> String {
		guard rhs > 0 else {
			return ""
		}
		return String(repeating: lhs, count: rhs)
	}
	
	/// SwifterSwift: Repeat string multiple times.
	///
	///		3 * 'bar' -> "barbarbar"
	///
	/// - Parameters:
	///   - lhs: number of times to repeat character.
	///   - rhs: string to repeat.
	/// - Returns: new string with given string repeated n times.
	public static func * (lhs: Int, rhs: String) -> String {
		guard lhs > 0 else {
			return ""
		}
		return String(repeating: rhs, count: lhs)
	}
	
}

// MARK: - Initializers
public extension String {
	
	/// SwifterSwift: Create a new string from a base64 string (if applicable).
	///
	///		String(base64: "SGVsbG8gV29ybGQh") = "Hello World!"
	///		String(base64: "hello") = nil
	///
	/// - Parameter base64: base64 string.
	public init?(base64: String) {
		guard let str = base64.base64Decoded else {
			return nil
		}
		self.init(str)
	}
	
	/// SwifterSwift: Create a new random string of given length.
	///
	///		String(randomOfLength: 10) -> "gY8r3MHvlQ"
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
	///
	public var bold: NSAttributedString {
		#if os(macOS)
			return NSMutableAttributedString(string: self, attributes: [.font: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize)])
		#else
			return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
		#endif
	}
	#endif
	
	/// SwifterSwift: Underlined string
	///
	public var underline: NSAttributedString {
		return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
	}
	
	/// SwifterSwift: Strikethrough string.
	///
	public var strikethrough: NSAttributedString {
		return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
	}
	
	#if os(iOS)
	/// SwifterSwift: Italic string.
	///
	public var italic: NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif
	
	#if os(macOS)
	/// SwifterSwift: Add color to string.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString versions of string colored with given color.
	public func colored(with color: NSColor) -> NSAttributedString {
	return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
	}
	#else
	/// SwifterSwift: Add color to string.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString versions of string colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
	}
	#endif
	
}

// MARK: - NSString extensions
public extension String {
	
	/// SwifterSwift: NSString from a string.
	///
	public var nsString: NSString {
		return NSString(string: self)
	}
	
	/// SwifterSwift: NSString lastPathComponent.
	///
	public var lastPathComponent: String {
		return (self as NSString).lastPathComponent
	}
	
	/// SwifterSwift: NSString pathExtension.
	///
	public var pathExtension: String {
		return (self as NSString).pathExtension
	}
	
	/// SwifterSwift: NSString deletingLastPathComponent.
	///
	public var deletingLastPathComponent: String {
		return (self as NSString).deletingLastPathComponent
	}
	
	/// SwifterSwift: NSString deletingPathExtension.
	///
	public var deletingPathExtension: String {
		return (self as NSString).deletingPathExtension
	}
	
	/// SwifterSwift: NSString pathComponents.
	///
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
