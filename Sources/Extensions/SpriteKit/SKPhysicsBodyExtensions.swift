//
//  SKPhysicsBodyExtensions.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 7/20/18.
//  Copyright © 2018 SwifterSwift
//

import SpriteKit

public extension SKPhysicsBody {
    
    /// SwifterSwift: Checks if a physics body is contacting another body
    /// with the given `categoryBitMask`
    ///
    /// - Parameter category: The `categoryBitmMask` to check
    /// - Returns: `true` if the physics body is contacting another body
    ///             with the given bitmask, `false` otherwise.
    public func isTouching(_ category: UInt32) -> Bool {
        return allContactedBodies().contains(where: { $0.categoryBitMask == category })
    }
}
