//
//  SignedIntegerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/15/17.
//  Copyright © 2017 SwifterSwift
//
#if canImport(Foundation)
import Foundation
#endif

// MARK: - Properties
public extension SignedInteger {

    /// SwifterSwift: Absolute value of integer number.
    var abs: Self {
        return Swift.abs(self)
    }

    /// SwifterSwift: Check if integer is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// SwifterSwift: Check if integer is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// SwifterSwift: Check if integer is even.
    var isEven: Bool {
        return (self % 2) == 0
    }

    /// SwifterSwift: Check if integer is odd.
    var isOdd: Bool {
        return (self % 2) != 0
    }

    /// SwifterSwift: String of format (XXh XXm) from seconds Int.
    var timeString: String {
        guard self > 0 else {
            return "0 sec"
        }
        if self < 60 {
            return "\(self) sec"
        }
        if self < 3600 {
            return "\(self / 60) min"
        }
        let hours = self / 3600
        let mins = (self % 3600) / 60

        if hours != 0 && mins == 0 {
            return "\(hours)h"
        }
        return "\(hours)h \(mins)m"
    }

}

// MARK: - Methods
public extension SignedInteger {

    /// SwifterSwift: Greatest common divisor of integer value and n.
    ///
    /// - Parameter number: integer value to find gcd with.
    /// - Returns: greatest common divisor of self and n.
    func gcd(of number: Self) -> Self {
        return number == 0 ? self : number.gcd(of: self % number)
    }

    /// SwifterSwift: Least common multiple of integer and n.
    ///
    /// - Parameter number: integer value to find lcm with.
    /// - Returns: least common multiple of self and n.
    func lcm(of number: Self) -> Self {
        return (self * number).abs / gcd(of: number)
    }

    #if canImport(Foundation)
    /// SwifterSwift: Ordinal representation of an integer.
    ///
    ///        print((12).ordinalString()) // prints "12th"
    ///
    /// - Parameter locale: locale, default is .current.
    /// - Returns: string ordinal representation of number in specified locale language. E.g. input 92, output in "en": "92nd".
    @available(iOS 9.0, macOS 10.11, *)
    func ordinalString(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .ordinal
        guard let number = self as? NSNumber else { return nil }
        return formatter.string(from: number)
    }
    #endif

}
