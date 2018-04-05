//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// MARK: - Properties
public extension String {

	#if canImport(Foundation)
	/// SwifterSwift: String decoded from base64 (if applicable).
	///
	///		"SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
	///
	public var base64Decoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		guard let decodedData = Data(base64Encoded: self) else { return nil }
		return String(data: decodedData, encoding: .utf8)
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: String encoded in base64 (if applicable).
	///
	///		"Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
	///
	public var base64Encoded: String? {
		// https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
		let plainData = data(using: .utf8)
		return plainData?.base64EncodedString()
	}
	#endif

	/// SwifterSwift: Array of characters of a string.
	///
	public var charactersArray: [Character] {
		return Array(self)
	}

	#if canImport(Foundation)
	/// SwifterSwift: CamelCase of string.
	///
	///		"sOme vAriable naMe".camelCased -> "someVariableName"
	///
	public var camelCased: String {
		let source = lowercased()
		let first = source[..<source.index(after: source.startIndex)]
		if source.contains(" ") {
			let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
			let camel = connected.replacingOccurrences(of: "\n", with: "")
			let rest = String(camel.dropFirst())
			return first + rest
		}
		let rest = String(source.dropFirst())
		return first + rest
	}
	#endif

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
		guard let first = self.first else { return nil }
		return String(first)
	}

	#if canImport(Foundation)
	/// SwifterSwift: Check if string contains one or more letters.
	///
	///		"123abc".hasLetters -> true
	///		"123".hasLetters -> false
	///
	public var hasLetters: Bool {
		return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string contains one or more numbers.
	///
	///		"abcd".hasNumbers -> false
	///		"123abc".hasNumbers -> true
	///
	public var hasNumbers: Bool {
		return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
	}
	#endif

	#if canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
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
		return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string is valid email format.
	///
	///		"john@doe.com".isEmail -> true
	///
	public var isEmail: Bool {
		// http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
		return range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
					 options: .regularExpression, range: nil, locale: nil) != nil
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string is a valid URL.
	///
	///		"https://google.com".isValidUrl -> true
	///
	public var isValidUrl: Bool {
		return URL(string: self) != nil
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string is a valid schemed URL.
	///
	///		"https://google.com".isValidSchemedUrl -> true
	///		"google.com".isValidSchemedUrl -> false
	///
	public var isValidSchemedUrl: Bool {
		guard let url = URL(string: self) else { return false }
		return url.scheme != nil
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string is a valid https URL.
	///
	///		"https://google.com".isValidHttpsUrl -> true
	///
	public var isValidHttpsUrl: Bool {
		guard let url = URL(string: self) else { return false }
		return url.scheme == "https"
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string is a valid http URL.
	///
	///		"http://google.com".isValidHttpUrl -> true
	///
	public var isValidHttpUrl: Bool {
		guard let url = URL(string: self) else { return false }
		return url.scheme == "http"
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string is a valid file URL.
	///
	///		"file://Documents/file.txt".isValidFileUrl -> true
	///
	public var isValidFileUrl: Bool {
		return URL(string: self)?.isFileURL ?? false
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string is a valid Swift number.
	///
	/// Note:
	/// In North America, "." is the decimal separator,
	/// while in many parts of Europe "," is used,
	///
	///		"123".isNumeric -> true
	///     "1.3".isNumeric -> true (en_US)
	///     "1,3".isNumeric -> true (fr_FR)
	///		"abc".isNumeric -> false
	///
	public var isNumeric: Bool {
		let scanner = Scanner(string: self)
		scanner.locale = NSLocale.current
		return scanner.scanDecimal(nil) && scanner.isAtEnd
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if string only contains digits.
	///
	///     "123".isDigits -> true
	///     "1.3".isDigits -> false
	///     "abc".isDigits -> false
	///
	public var isDigits: Bool {
		return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
	}
	#endif

	/// SwifterSwift: Last character of string (if applicable).
	///
	///		"Hello".lastCharacterAsString -> Optional("o")
	///		"".lastCharacterAsString -> nil
	///
	public var lastCharacterAsString: String? {
		guard let last = self.last else { return nil }
		return String(last)
	}

	#if canImport(Foundation)
	/// SwifterSwift: Latinized string.
	///
	///		"Hèllö Wórld!".latinized -> "Hello World!"
	///
	public var latinized: String {
		return folding(options: .diacriticInsensitive, locale: Locale.current)
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Bool value from string (if applicable).
	///
	///		"1".bool -> true
	///		"False".bool -> false
	///		"Hello".bool = nil
	///
	public var bool: Bool? {
		let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
		if selfLowercased == "true" || selfLowercased == "1" {
			return true
		} else if selfLowercased == "false" || selfLowercased == "0" {
			return false
		}
		return nil
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Date object from "yyyy-MM-dd" formatted string.
	///
	///		"2007-06-29".date -> Optional(Date)
	///
	public var date: Date? {
		let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: selfLowercased)
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
	///
	///		"2007-06-29 14:23:09".dateTime -> Optional(Date)
	///
	public var dateTime: Date? {
		let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return formatter.date(from: selfLowercased)
	}
	#endif

	/// SwifterSwift: Integer value from string (if applicable).
	///
	///		"101".int -> 101
	///
	public var int: Int? {
		return Int(self)
	}

	/// SwifterSwift: Lorem ipsum string of given length.
	///
	/// - Parameter length: number of characters to limit lorem ipsum to (default is 445 - full lorem ipsum).
	/// - Returns: Lorem ipsum dolor sit amet... string.
	public static func loremIpsum(ofLength length: Int = 445) -> String {
		guard length > 0 else { return "" }

		// https://www.lipsum.com/
		let loremIpsum = """
		Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		"""
		if loremIpsum.count > length {
			return String(loremIpsum[loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: length)])
		}
		return loremIpsum
	}

	#if canImport(Foundation)
	/// SwifterSwift: URL from string (if applicable).
	///
	///		"https://google.com".url -> URL(string: "https://google.com")
	///		"not url".url -> nil
	///
	public var url: URL? {
		return URL(string: self)
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: String with no spaces or new lines in beginning and end.
	///
	///		"   hello  \n".trimmed -> "hello"
	///
	public var trimmed: String {
		return trimmingCharacters(in: .whitespacesAndNewlines)
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Readable string from a URL string.
	///
	///		"it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
	///
	public var urlDecoded: String {
		return removingPercentEncoding ?? self
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: URL escaped string.
	///
	///		"it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
	///
	public var urlEncoded: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: String without spaces and new lines.
	///
	///		"   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
	///
	public var withoutSpacesAndNewLines: String {
		return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Check if the given string contains only white spaces
	public var isWhitespace: Bool {
		return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
	}
	#endif

    #if os(iOS) || os(tvOS)
    /// SwifterSwift: Check if the given string spelled correctly
    public var isSpelledCorrectly: Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.utf16.count)

        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: Locale.preferredLanguages.first ?? "en")
        return misspelledRange.location == NSNotFound
    }
    #endif

}

// MARK: - Methods
public extension String {

	#if canImport(Foundation)
	/// Float value from string (if applicable).
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional Float value from given string.
	public func float(locale: Locale = .current) -> Float? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self)?.floatValue
	}
	#endif

	#if canImport(Foundation)
	/// Double value from string (if applicable).
	///
	/// - Parameter locale: Locale (default is Locale.current)
	/// - Returns: Optional Double value from given string.
	public func double(locale: Locale = .current) -> Double? {
		let formatter = NumberFormatter()
		formatter.locale = locale
		formatter.allowsFloats = true
		return formatter.number(from: self)?.doubleValue
	}
	#endif

	#if canImport(CoreGraphics) && canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Returns a localized string, with an optional comment for translators.
	///
	///        "Hello world".localized -> Hallo Welt
	///
	public func localized(comment: String = "") -> String {
		return NSLocalizedString(self, comment: comment)
	}
	#endif

	/// SwifterSwift: The most common character in string.
	///
	///		"This is a test, since e is appearing everywhere e should be the common character".mostCommonCharacter() -> "e"
	///
	/// - Returns: The most common character.
	public func mostCommonCharacter() -> Character? {
		let mostCommon = withoutSpacesAndNewLines.reduce(into: [Character: Int]()) {
			let count = $0[$1] ?? 0
			$0[$1] = count + 1
			}.max { $0.1 < $1.1 }?.0

		return mostCommon
	}

	/// SwifterSwift: Array with unicodes for all characters in a string.
	///
	///		"SwifterSwift".unicodeArray -> [83, 119, 105, 102, 116, 101, 114, 83, 119, 105, 102, 116]
	///
	/// - Returns: The unicodes for all characters in a string.
	public func unicodeArray() -> [Int] {
		return unicodeScalars.map { $0.hashValue }
	}

	#if canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Count of words in a string.
	///
	///		"Swift is amazing".wordsCount() -> 3
	///
	/// - Returns: The count of words contained in a string.
	public func wordCount() -> Int {
		// https://stackoverflow.com/questions/42822838
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let comps = components(separatedBy: chararacterSet)
		let words = comps.filter { !$0.isEmpty }
		return words.count
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Transforms the string into a slug string.
	///
	///        "Swift is amazing".toSlug() -> "swift-is-amazing"
	///
	/// - Returns: The string in slug format.
	public func toSlug() -> String {
		let lowercased = self.lowercased()
		let latinized = lowercased.latinized
		let withDashes = latinized.replacingOccurrences(of: " ", with: "-")

		let alphanumerics = NSCharacterSet.alphanumerics
		var filtered = withDashes.filter {
			guard String($0) != "-" else { return true }
			guard String($0) != "&" else { return true }
			return String($0).rangeOfCharacter(from: alphanumerics) != nil
		}

		while filtered.lastCharacterAsString == "-" {
			filtered = String(filtered.dropLast())
		}

		while filtered.firstCharacterAsString == "-" {
			filtered = String(filtered.dropFirst())
		}

		return filtered.replacingOccurrences(of: "--", with: "-")
	}
	#endif

	// swiftlint:disable identifier_name
	/// SwifterSwift: Safely subscript string with index.
	///
	///		"Hello World!"[3] -> "l"
	///		"Hello World!"[20] -> nil
	///
	/// - Parameter i: index.
	public subscript(safe i: Int) -> Character? {
		guard i >= 0 && i < count else { return nil }
		return self[index(startIndex, offsetBy: i)]
	}
	// swiftlint:enable identifier_name

	/// SwifterSwift: Safely subscript string within a half-open range.
	///
	///		"Hello World!"[6..<11] -> "World"
	///		"Hello World!"[21..<110] -> nil
	///
	/// - Parameter range: Half-open range.
	public subscript(safe range: CountableRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
		return String(self[lowerIndex..<upperIndex])
	}

	/// SwifterSwift: Safely subscript string within a closed range.
	///
	///		"Hello World!"[6...11] -> "World!"
	///		"Hello World!"[21...110] -> nil
	///
	/// - Parameter range: Closed range.
	public subscript(safe range: ClosedRange<Int>) -> String? {
		guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
		guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else { return nil }
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
		let source = lowercased()
		let first = source[..<source.index(after: source.startIndex)]
		if source.contains(" ") {
			let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
			let camel = connected.replacingOccurrences(of: "\n", with: "")
			let rest = String(camel.dropFirst())
			self = first + rest
			return
		}
		let rest = String(source.dropFirst())

		self = first + rest
	}

	/// SwifterSwift: Check if string contains only unique characters.
	///
	public func hasUniqueCharacters() -> Bool {
		guard count > 0 else { return false }
		var uniqueChars = Set<String>()
		for char in self {
			if uniqueChars.contains(String(char)) { return false }
			uniqueChars.insert(String(char))
		}
		return true
	}

	#if canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
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
	#endif

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

	#if canImport(Foundation)
	/// SwifterSwift: Latinize string.
	///
	///		var str = "Hèllö Wórld!"
	///		str.latinize()
	///		print(str) // prints "Hello World!"
	///
	public mutating func latinize() {
		self = folding(options: .diacriticInsensitive, locale: Locale.current)
	}
	#endif

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
			let randomIndex = arc4random_uniform(UInt32(base.count))
			let randomCharacter = base.charactersArray[Int(randomIndex)]
			randomString.append(randomCharacter)
		}
		return randomString
	}

	/// SwifterSwift: Reverse string.
	public mutating func reverse() {
		let chars: [Character] = reversed()
		self = String(chars)
	}

	// swiftlint:disable identifier_name
	/// SwifterSwift: Sliced string from a start index with length.
	///
	///        "Hello World".slicing(from: 6, length: 5) -> "World"
	///
	/// - Parameters:
	///   - i: string index the slicing should start from.
	///   - length: amount of characters to be sliced after given index.
	/// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World")
	public func slicing(from i: Int, length: Int) -> String? {
		guard length >= 0, i >= 0, i < count  else { return nil }
		guard i.advanced(by: length) <= count else {
			return self[safe: i..<count]
		}
		guard length > 0 else { return "" }
		return self[safe: i..<i.advanced(by: length)]
	}
	// swiftlint:enable identifier_name

	// swiftlint:disable identifier_name
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
		if let str = self.slicing(from: i, length: length) {
			self = String(str)
		}
	}
	// swiftlint:enable identifier_name

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
		guard end >= start else { return }
		if let str = self[safe: start..<end] {
			self = str
		}
	}

	// swiftlint:disable identifier_name
	/// SwifterSwift: Slice given string from a start index (if applicable).
	///
	///		var str = "Hello World"
	///		str.slice(at: 6)
	///		print(str) // prints "World"
	///
	/// - Parameter i: string index the slicing should start from.
	public mutating func slice(at i: Int) {
		guard i < count else { return }
		if let str = self[safe: i..<count] {
			self = str
		}
	}
	// swiftlint:enable identifier_name

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

	#if canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Removes spaces and new lines in beginning and end of string.
	///
	///		var str = "  \n Hello World \n\n\n"
	///		str.trim()
	///		print(str) // prints "Hello World"
	///
	public mutating func trim() {
		self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	#endif

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
		guard length > 0 else { return }
		if count > length {
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
		guard 1..<count ~= length else { return self }
		return self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
	}

	#if canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
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
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Verify if string matches the regex pattern.
	///
	/// - Parameter pattern: Pattern to verify.
	/// - Returns: true if string matches the pattern.
	public func matches(pattern: String) -> Bool {
		return range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
	}
	#endif

	/// SwifterSwift: Pad string to fit the length parameter size with another string in the start.
	///
	///   "hue".padStart(10) -> "       hue"
	///   "hue".padStart(10, with: "br") -> "brbrbrbhue"
	///
	/// - Parameter length: The target length to pad.
	/// - Parameter string: Pad string. Default is " ".
	public mutating func padStart(_ length: Int, with string: String = " ") {
		self = paddingStart(length, with: string)
	}

	/// SwifterSwift: Returns a string by padding to fit the length parameter size with another string in the start.
	///
	///   "hue".paddingStart(10) -> "       hue"
	///   "hue".paddingStart(10, with: "br") -> "brbrbrbhue"
	///
	/// - Parameter length: The target length to pad.
	/// - Parameter string: Pad string. Default is " ".
	/// - Returns: The string with the padding on the start.
	public func paddingStart(_ length: Int, with string: String = " ") -> String {
		guard count < length else { return self }

		let padLength = length - count
		if padLength < string.count {
			return string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)] + self
		} else {
			var padding = string
			while padding.count < padLength {
				padding.append(string)
			}
			return padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)] + self
		}
	}

	/// SwifterSwift: Pad string to fit the length parameter size with another string in the start.
	///
	///   "hue".padEnd(10) -> "hue       "
	///   "hue".padEnd(10, with: "br") -> "huebrbrbrb"
	///
	/// - Parameter length: The target length to pad.
	/// - Parameter string: Pad string. Default is " ".
	public mutating func padEnd(_ length: Int, with string: String = " ") {
		self = paddingEnd(length, with: string)
	}

	/// SwifterSwift: Returns a string by padding to fit the length parameter size with another string in the end.
	///
	///   "hue".paddingEnd(10) -> "hue       "
	///   "hue".paddingEnd(10, with: "br") -> "huebrbrbrb"
	///
	/// - Parameter length: The target length to pad.
	/// - Parameter string: Pad string. Default is " ".
	/// - Returns: The string with the padding on the end.
	public func paddingEnd(_ length: Int, with string: String = " ") -> String {
		guard count < length else { return self }

		let padLength = length - count
		if padLength < string.count {
			return self + string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)]
		} else {
			var padding = string
			while padding.count < padLength {
				padding.append(string)
			}
			return self + padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)]
		}
	}

    /// SwifterSwift: Removes given prefix from the string.
    ///
    ///   "Hello, World!".removingPrefix("Hello, ") -> "World!"
    ///
    /// - Parameter prefix: Prefix to remove from the string.
    /// - Returns: The string after prefix removing.
    public func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    /// SwifterSwift: Removes given suffix from the string.
    ///
    ///   "Hello, World!".removingSuffix(", World!") -> "Hello"
    ///
    /// - Parameter suffix: Suffix to remove from the string.
    /// - Returns: The string after suffix removing.
    public func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

}

