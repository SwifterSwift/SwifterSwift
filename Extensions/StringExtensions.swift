//
//  StringExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension String {
    
    // tested
    /// Return current locale (read-only).
    public var locale: Locale {
        return Locale.current
    }
    
    // tested
    /// Return count of substring in string.
    public func count(of string: String) -> Int {
        return components(separatedBy: string).count - 1
    }
    
    // tested
    /// Return true if string starts with substring.
    public func starts(with prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    // tested
    /// Return true if string ends with substring.
    public func ends(with suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    // tested
    /// Return true if string starts does not contain any text
    public var empty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0
    }
    
    // tested
    /// Return an array of strings seperated by given string.
    public func split(by separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    // tested
    /// Return string with no spaces or new lines in beginning and end (read-only).
    public var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // tested
    /// Removes spaces and new lines in beginning and end of string.
    public mutating func trim() {
        self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // tested
    /// Return first character of string (read-only).
    public var firstCharacter: String? {
        return Array(self.characters).map({String($0)}).first
    }
    
    // tested
    /// Return last character of string (read-only).
    public var lastCharacter: String? {
        return Array(self.characters).map({String($0)}).last
    }
    
    // tested
    /// Return string without spaces and new lines
    public var withoutSpacesAndNewLines: String {
        return self.replace(string: " ", with: "").replace(string: "\n", with: "")
    }
    
    // tested
    /// Return most common character in string (read-only).
    public var mostCommonCharacter: String {
        var mostCommon = ""
        let charSet = Set(self.withoutSpacesAndNewLines.characters.map{String($0)})
        var count = 0
        for string in charSet {
            if self.count(of: string) > count {
                count = self.count(of: string)
                mostCommon = string
            }
        }
        return mostCommon
    }
    
    // tested
    /// Returns CamelCase of string (read-only).
    public var camelCaseString: String {
        let source = self.lowercased()
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
    
    // tested
    /// Converts string format to CamelCase.
    public mutating func camelize() {
        self = self.camelCaseString
    }
    
    // tested
    /// Returns array of strings seperated by new lines.
    public func lines() -> [String] {
        var result:[String] = []
        enumerateLines { (line, stop) -> () in
            result.append(line)
        }
        return result
    }
    
    // tested
    /// Return true if string is valid email format (read-only).
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // tested
    /// Return true if string is http URL (read-only).
    public var isHttpUrl: Bool {
        guard self.starts(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    // tested
    /// Return true if string is https URL (read-only).
    public var isHttpsUrl: Bool {
        guard self.starts(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    // tested
    /// Return reversed string (read-only).
    public var reversed: String {
        return String(characters.reversed())
    }
    
    // tested
    /// Reverse string.
    public mutating func reverse() {
        self = String(characters.reversed())
    }
    
    // tested
    /// Return first index of substring in string.
    public func firstIndex(of string: String) -> Int? {
        return Array(self.characters).map({String($0)}).index(of: string)
    }
    
    // tested
    /// Replace part of string with another string.
    public func replace(string: String, with: String) -> String {
        return self.replacingOccurrences(of: string, with: with)
    }
    
    // tested
    /// Return true if string contains one or more numbers (read-only).
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    // tested
    /// Return true if string contains one or more letters (read-only).
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    // tested
    /// Return true if string contains only numbers (read-only).
    public var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    // tested
    /// Return true if string contains only letters (read-only).
    public var isAlphabetic: Bool {
        return  hasLetters && !hasNumbers
    }
    
    // tested
    /// Return true if string contains at least one letter and one number (read-only).
    public var isAlphaNumeric: Bool {
        return self.components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").characters.count == 0 && hasLetters && hasNumbers
    }
    
    // tested
    /// Return latinized string (read-only).
    public var latinized: String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    // tested
    /// Latinize string.
    public mutating func latinize() {
        self = self.latinized
    }
    
    // tested
    /// Return random string of given length.
    public static func random(of length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var string = ""
        for _ in 0..<length {
            let randomIndex = arc4random_uniform(UInt32(base.characters.count))
            string += "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
        }
        return string
    }
    
    // tested
    /// Return Int value from string (if applicable; read-only).
    public var toInt: Int? {
        return Int(self)
    }
    
    // tested
    /// Return Int8 value from string (if applicable; read-only).
    public var toInt8: Int8? {
        return Int8(self)
    }
    
    // tested
    /// Return Int16 value from string (if applicable; read-only).
    public var toInt16: Int16? {
        return Int16(self)
    }
    
    // tested
    /// Return Int32 value from string (if applicable; read-only).
    public var toInt32: Int32? {
        return Int32(self)
    }
    
    // tested
    /// Return Int64 value from string (if applicable; read-only).
    public var toInt64: Int64? {
        return Int64(self)
    }
    
    // tested
    /// Return Float value from string (if applicable; read-only).
    public var toFloat: Float? {
        return Float(self)
    }
    
    // tested
    /// Return Float32 value from string (if applicable; read-only).
    public var toFloat32: Float32? {
        return Float32(self)
    }
    
    // tested
    /// Return Float64 value from string (if applicable; read-only).
    public var toFloat64: Float64? {
        return Float64(self)
    }
    
    // tested
    /// Return Float80 value from string (if applicable; read-only).
    public var toFloat80: Float80? {
        return Float80(self)
    }
    
    // tested
    /// Return Double value from string (if applicable; read-only).
    public var toDouble: Double? {
        return Double(self)
    }
    
    // tested
    /// Return Bool value from string (if applicable; read-only).
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
