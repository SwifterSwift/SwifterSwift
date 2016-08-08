//
//  CharacterExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Character {

    /// Return current locale
    public var locale: Locale {
        return Locale.current
    }
    
    /// Return true if character is a decimal number
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }
    
    /// Return a string from character
    public var toString: String {
        return String(self)
    }
    
    /// Return Int value from character (if possible)
    public var toInt: Int? {
        return Int(String(self))
    }
    
}
