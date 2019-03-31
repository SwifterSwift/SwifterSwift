//
//  CharacterExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Properties
public extension Character {

    /// SwifterSwift: Check if character is emoji.
    ///
    ///        Character("😀").isEmoji -> true
    ///
    var isEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        let scalarValue = String(self).unicodeScalars.first!.value
        switch scalarValue {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        127000...127600, // Various asian characters
        65024...65039, // Variation selector
        9100...9300, // Misc items
        8400...8447: // Combining Diacritical Marks for Symbols
            return true
        default:
            return false
        }
    }

    /// SwifterSwift: Check if character is number.
    ///
    ///        Character("1").isNumber -> true
    ///        Character("a").isNumber -> false
    ///
    var isNumber: Bool {
        return Int(String(self)) != nil
    }

    /// SwifterSwift: Check if character is a letter.
    ///
    ///        Character("4").isLetter -> false
    ///        Character("a").isLetter -> true
    ///
    var isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }

    /// SwifterSwift: Check if character is lowercased.
    ///
    ///        Character("a").isLowercased -> true
    ///        Character("A").isLowercased -> false
    ///
    var isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }

    /// SwifterSwift: Check if character is uppercased.
    ///
    ///        Character("a").isUppercased -> false
    ///        Character("A").isUppercased -> true
    ///
    var isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }

    /// SwifterSwift: Check if character is white space.
    ///
    ///        Character(" ").isWhiteSpace -> true
    ///        Character("A").isWhiteSpace -> false
    ///
    var isWhiteSpace: Bool {
        return String(self) == " "
    }

    /// SwifterSwift: Integer from character (if applicable).
    ///
    ///        Character("1").int -> 1
    ///        Character("A").int -> nil
    ///
    var int: Int? {
        return Int(String(self))
    }

    /// SwifterSwift: String from character.
    ///
    ///        Character("a").string -> "a"
    ///
    var string: String {
        return String(self)
    }

    /// SwifterSwift: Return the character lowercased.
    ///
    ///        Character("A").lowercased -> Character("a")
    ///
    var lowercased: Character {
        return String(self).lowercased().first!
    }

    /// SwifterSwift: Return the character uppercased.
    ///
    ///        Character("a").uppercased -> Character("A")
    ///
    var uppercased: Character {
        return String(self).uppercased().first!
    }

}

// MARK: - Methods
public extension Character {

    /// SwifterSwift: Random character.
    ///
    ///    Character.random() -> k
    ///
    /// - Returns: A random character.
    static func randomAlphanumeric() -> Character {
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!
    }

}

// MARK: - Operators
public extension Character {

    /// SwifterSwift: Repeat character multiple times.
    ///
    ///        Character("-") * 10 -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: character to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: string with character repeated n times.
    static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: String(lhs), count: rhs)
    }

    /// SwifterSwift: Repeat character multiple times.
    ///
    ///        10 * Character("-") -> "----------"
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: character to repeat.
    /// - Returns: string with character repeated n times.
    static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: String(rhs), count: lhs)
    }

}
