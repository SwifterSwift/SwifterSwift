//
//  BinaryIntegerPointExtensions.swift
//  SwifterSwift
//
//  Created by calm on 2019/6/3.
//  Copyright © 2019 SwifterSwift
//


// MARK: - Properties
public extension BinaryInteger {
    
    /// SwifterSwift: Return true if 1, or other if false.
    ///
    ///        0.isZero -> true
    ///        1.isZero -> false
    ///        2.isZero -> false
    ///
    var isZero: Bool {
        return self == 0
    }
}
