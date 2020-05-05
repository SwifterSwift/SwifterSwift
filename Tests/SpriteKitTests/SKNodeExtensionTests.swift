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

final class SKNodeExtensionTests: XCTestCase {

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

    func testSKNodeCenter() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let nodeSize = CGSize(width: 50, height: 50)
        let node = SKSpriteNode(color: .black, size: nodeSize)
        scene.addChild(node)

        node.center = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        XCTAssertEqual(node.center, CGPoint(x: 50, y: 50))
        XCTAssertEqual(node.frame.size, nodeSize)
        XCTAssertEqual(node.frame.origin, CGPoint(x: 25, y: 25))
    }

    func testTopLeft() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let nodeSize = CGSize(width: 50, height: 50)
        let node = SKSpriteNode(color: .black, size: nodeSize)
        scene.addChild(node)

        node.topLeft = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        XCTAssertEqual(node.topLeft, CGPoint(x: 50, y: 50))
        XCTAssertEqual(node.frame.size, nodeSize)
        XCTAssertEqual(node.frame.origin, CGPoint(x: 50, y: 0))
    }

    func testTopRight() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let nodeSize = CGSize(width: 50, height: 50)
        let node = SKSpriteNode(color: .black, size: nodeSize)
        scene.addChild(node)

        node.topRight = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        XCTAssertEqual(node.topRight, CGPoint(x: 50, y: 50))
        XCTAssertEqual(node.frame.size, nodeSize)
        XCTAssertEqual(node.frame.origin, CGPoint(x: 0, y: 0))
    }

    func testBottomLeft() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let nodeSize = CGSize(width: 50, height: 50)
        let node = SKSpriteNode(color: .black, size: nodeSize)
        scene.addChild(node)

        node.bottomLeft = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        XCTAssertEqual(node.bottomLeft, CGPoint(x: 50, y: 50))
        XCTAssertEqual(node.frame.size, nodeSize)
        XCTAssertEqual(node.frame.origin, CGPoint(x: 50, y: 50))
    }

    func testBottomRight() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let nodeSize = CGSize(width: 50, height: 50)
        let node = SKSpriteNode(color: .black, size: nodeSize)
        scene.addChild(node)

        node.bottomRight = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        XCTAssertEqual(node.bottomRight, CGPoint(x: 50, y: 50))
        XCTAssertEqual(node.frame.size, nodeSize)
        XCTAssertEqual(node.frame.origin, CGPoint(x: 0, y: 50))
    }
}

#endif
