//
//  CharacterExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Character {

    /// Return current locale (read-only).
    public var locale: Locale {
        return Locale.current
    }

    /// Return true if character is number (read-only).
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }

    /// Return string from character (read-only).
    public var toString: String {
        return String(self)
    }

    /// Return integer from character (if applicable; read-only).
    public var toInt: Int? {
        return Int(String(self))
    }

}
