// StringProtocol+CommonSuffix.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension StringProtocol {
    /// SwifterSwift: Returns the longest suffix that the string and another string have in common.
    ///
    /// This is the counterpart of Foundation's `commonPrefix(with:options:)`. The strings are compared character by
    /// character from the end, with `compare(_:options:)`, so options such as `.caseInsensitive` and
    /// `.diacriticInsensitive` apply to each pair of characters. Without `.literal`, canonically equivalent characters
    /// (such as a precomposed `ä` and `a` followed by a combining diaeresis) match. The returned suffix is taken from
    /// the receiver.
    ///
    /// ```swift
    /// "Hello world!".commonSuffix(with: "It's cold!")  // "ld!"
    /// "Hello world!".commonSuffix(with: "It's COLD!")  // "!"
    /// "Hello world!".commonSuffix(with: "It's COLD!", options: .caseInsensitive)  // "ld!"
    /// "Pelé".commonSuffix(with: "rele", options: .diacriticInsensitive)  // "elé"
    /// ```
    ///
    /// - Parameters:
    ///   - aString: The string to compare with.
    ///   - options: The options to use when comparing characters. `.anchored` and `.backwards` have no effect.
    /// - Returns: The longest common suffix, which is empty if the last characters differ.
    /// - Complexity: O(*m*), where *m* is the length of the common suffix.
    func commonSuffix(with aString: some StringProtocol, options: String.CompareOptions = []) -> String {
        let common = zip(reversed(), aString.reversed())
            .prefix { String($0).compare(String($1), options: options) == .orderedSame }
            .map(\.0)
        return String(common.reversed())
    }
}
#endif