// MARK: - Initializers
public extension String {

	#if canImport(Foundation)
	/// SwifterSwift: Create a new string from a base64 string (if applicable).
	///
	///		String(base64: "SGVsbG8gV29ybGQh") = "Hello World!"
	///		String(base64: "hello") = nil
	///
	/// - Parameter base64: base64 string.
	public init?(base64: String) {
		guard let decodedData = Data(base64Encoded: base64) else { return nil }
		guard let str = String(data: decodedData, encoding: .utf8) else { return nil }
		self.init(str)
	}
	#endif

	/// SwifterSwift: Create a new random string of given length.
	///
	///		String(randomOfLength: 10) -> "gY8r3MHvlQ"
	///
	/// - Parameter length: number of characters in string.
	public init(randomOfLength length: Int) {
		guard length > 0 else {
			self.init()
			return
		}

		let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		var randomString = ""
		for _ in 1...length {
			let randomIndex = arc4random_uniform(UInt32(base.count))
			let randomCharacter = Array(base)[Int(randomIndex)]
			randomString.append(randomCharacter)
		}
		self = randomString
	}

}

// MARK: - NSAttributedString extensions
public extension String {

	#if canImport(UIKit)
	private typealias Font = UIFont
	#endif

	#if canImport(Cocoa)
	private typealias Font = NSFont
	#endif

