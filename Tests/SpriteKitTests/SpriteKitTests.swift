//
//  SpriteKitTests.swift
//  SwifterSwift
//
//  Created by Olivia Brown on 5/28/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
import SpriteKit

class SpriteKitTests: XCTestCase {
    
    func testDescendants() {
        let scene = SKScene()
        let childOne = SKSpriteNode()
        scene.addChild(childOne)
        let childTwo = SKSpriteNode()
        testNode.addChild(childTwo)
        XCTAssertEqual(scene.descendants(), [childOne, childTwo])
        XCTAssertEqual(childOne.descendants(), [childTwo])
        XCTAssertEqual(childTwo.descendants(), [])
    }
    
}
