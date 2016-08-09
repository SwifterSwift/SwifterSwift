//
//  DoubleExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Double {
    
    // tested
    public var abs: Double {
        return Swift.abs(self)
    }
    
    // tested
    public var floor: Double {
        return Foundation.floor(self)
    }
    
    // tested
    public var ceil: Double {
        return Foundation.ceil(self)
    }
    
    // tested
    public static func randomBetween(min: Double, max: Double) -> Double {
        let delta = max - min
        let random = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((random / Double(RAND_MAX)) * delta) + min;
    }
    
}
