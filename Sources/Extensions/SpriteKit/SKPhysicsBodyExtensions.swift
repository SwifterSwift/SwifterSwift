//
//  SKPhysicsBodyExtensions.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 7/20/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(SpriteKit)
import SpriteKit

// MARK: - Methods
public extension SKPhysicsBody {
    
    /// SwifterSwift: Checks if a physics body is contacting another body
    /// with the given `categoryBitMask`
    ///
    ///     if player.physicsBody?.isTouching(Category.fire) {
    ///         // Reduce player health
    ///     }
    ///
    /// - Parameter category: The `categoryBitmMask` to check
    /// - Returns: `true` if the physics body is contacting another body
    ///             with the given bitmask, `false` otherwise.
    public func isTouching(_ category: UInt32) -> Bool {
        return allContactedBodies().contains(where: { $0.categoryBitMask == category })
    }
    
    /// SwifterSwift: Checks if a physics body is contacting another body.
    ///
    /// - Parameter body: The other physics body to check
    /// - Returns: `true` if the physics body is contacting the other, `false` otherwise.
    public func isTouching(_ body: SKPhysicsBody) -> Bool {
        return allContactedBodies().contains(body)
    }
}
#endif
