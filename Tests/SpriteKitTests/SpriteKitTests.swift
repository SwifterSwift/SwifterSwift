//
//  SpriteKitTests.swift
//  SwifterSwift
//
//  Created by Olivia Brown on 5/28/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(SpriteKit)
import SpriteKit

@testable import SwifterSwift

final class SpriteKitTests: XCTestCase {
    func testDescendants() {
        let scene = SKScene()
        let childOne = SKNode()
        scene.addChild(childOne)
        let childTwo = SKNode()
        childOne.addChild(childTwo)
        XCTAssertEqual(scene.descendants(), [childOne, childTwo])
        XCTAssertEqual(childOne.descendants(), [childTwo])
        XCTAssertEqual(childTwo.descendants(), [])
    }
}

#endif
