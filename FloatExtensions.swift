//
//  FloatExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Float {
    
    /// Return absolute value of float
    public var abs: Float {
        return Swift.abs(self)
    }
    
    /// Return the largest integer <= self.
    public var floor: Float {
        return Foundation.floor(self)
    }
    
    /// Rounds self to the smallest integer >= self.
    public var ceil: Float {
        return Foundation.ceil(self)
    }
    
    /// Create a random float between two float numbers
    public static func randomBetween(min: Float, max: Float) -> Float {
        let delta = max - min
        let random = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((random / Float(RAND_MAX)) * delta) + min;
    }
    
}
