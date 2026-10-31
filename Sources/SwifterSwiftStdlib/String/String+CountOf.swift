// String+CountOf.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the number of times the given string occurs in the string, optionally ignoring case.
    ///
    /// Occurrences don't overlap: the search continues after the end of each match, so `"aaaa"` contains `"aa"` twice,
    /// not three times. Characters are compared whole and by canonical equivalence, as `==` compares them, so `"e"`
    /// doesn't occur in `"é"`, `"\n"` doesn't occur in `"\r\n"`, and `"é"` written as one scalar matches `"e"` plus a
    /// combining accent. An empty `substring` occurs 0 times.
    ///
    /// When `caseSensitive` is `false`, the search uses Swift `Regex` with `ignoresCase()`, which compares the
    /// lowercase forms of characters, one character at a time. It doesn't depend on any locale, and it's narrower than
    /// the full case folding of Foundation's `hasPrefix(_:caseSensitive:)` or `.caseInsensitive` option: `"ß"` doesn't
    /// match `"SS"`, and the ligature `"ﬁ"` doesn't match `"fi"`.
    ///
    /// The case-sensitive count is the standard library's `ranges(of:)`, apart from the empty string, for which
    /// `ranges(of: "")` finds an empty range at every position.
    ///
    /// ```swift
    /// "Hello World!".count(of: "o", caseSensitive: true)  // 2
    /// "Hello World!".count(of: "L", caseSensitive: true)  // 0
    /// "Hello World!".count(of: "L", caseSensitive: false)  // 3
    /// "aaaa".count(of: "aa", caseSensitive: true)  // 2
    /// "👍🏽👍".count(of: "👍", caseSensitive: true)  // 1
    /// ```
    ///
    /// - Parameters:
    ///   - substring: The string to count.
    ///   - caseSensitive: Whether uppercase and lowercase letters must match exactly.
    /// - Returns: The number of non-overlapping occurrences of `substring`, or 0 if `substring` is empty.
    /// - Complexity: O(*n* × *m*), where *n* is the length of the string and *m* is the length of `substring`.
    func count(of substring: String, caseSensitive: Bool) -> Int {
        guard !substring.isEmpty else { return 0 }
        if caseSensitive {
            return ranges(of: substring).count
        }
        return ranges(of: Regex<Substring>(verbatim: substring).ignoresCase()).count
    }
}
