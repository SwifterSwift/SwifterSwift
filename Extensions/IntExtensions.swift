//
//  IntExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Int {
<<<<<<< HEAD

    /// Return absolute of integer value (read-only).
    public var abs: Int {
        return Swift.abs(self)
    }

    /// Checks if integer value is even (read-only).
    public var isEven: Bool {
        return (self % 2) == 0
    }

    /// Checks if integer value is odd (read-only).
    public var isOdd: Bool {
        return (self % 2) != 0
    }

    /// Return array of digits of integer value.
=======
    
    // tested
    public var abs: Int {
        return Swift.abs(self)
    }
    
    // tested
    public var isEven: Bool {
        return (self % 2) == 0
    }
    
    // tested
    public var isOdd: Bool {
        return (self % 2) != 0
    }
    
    // tested
>>>>>>> testing
    public var digits: [Int] {
        var digits: [Int] = []
        for char in String(self).characters {
            if let int = Int(String(char)) {
                digits.append(int)
            }
        }
        return digits
    }
<<<<<<< HEAD

    /// Returns number of digits of integer value (read-only).
    public var digitsCount: Int {
        return String(self).characters.count
    }

    /// Return factorial of integer value (read-only).
    public var factorial: Int? {
        guard self >= 0 else {
            return nil
        }
        return self == 0 ? self : (self - 1).factorial
    }

    /// Return greatest common divisor of integer value and n.
    public func gcd(of n: Int) -> Int {
        return n == 0 ? self : n.gcd(of: self % n)
    }

    /// Return least common multiple of integer value and n.
    public func lcm(of n: Int) -> Int {
        return (self * n).abs / gcd(of: n)
    }

    /// Return random integer value between two integer values.
=======
    
    // tested
    public var digitsCount: Int {
        return String(self).characters.count
    }
    
    // tested
    public func gcd(of n: Int) -> Int {
        return n == 0 ? self : n.gcd(of: self % n)
    }
    
    // tested
    public func lcm(of n: Int) -> Int {
        return (self * n).abs / gcd(of: n)
    }
    
    // tested
>>>>>>> testing
    public static func randomBetween(min: Int, max: Int) -> Int {
        let delta = max - min
        let random = Int(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((random / Int(RAND_MAX)) * delta) + min;
    }

}
