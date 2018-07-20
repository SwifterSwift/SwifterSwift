//
//  SKPhysicsContactExtensions.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 7/20/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(SpriteKit)
import SpriteKit

// MARK: - Properties
public extension SKPhysicsContact {
    
    /// SwifterSwift: A convenience variable for accessing the
    /// nodes involved in a physical contact.
    public var nodes: [SKNode] {
        return [bodyA.node, bodyB.node].compactMap { $0 }
    }
}

// MARK: - Methods
public extension SKPhysicsContact {

    /// SwifterSwift: Checks if a physical contact involves two specific category bitmasks
    ///
    ///     if contact.involves(.player, and: .enemy) {
    ///         // GAME OVER
    ///     }
    ///
    /// - Parameters:
    ///     - categoryA: The first category to check
    ///     - categoryB: The second category to check
    ///
    /// - Returns: `true` if the collision involves the two specific
    ///     categories, `false` otherwise.
    ///
    public func involves(_ categoryA: UInt32, and categoryB: UInt32) -> Bool {
        return ((bodyA.categoryBitMask & categoryA != 0) && (bodyB.categoryBitMask & categoryB != 0)) ||
            ((bodyB.categoryBitMask & categoryA != 0) && (bodyA.categoryBitMask & categoryB != 0))
    }
}
#endif
