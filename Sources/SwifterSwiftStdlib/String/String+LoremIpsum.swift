// String+LoremIpsum.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the start of the classic *Lorem ipsum* placeholder text.
    ///
    /// The full text is the 445-character paragraph that starts with "Lorem ipsum dolor sit amet" and ends with "id est
    /// laborum.". It's cut at exactly `length` characters, which can fall in the middle of a word. A length of zero or
    /// less gives an empty string, and a length of more than 445 gives the full text.
    ///
    /// ```swift
    /// String.loremIpsum(ofLength: 11)  // "Lorem ipsum"
    /// String.loremIpsum(ofLength: 0)  // ""
    /// String.loremIpsum().count  // 445
    /// ```
    ///
    /// - Parameter length: The number of characters to return. The default is the length of the full text.
    /// - Returns: The first `length` characters of the placeholder text.
    /// - Complexity: O(*m*), where *m* is the smaller of `length` and 445.
    static func loremIpsum(ofLength length: Int = 445) -> String {
        guard length > 0 else { return "" }
        let text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et \
            dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex \
            ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu \
            fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt \
            mollit anim id est laborum.
            """
        return String(text.prefix(length))
    }
}
