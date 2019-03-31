//
//  SKNodeExtensions.swift
//  SwifterSwift
//
//  Created by Olivia Brown on 5/28/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(SpriteKit)
import SpriteKit

// MARK: - Methods
public extension SKNode {

    /// SwifterSwift: Return an array of all SKNode descendants
    ///
    ///         mySKNode.descendants() -> [childNodeOne, childNodeTwo]
    ///
    func descendants() -> [SKNode] {
        return children + children.reduce(into: [SKNode]()) { $0 += $1.descendants() }
    }

}

#endif
