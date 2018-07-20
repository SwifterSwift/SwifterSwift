//
//  SKPhysicsContactExtensions.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 7/20/18.
//  Copyright © 2018 SwifterSwift
//

import SpriteKit

public extension SKPhysicsContact {
    
    /// SwifterSwift: A convenience variable for accessing the
    /// nodes involved in a physical contact.
    public var nodes: [SKNode] {
        var nodes = [SKNode]()
        
        if let nodeA = bodyA.node {
            nodes.append(nodeA)
        }
        
        if let nodeB = bodyB.node {
            nodes.append(nodeB)
        }
        
        return nodes
    }
    
    ///
    /// SwifterSwift: Checks if a physical contact involves two specific categories
    ///
    /// - Parameters:
    ///     - categoryA: The first category to check
    ///     - categoryB: The second category to check
    ///
    /// - Returns: `true` if the collision involves the two specific
    ///     categories, `false` otherwise.
    ///
    public func involves(_ categoryA: UInt32, and categoryB: UInt32) -> Bool {
        return bodyA.categoryBitMask ^ bodyB.categoryBitMask == categoryA ^ categoryB
    }

}
