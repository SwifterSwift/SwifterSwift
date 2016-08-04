//
//  ArrayExtensions.swift
//  SwiftyExtensions
//
//  Created by Omar Albeik on 8/4/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

public extension Array {
    
    /// Return a random item from an array
    public var randomItem: Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
