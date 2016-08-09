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
    public static func randomBetween(min: Int, max: Int) -> Int {
        let delta = max - min
        let random = Int(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((random / Int(RAND_MAX)) * delta) + min;
    }

}
