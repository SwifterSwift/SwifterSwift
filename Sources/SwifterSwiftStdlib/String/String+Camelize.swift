// String+Camelize.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Converts the string to lower camel case, such as `"someVariableName"`.
    ///
    /// The string is split into words at every character that isn't a letter or a number, so spaces, newlines, hyphens,
    /// underscores and punctuation all separate words and are removed. Each word is lowercased; then every word after
    /// the first gets a capital first letter (its Unicode title case, so `"ß"` becomes `"Ss"`).
    ///
    /// Because each word is lowercased first, capitals inside a word don't start a new word: `"fooBar"` becomes
    /// `"foobar"`. A string without letters or numbers becomes empty.
    ///
    /// ```swift
    /// var name = "sOme vAriable naMe"
    /// name.camelize()
    /// name  // "someVariableName"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    mutating func camelize() {
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
        self = result
    }
}
