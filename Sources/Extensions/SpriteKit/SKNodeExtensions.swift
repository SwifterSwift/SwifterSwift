//
//  SpriteKitExtensions.swift
//  SwifterSwift
//
//  Created by Olivia Brown on 5/28/18.
//  Copyright © 2018 SwifterSwift
//

import SpriteKit

// MARK: - Properties
public extension SKNode {
    /// SwifterSwift: Return an array of all SKNode descendants
    ///
    ///         mySKNode.descendants() -> [childNodeOne, childNodeTwo]
    ///
    public func descendants() -> [SKNode] {
        let firstLevelDescendants = children.compactMap { $0 }
        let recursiveDescendants = children.reduce(into: [SKNode]()) { $0 += $1.descendants() }
        return firstLevelDescendants + recursiveDescendants
    }
}
