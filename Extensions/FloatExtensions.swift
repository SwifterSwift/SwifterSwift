//
//  FloatExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Float {
    
    // tested
    /// Return absolute of float value (read-only).
    public var abs: Float {
        return Swift.abs(self)
    }
    
    // tested
    /// Return floor of float value (read-only).
    public var floor: Float {
        return Foundation.floor(self)
    }
    
    // tested
    /// Return ceil of float value (read-only).
    public var ceil: Float {
        return Foundation.ceil(self)
    }
    
    // tested
    /// Return random float value between two float values.
    public static func randomBetween(min: Float, max: Float) -> Float {
        let delta = max - min
        let random = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((random / Float(RAND_MAX)) * delta) + min;
    }
    
}
