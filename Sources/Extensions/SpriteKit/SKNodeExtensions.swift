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
    public func descendants() -> [SKNode] {
        let descendantsAtLevel = children.compactMap { $0 }
        let nextDescendants = children.reduce([SKNode]()) { $0 + $1.descendants() }
        return descendantsAtLevel + nextDescendants
    }
}
