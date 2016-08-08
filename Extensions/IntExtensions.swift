//
//  IntExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Int {
    
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
    
    public var abs: Int {
        return Swift.abs(self)
    }

}
