//
//  FoundationDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 7/21/17.
//
//

import Foundation


// MARK: - Deprecated String
public extension String {
	
	@available(*, deprecated: 3.1.0, message: "Use Apple's replacingOccurrences(of: substring, with: newString) instead")
	/// SwifterSwift: String by replacing part of string with another string.
	///
	///		"#number# items".replacing("#number#", with: "10") -> "10 items"
	///
	/// - Parameters:
	///   - substring: old substring to find and replace.
	///   - newString: new string to insert in old string place.
	/// - Returns: string after replacing substring with newString.
	public func replacing(_ substring: String, with newString: String) -> String {
		return replacingOccurrences(of: substring, with: newString)
	}
	
	@available(*, deprecated: 3.1.0, message: "Use firstCharacterAsString instead", renamed: "firstCharacterAsString")
	/// SwifterSwift: First character of string (if applicable).
	///
	///		"Hello".firstCharacter -> Optional("H")
	///		"".firstCharacter -> nil
	///
	public var firstCharacter: String? {
		guard let first = characters.first else {
			return nil
		}
		return String(first)
	}
	
	@available(*, deprecated: 3.1.0, message: "Use lastCharacterAsString instead", renamed: "lastCharacterAsString")
	/// SwifterSwift: Last character of string (if applicable).
	///
	///		"Hello".lastCharacter -> Optional("o")
	///		"".lastCharacter -> nil
	///
	public var lastCharacter: String? {
		guard let last = characters.last else {
			return nil
		}
		return String(last)
	}
	
	@available(*, deprecated: 3.1.0, message: "Use double() instead", renamed: "double(locale:)")
	/// SwifterSwift: Double value from string (if applicable).
	///
	///		"20".double -> 20.0
	///
	public var double: Double? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Double
	}
	
	@available(*, deprecated: 3.1.0, message: "Use float() instead", renamed: "float(locale:)")
	/// SwifterSwift: Float value from string (if applicable).
	///
	///		"21".float -> 21.0
	///
	public var float: Float? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Float
	}
	
	@available(*, deprecated: 3.1.0, message: "Use Float32(string) instead")
	/// SwifterSwift: Float32 value from string (if applicable).
	///
	///		"21.86".float32 -> 21.86
	///
	public var float32: Float32? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Float32
	}
	
	@available(*, deprecated: 3.1.0, message: "Use Float64(string) instead")
	/// SwifterSwift: Float64 value from string (if applicable).
	///
	///		"23.45".float64 -> 23.45
	///
	public var float64: Float64? {
		let formatter = NumberFormatter()
		return formatter.number(from: self) as? Float64
	}
	
	@available(*, deprecated: 3.1.0, message: "Use Int16(string) instead")
	/// SwifterSwift: Int16 value from string (if applicable).
	///
	///		"101".int16 -> 101
	///
	public var int16: Int16? {
		return Int16(self)
	}
	
	@available(*, deprecated: 3.1.0, message: "Use Int32(string) instead")
	/// SwifterSwift: Int32 value from string (if applicable).
	///
	///		"101".int32 -> 101
	///
	public var int32: Int32? {
		return Int32(self)
	}
	
	@available(*, deprecated: 3.1.0, message: "Use Int64(string) instead")
	/// SwifterSwift: Int64 value from string (if applicable).
	///
	///		"101".int64 -> 101
	///
	public var int64: Int64? {
		return Int64(self)
	}
	
	@available(*, deprecated: 3.1.0, message: "Use Int8(string) instead")
	/// SwifterSwift: Int8 value from string (if applicable).
	///
	///		"101".int8 -> 101
	///
	public var int8: Int8? {
		return Int8(self)
	}
	
	@available(*, deprecated: 3.1.0, message: "Use subscript(safe i) instead")
	/// SwifterSwift: Safely subscript string with index.
	///
	///		"Hello World!"[3] -> "l"
	///		"Hello World!"[20] -> nil
	///
	/// - Parameter i: index.
	public subscript(i: Int) -> String? {
		guard i >= 0 && i < characters.count else {
			return nil
		}
		return String(self[index(startIndex, offsetBy: i)])
	}
	
	@available(*, deprecated: 3.1.0, message: "Use subscript(safe range) instead")
	/// SwifterSwift: Safely subscript string within a half-open range.
	///
	///		"Hello World!"[6..<11] -> "World"
	///		"Hello World!"[21..<110] -> nil
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
	
	@available(*, deprecated: 3.1.0, message: "Use subscript(safe range) instead")
	/// SwifterSwift: Safely subscript string within a closed range.
	///
	///		"Hello World!"[6...11] -> "World!"
	///		"Hello World!"[21...110] -> nil
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
}
