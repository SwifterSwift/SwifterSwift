//
//  StringExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension String {
    
    /// Return current locale
    public var locale: Locale {
        return Locale.current
    }
    
    /// Return count of substring in a string
    public func count(of string: String) -> Int {
        return components(separatedBy: string).count - 1
    }
    
    /// Return true if String contains another substring
    public func contain(string: String) -> Bool {
        return count(of: self) > 0
    }
    
    /// Return true if String ends with the given substring
    public func end(with suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    /// Return true is String starts with the given substring
    public func start(with prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    // FIXME: -
    /// Return true if string is empty or contains only spaces or new lines
    public var isEmpty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0
    }
    
    /// Return an array of Strings by sipliting the given String into another strings
    public func split(by separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    /// Return trimmed string (remived spaces and new lines from beginning and end of string)
    public var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public mutating func trim() {
        self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Return first character in a string
    public var firstCharacter: String? {
        return Array(self.characters).map({String($0)}).first
    }
    
    /// Return last character in a string
    public var lastCharacter: String? {
        return Array(self.characters).map({String($0)}).last
    }
    
    /// Return the most common character in a string
    public var mostCommonCharacter: String {
        var mostCommon = ""
        let charSet = Set(self.characters.map{String($0)})
        var count = 0
        for string in charSet {
            if self.count(of: string) > count {
                count = self.count(of: string)
                mostCommon = string
            }
        }
        return mostCommon
    }
    
    
    public var camelCaseString: String {
        let source = self
        if source.characters.contains(" ") {
            let first = source.substring(to: source.index(after: source.startIndex))
            let camel = source.capitalized.replace(string: " ", with: "").replace(string: "\n", with: "")
            let rest = String(camel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = source.lowercased().substring(to: source.index(after: source.startIndex))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
            
        }
    }
    
    public mutating func camelize() {
        self = self.camelCaseString
    }
    
    /// Separtare new line delimated string into array of strings
    public func lines() -> [String] {
        var result:[String] = []
        enumerateLines { (line, stop) -> () in
            result.append(line)
        }
        return result
    }
    
    /// Return true is string is a valid email format
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Return true is string is http URL
    public var isHttpUrl: Bool {
        guard self.start(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Return true is string is https URL
    public var isHttpsUrl: Bool {
        guard self.start(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Return reversed string
    public var reversed: String {
        return String(characters.reversed())
    }
    
    public mutating func reverse() {
        self = String(characters.reversed())
    }
    
    /// Return the first index of a substring in a string
    public func firstIndex(of string: String) -> Int? {
        return Array(self.characters).map({String($0)}).index(of: string)
    }
    
    /// Replace part of string with another string
    public func replace(string: String, with: String) -> String {
        return self.replacingOccurrences(of: string, with: with)
    }
    
    /// Return true is string contain one or more decimal number
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// Return true is string contain one or more letter
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// Return true is string contain one or more letters and one or more number, usually used to validate passwords
    public var isAlphaNumeric: Bool {
        return self.components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").characters.count == 0
    }
    
    /// Return true is string contain letters only
    public var isAlphabetic: Bool {
        return  hasLetters && !hasNumbers
    }
    
    /// Return true is string contain decimal numbers only
    public var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    /// Return latinized string, changes non latin letters with latin letters. eg: è becomes e
    public var latinized: String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// Latinize a string, changes non latin letters with latin letters. eg: è becomes e
    public mutating func latinize() {
        self = self.latinized
    }

    /// Return a random string of given length
    public static func random(of length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var string = ""
        for _ in 0..<length {
            let randomIndex = arc4random_uniform(UInt32(base.characters.count))
            string += "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
        }
        return string
    }
    
    /// Return Int value from string (if possible)
    public var toInt: Int? {
        return Int(self)
    }
    
    /// Return Int8 value from string (if possible)
    public var toInt8: Int8? {
        return Int8(self)
    }
    
    /// Return Int16 value from string (if possible)
    public var toInt16: Int16? {
        return Int16(self)
    }
    
    /// Return Int32 value from string (if possible)
    public var toInt32: Int32? {
        return Int32(self)
    }
    
    /// Return Int64 value from string (if possible)
    public var toInt64: Int64? {
        return Int64(self)
    }
    
    /// Return Float value from string (if possible)
    public var toFloat: Float? {
        return Float(self)
    }
    
    /// Return Float32 value from string (if possible)
    public var toFloat32: Float32? {
        return Float32(self)
    }
    
    /// Return Float64 value from string (if possible)
    public var toFloat64: Float64? {
        return Float64(self)
    }
    
    /// Return Float80 value from string (if possible)
    public var toFloat80: Float80? {
        return Float80(self)
    }
    
    /// Return Double value from string (if possible)
    public var toDouble: Double? {
        return Double(self)
    }
    
    /// Return Bool value from string (if possible)
    public var toBool: Bool? {
        if self == "true" || self == "TRUE" || self == "1" {
            return true
        } else if self == "false" || self == "FLASE" || self == "0" {
            return false
        } else {
            return nil
        }
    }
}
