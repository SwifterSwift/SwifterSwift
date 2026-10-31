// String+IsPalindrome.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Whether the string reads the same backward and forward, ignoring case, spaces and punctuation.
    ///
    /// Only letters and numbers are compared, and letters are compared case-insensitively, so whole phrases work.
    /// Characters are compared as the user sees them, so an accented letter is one character whether it's stored
    /// precomposed or with a combining mark. A string without any letters or numbers, including the empty string, isn't
    /// a palindrome.
    ///
    /// ```swift
    /// "racecar".isPalindrome  // true
    /// "A man, a plan, a canal: Panama!".isPalindrome  // true
    /// "12321".isPalindrome  // true
    /// "Swift".isPalindrome  // false
    /// "".isPalindrome  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isPalindrome: Bool {
        let characters = filter { $0.isLetter || $0.isNumber }.map { $0.lowercased() }
        guard !characters.isEmpty else { return false }
        return characters.elementsEqual(characters.reversed())
    }
}
