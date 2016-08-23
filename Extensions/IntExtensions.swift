//
//  IntExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Int {
    
    // tested
    /// Return absolute of integer value (read-only).
    public var abs: Int {
        return Swift.abs(self)
    }
    
    // tested
    /// Checks if integer value is even (read-only).
    public var isEven: Bool {
        return (self % 2) == 0
    }
    
    // tested
    /// Checks if integer value is odd (read-only).
    public var isOdd: Bool {
        return (self % 2) != 0
    }
    
    // tested
    /// Return array of digits of integer value.
    public var digits: [Int] {
        var digits: [Int] = []
        for char in String(self).characters {
            if let int = Int(String(char)) {
                digits.append(int)
            }
        }
        return digits
    }
    
    // tested
    /// Returns number of digits of integer value (read-only).
    public var digitsCount: Int {
        return String(self).characters.count
    }
    
    // tested
    /// Return greatest common divisor of integer value and n.
    public func gcd(of n: Int) -> Int {
        return n == 0 ? self : n.gcd(of: self % n)
    }
    
    // tested
    /// Return least common multiple of integer value and n.
    public func lcm(of n: Int) -> Int {
        return (self * n).abs / gcd(of: n)
    }
    
    // cool
    /// Return random integer value between two integer values.
    public static func randomBetween(min: Int, max: Int) -> Int {
        let delta = max - min
        return min + Int(arc4random_uniform(UInt32(delta)))
    }
    
    // cool
    // FIXME:
    /// Return roman numeral from an integer (I, II, IV, X,..)
    public var romanNumeral: String? {
        // https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
        guard self > 0 else { // there is no roman numerals for 0 or negative numbers
            return nil
        }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = self
        
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            if (div > 0) {
                for _ in 0..<div {
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }
        guard romanValue.characters.count > 0 else {
            return nil
        }
        return romanValue
    }
}

// FIXME:
prefix operator √
public prefix func √ (number: Int) -> Double {
    // http://nshipster.com/swift-operators/
    return sqrt(Double(number))
}

// FIXME:
infix operator **
public func ** (left: Int, right: Int) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(Double(left), Double(right))
}

// FIXME:
infix operator ±
public func ± (left: Int, right: Int) -> (Int, Int) {
    // http://nshipster.com/swift-operators/
    return (left + right, left - right)
}

// FIXME:
prefix operator ±
public prefix func ± (value: Int) -> (Int, Int) {
    // http://nshipster.com/swift-operators/
    return 0 ± value
}
