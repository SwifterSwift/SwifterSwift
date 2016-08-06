//
//  DoubleExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Double {
    
    /// Return absolute value of double
    public var abs: Double {
        return Swift.abs(self)
    }
    
    /// Return squared root of double
    public var sqrt: Double {
        return Foundation.sqrt(self)
    }
    
    /// Return the largest integer <= self.
    public var floor: Double {
        return Foundation.floor(self)
    }
    
    /// Rounds self to the smallest integer >= self.
    public var ceil: Double {
        return Foundation.ceil(self)
    }
    
}
