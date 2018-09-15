//
//  LocalExtensions.swift
//  SwifterSwift
//
//  Created by Basem Emara on 4/19/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Locale {

    /// SwifterSwift: UNIX representation of locale usually used for normalizing.
    public static var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }

}
#endif
