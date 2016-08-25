//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension String {
    
    // tested
    /// Return current locale.
    public var locale: Locale {
        return Locale.current
    }
    
    // tested
    /// Return count of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    // tested
    /// Return true if string starts with substring.
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    // tested
    /// Return true if string ends with substring.
    public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    // tested
    /// Return true if string starts does not contain any text
    public var empty: Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0
    }
    
    // tested
    /// Return an array of strings seperated by given string.
    public func split(by separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    // tested
    /// Return string with no spaces or new lines in beginning and end.
    public var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // tested
    /// Removes spaces and new lines in beginning and end of string.
    public mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    
    // FIXME:
    /// Return truncated string (limited to a given number of characters)
    public func truncated(to length: Int, trailing: String? = "...") -> String {
        guard self.characters.count > length else {
            return self
        }
        return self.substring(to: self.index(startIndex, offsetBy: length)) + (trailing ?? "")
    }
    
    // FIXME:
    /// Truncate string (cut it to a given number of characters)
    public mutating func truncate(to length: Int, trailing: String? = "...") {
        if self.characters.count > length {
            self = self.substring(to: self.index(startIndex, offsetBy: length)) + (trailing ?? "")
        }
    }
    
    // tested
    /// Return first character of string.
    public var firstCharacter: String? {
        return Array(characters).map({String($0)}).first
    }
    
    // tested
    /// Return last character of string.
    public var lastCharacter: String? {
        return Array(characters).map({String($0)}).last
    }
    
    // tested
    /// Return string without spaces and new lines
    public var withoutSpacesAndNewLines: String {
        return replace(string: " ", with: "").replace(string: "\n", with: "")
    }
    
    // tested
    /// Return most common character in string.
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
    
    // tested
    /// Returns CamelCase of string.
    public var camelCased: String {
        let source = lowercased()
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
        self = camelCased
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
    /// Return true if string is valid email format.
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // tested
    /// Return true if string is http URL.
    public var isHttpUrl: Bool {
        guard starts(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    // tested
    /// Return true if string is https URL.
    public var isHttpsUrl: Bool {
        guard starts(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    // tested
    /// Return reversed string.
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
        return replacingOccurrences(of: string, with: with)
    }
    
    // tested
    /// Return true if string contains one or more numbers.
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    // tested
    /// Return true if string contains one or more letters.
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    // tested
    /// Return true if string contains only numbers.
    public var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    // tested
    /// Return true if string contains only letters.
    public var isAlphabetic: Bool {
        return  hasLetters && !hasNumbers
    }
    
    // tested
    /// Return true if string contains at least one letter and one number.
    public var isAlphaNumeric: Bool {
        return components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").characters.count == 0 && hasLetters && hasNumbers
    }
    
    // tested
    /// Return latinized string.
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    // tested
    /// Latinize string.
    public mutating func latinize() {
        self = latinized
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
    /// Return Int value from string (if applicable.)
    public var toInt: Int? {
        return Int(self)
    }
    
    // tested
    /// Return Int8 value from string (if applicable.)
    public var toInt8: Int8? {
        return Int8(self)
    }
    
    // tested
    /// Return Int16 value from string (if applicable.)
    public var toInt16: Int16? {
        return Int16(self)
    }
    
    // tested
    /// Return Int32 value from string (if applicable.)
    public var toInt32: Int32? {
        return Int32(self)
    }
    
    // tested
    /// Return Int64 value from string (if applicable.)
    public var toInt64: Int64? {
        return Int64(self)
    }
    
    // tested
    /// Return Float value from string (if applicable.)
    public var toFloat: Float? {
        return Float(self)
    }
    
    // tested
    /// Return Float32 value from string (if applicable.)
    public var toFloat32: Float32? {
        return Float32(self)
    }
    
    // tested
    /// Return Float64 value from string (if applicable.)
    public var toFloat64: Float64? {
        return Float64(self)
    }
    
    // tested
    /// Return Double value from string (if applicable.)
    public var toDouble: Double? {
        return Double(self)
    }
    
    // tested
    /// Return Bool value from string (if applicable.)
    public var toBool: Bool? {
        let selfLowercased = self.trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        } else {
            return nil
        }
    }
    
    /// Return true if string contains one or more instance of substring.
    public func contain(string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    /// Return true if string contains one or more emojis.
    public var containEmoji:Bool {
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
    
    /// Return URL-escaped string.
    public var urlEncode: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    /// Escape string.
    public mutating func urlEncoded() {
        self = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    /// Return readable string from URL string.
    public var urlDecode: String {
        return removingPercentEncoding ?? self
    }
    
    /// Convert URL string into readable string.
    public mutating func urlDecoded() {
        self = removingPercentEncoding ?? self
    }
    
    // FIXME:
    /// Return string encoded in base64
    public var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    // FIXME:
    /// Return string decoded from base64
    public var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    // FIXME:
    // Return date object from "yyyy-MM-dd" formatted string
    public var toDate: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    // FIXME:
    // Return date object from "yyyy-MM-dd HH:mm:ss" formatted string
    public var toDateTime: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    // FIXME:
    /// Return an array with unicodes for all charachters in a string
    public var unicodeArray: [Int] {
        return unicodeScalars.map({$0.hashValue})
    }
}

/// Return string repeated n times.
infix operator *
public func * (left: String, right: Int) -> String {
    var newString = ""
    for _ in 0 ..< right {
        newString += left
    }
    return newString
}
