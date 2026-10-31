// String+CamelCased.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: The string in lower camel case, such as `"someVariableName"`.
    ///
    /// The string is split into words at every character that isn't a letter or a number, so spaces, newlines, hyphens,
    /// underscores and punctuation all separate words and are removed. Each word is lowercased; then every word after
    /// the first gets a capital first letter (its Unicode title case, so `"ß"` becomes `"Ss"`).
    ///
    /// Because each word is lowercased first, capitals inside a word don't start a new word: `"fooBar"` becomes
    /// `"foobar"`. A string without letters or numbers gives an empty string.
    ///
    /// ```swift
    /// "sOme vAriable naMe".camelCased  // "someVariableName"
    /// "first_name".camelCased  // "firstName"
    /// "Content-Type header".camelCased  // "contentTypeHeader"
    /// "".camelCased  // ""
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var camelCased: String {
        var result = ""
        for word in split(whereSeparator: { !$0.isLetter && !$0.isNumber }) {
            let lowercased = word.lowercased()
            if result.isEmpty {
                result = lowercased
            } else if let first = lowercased.unicodeScalars.first {
                result += first.properties.titlecaseMapping
                result.unicodeScalars.append(contentsOf: lowercased.unicodeScalars.dropFirst())
            }
        }
        return result
    }
}
