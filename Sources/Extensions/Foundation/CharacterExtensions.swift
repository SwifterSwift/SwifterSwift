//
//  CharacterExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


// MARK: - Properties
public extension Character {
	
	/// SwifterSwift: Check if character is emoji.
	public var isEmoji: Bool {
		// http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
		let scalarValue = String(self).unicodeScalars.first!.value
		switch scalarValue {
		case 0x3030, 0x00AE, 0x00A9,// Special Characters
		0x1D000...0x1F77F, // Emoticons
		0x2100...0x27BF, // Misc symbols and Dingbats
		0xFE00...0xFE0F, // Variation Selectors
		0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
			return true
		default:
			return false
		}
	}
	
	/// SwifterSwift: Check if character is number.
	public var isNumber: Bool {
		return Int(String(self)) != nil
	}
	
    /// SwifterSwift: Check if character is a letter.
    public var isLetter: Bool {
        return String(self).hasLetters
    }
    
	/// SwifterSwift: Check if character is uppercased.
	public var isUppercased: Bool {
		return String(self) == String(self).uppercased()
	}
	
	/// SwifterSwift: Check if character is lowercased.
	public var isLowercased: Bool {
		return String(self) == String(self).lowercased()
	}
	
    /// SwifterSwift: Check if character is white space.
    public var isWhiteSpace: Bool {
        return String(self) == " "
    }
    
	/// SwifterSwift: Integer from character (if applicable).
	public var int: Int? {
		return Int(String(self))
	}
	
	/// SwifterSwift: String from character.
	public var string: String {
		return String(self)
	}
	
    /// SwifterSwift: Return the character lowercased.
    public var lowercased: Character {
        return String(self).lowercased().characters.first!
    }
    
    /// SwifterSwift: Return the character uppercased.
    public var uppercased: Character {
        return String(self).uppercased().characters.first!
    }
    
}


// MARK: - Operators
public extension Character {
	
	/// SwifterSwift: Repeat character multiple times.
	///
	/// - Parameters:
	///   - lhs: character to repeat.
	///   - rhs: number of times to repeat character.
	/// - Returns: string with character repeated n times.
	public static func * (lhs: Character, rhs: Int) -> String {
		guard rhs > 0 else {
			return ""
		}
		return String(repeating: String(lhs), count: rhs)
	}
	
	/// SwifterSwift: Repeat character multiple times.
	///
	/// - Parameters:
	///   - lhs: number of times to repeat character.
	///   - rhs: character to repeat.
	/// - Returns: string with character repeated n times.
	public static func * (lhs: Int, rhs: Character) -> String {
		guard lhs > 0 else {
			return ""
		}
		return String(repeating: String(rhs), count: lhs)
	}
	
}
