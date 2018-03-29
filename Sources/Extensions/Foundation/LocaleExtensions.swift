//
//  LocalExtensions.swift
//  SwifterSwift
//
//  Created by Basem Emara on 4/19/17.
//  Copyright © 2017 SwifterSwift
//

import Foundation

// MARK: - Properties
public extension Locale {

    /// SwifterSwift: UNIX representation of locale usually used for normalizing.
    public static var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }
    
    #if os(iOS) || os(tvOS)
    /// Show country code of current locale for device
    static var countryISOCode: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
    #endif
}
