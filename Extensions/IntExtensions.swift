//
//  IntExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Int {
    
    public var abs: Int {
        return Swift.abs(self)
    }
    
    public var isEven: Bool {
        return (self % 2) == 0
    }
    
    public var isOdd: Bool {
        return (self % 2) != 0
    }
    
    public var digits: [Int] {
        var digits: [Int] = []
        for char in String(self).characters {
            if let int = Int(String(char)) {
                digits.append(int)
            }
        }
        return digits
    }
    
    public var digitsCount: Int {
        return String(self).characters.count
    }
    
    public var factorial: Int? {
        guard self >= 0 else {
            return nil
        }
        return self == 0 ? self : (self - 1).factorial
    }
    
    // Return the greatest common divisor of an integer number and n
    public func gcd(of n: Int) -> Int {
        return n == 0 ? self : n.gcd(of: self % n)
    }
    
    // Return the least common multiple of an integer number and n
    public func lcm(of n: Int) -> Int {
        return (self * n).abs / gcd(of: n)
    }
    
    /// Create a random integer between two integer numbers
    public static func randomBetween(min: Int, max: Int) -> Int {
        let delta = max - min
        let random = Int(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((random / Int(RAND_MAX)) * delta) + min;
    }

}