	#if os(iOS) || os(macOS)
	/// SwifterSwift: Bold string.
	public var bold: NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [.font: Font.boldSystemFont(ofSize: Font.systemFontSize)])
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Underlined string
	public var underline: NSAttributedString {
		return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
	}
	#endif

	#if canImport(Foundation)
	/// SwifterSwift: Strikethrough string.
	public var strikethrough: NSAttributedString {
		return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
	}
	#endif

	#if os(iOS)
	/// SwifterSwift: Italic string.
	public var italic: NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
	}
	#endif

	#if canImport(UIKit)
	/// SwifterSwift: Add color to string.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString versions of string colored with given color.
	public func colored(with color: UIColor) -> NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
	}
	#endif

	#if canImport(Cocoa)
	/// SwifterSwift: Add color to string.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString versions of string colored with given color.
	public func colored(with color: NSColor) -> NSAttributedString {
		return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
	}
	#endif

}

// MARK: - Operators
public extension String {

    /// SwifterSwift: Repeat string multiple times.
    ///
    ///        'bar' * 3 -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: string to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }

    /// SwifterSwift: Repeat string multiple times.
    ///
    ///        3 * 'bar' -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: string to repeat.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: Int, rhs: String) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: rhs, count: lhs)
    }

}

#if canImport(Foundation)
// MARK: - NSString extensions
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
#endif
