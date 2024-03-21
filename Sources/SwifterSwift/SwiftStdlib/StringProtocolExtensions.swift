// StringProtocolExtensions.swift - Copyright 2024 SwifterSwift

import Foundation

public extension StringProtocol {
    /// SwifterSwift: The longest common suffix.
    ///
    ///        "Hello world!".commonSuffix(with: "It's cold!") = "ld!"
    ///
    /// - Parameters:
    ///     - Parameter aString: The string with which to compare the receiver.
    ///     - Parameter options: Options for the comparison.
    /// - Returns: The longest common suffix of the receiver and the given String.
    func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        return String(zip(reversed(), aString.reversed())
            .lazy
            .prefix(while: { (lhs: Character, rhs: Character) in
                String(lhs).compare(String(rhs), options: options) == .orderedSame
            })
            .map { (lhs: Character, _: Character) in lhs }
            .reversed())
    }

    #if canImport(Foundation)
    /// SwifterSwift: Returns a new string in which all occurrences of a regex pattern in a specified range of the
    /// receiver are replaced by the template.
    /// - Parameters:
    ///   - pattern: Regex pattern to replace.
    ///   - template: The regex template to replace the pattern.
    ///   - options: Options to use when matching the regex. Only .regularExpression, .anchored .and caseInsensitive are
    /// supported.
    ///   - searchRange: The range in the receiver in which to search.
    /// - Returns: A new string in which all occurrences of regex pattern in searchRange of the receiver are replaced by
    /// template.
    func replacingOccurrences<Target, Replacement>(
        ofPattern pattern: Target,
        withTemplate template: Replacement,
        options: String.CompareOptions = [.regularExpression],
        range searchRange: Range<Self.Index>? = nil) -> String where Target: StringProtocol,
        Replacement: StringProtocol {
        assert(
            options.isStrictSubset(of: [.regularExpression, .anchored, .caseInsensitive]),
            "Invalid options for regular expression replacement")
        return replacingOccurrences(
            of: pattern,
            with: template,
            options: options.union(.regularExpression),
            range: searchRange)
    }
    #endif
}
