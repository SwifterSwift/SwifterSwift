//
//  SpriteKitTests.swift
//  SwifterSwift
//
//  Created by Olivia Brown on 5/28/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
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

    func testIsTouchingCategory() {

        let expectation = XCTestExpectation(description: "Node 1 is touching Node 2, but not Node 3")

        struct Category {
            static let node1: UInt32 = 0b0001
            static let node2: UInt32 = 0b0010
            static let node3: UInt32 = 0b0100
            static let node4: UInt32 = 0b1000
        }

        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let contactDelegate = ContactDelegateMock()

        let scene = SKScene(size: sceneView.frame.size)
        scene.scaleMode = .aspectFill

        let node1 = SKShapeNode(circleOfRadius: 50)
        node1.name = "Node 1"
        node1.position = CGPoint(x: 100, y: 100)
        node1.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node1.physicsBody?.affectedByGravity = false
        node1.physicsBody?.categoryBitMask = Category.node1
        node1.physicsBody?.contactTestBitMask ^= Category.node2 ^ Category.node3
        node1.physicsBody?.collisionBitMask ^= Category.node2 ^ Category.node3

        let node2 = SKShapeNode(circleOfRadius: 50)
        node2.name = "Node 2"
        node2.position = CGPoint(x: 150, y: 100)
        node2.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node2.physicsBody?.affectedByGravity = false
        node2.physicsBody?.categoryBitMask = Category.node2
        node2.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node3
        node2.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node3

        let node3 = SKShapeNode(circleOfRadius: 50)
        node3.name = "Node 3"
        node3.position = CGPoint(x: 250, y: 250)
        node3.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node3.physicsBody?.affectedByGravity = false
        node3.physicsBody?.categoryBitMask = Category.node3
        node3.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node2
        node3.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node2

        contactDelegate.contactDidBegin = { contact in
            XCTAssertNotNil(node1.physicsBody)
            XCTAssertTrue(node1.physicsBody!.isTouching(Category.node2))
            XCTAssertFalse(node1.physicsBody!.isTouching(Category.node3))
            expectation.fulfill()
        }

        scene.physicsWorld.contactDelegate = contactDelegate

        scene.addChild(node1)
        scene.addChild(node2)
        scene.addChild(node3)

        sceneView.presentScene(scene)

        wait(for: [expectation], timeout: 0.1)
    }

    func testIsTouchingPhysicsBody() {

        let expectation = XCTestExpectation(description: "Node 1 is touching Node 2, but not Node 3")

        struct Category {
            static let node1: UInt32 = 0b0001
            static let node2: UInt32 = 0b0010
            static let node3: UInt32 = 0b0100
        }

        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let contactDelegate = ContactDelegateMock()

        let scene = SKScene(size: sceneView.frame.size)
        scene.scaleMode = .aspectFill

        let node1 = SKShapeNode(circleOfRadius: 50)
        node1.name = "Node 1"
        node1.position = CGPoint(x: 100, y: 100)
        node1.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node1.physicsBody?.affectedByGravity = false
        node1.physicsBody?.categoryBitMask = Category.node1
        node1.physicsBody?.contactTestBitMask ^= Category.node2 ^ Category.node3
        node1.physicsBody?.collisionBitMask ^= Category.node2 ^ Category.node3

        let node2 = SKShapeNode(circleOfRadius: 50)
        node2.name = "Node 2"
        node2.position = CGPoint(x: 150, y: 100)
        node2.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node2.physicsBody?.affectedByGravity = false
        node2.physicsBody?.categoryBitMask = Category.node2
        node2.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node3
        node2.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node3

        let node3 = SKShapeNode(circleOfRadius: 50)
        node3.name = "Node 3"
        node3.position = CGPoint(x: 250, y: 250)
        node3.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node3.physicsBody?.affectedByGravity = false
        node3.physicsBody?.categoryBitMask = Category.node3
        node3.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node2
        node3.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node2

        contactDelegate.contactDidBegin = { contact in
            XCTAssertNotNil(node1.physicsBody)
            XCTAssertNotNil(node2.physicsBody)
            XCTAssertNotNil(node3.physicsBody)

            XCTAssertTrue(node1.physicsBody!.isTouching(node2.physicsBody!))
            XCTAssertFalse(node1.physicsBody!.isTouching(node3.physicsBody!))
            expectation.fulfill()
        }

        scene.physicsWorld.contactDelegate = contactDelegate

        scene.addChild(node1)
        scene.addChild(node2)
        scene.addChild(node3)

        sceneView.presentScene(scene)

        wait(for: [expectation], timeout: 0.1)
    }

    func testInvolves() {

        let expectation = XCTestExpectation(description: "Contact involves Node 1 and Node 2, but not Node 3")

        struct Category {
            static let node1: UInt32 = 0b0001
            static let node2: UInt32 = 0b0010
            static let node3: UInt32 = 0b0100
        }

        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let contactDelegate = ContactDelegateMock()

        let scene = SKScene(size: sceneView.frame.size)
        scene.scaleMode = .aspectFill

        let node1 = SKShapeNode(circleOfRadius: 50)
        node1.name = "Node 1"
        node1.position = CGPoint(x: 100, y: 100)
        node1.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node1.physicsBody?.affectedByGravity = false
        node1.physicsBody?.categoryBitMask = Category.node1
        node1.physicsBody?.contactTestBitMask ^= Category.node2 ^ Category.node3
        node1.physicsBody?.collisionBitMask ^= Category.node2 ^ Category.node3

        let node2 = SKShapeNode(circleOfRadius: 50)
        node2.name = "Node 2"
        node2.position = CGPoint(x: 150, y: 100)
        node2.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node2.physicsBody?.affectedByGravity = false
        node2.physicsBody?.categoryBitMask = Category.node2
        node2.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node3
        node2.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node3

        let node3 = SKShapeNode(circleOfRadius: 50)
        node3.name = "Node 3"
        node3.position = CGPoint(x: 250, y: 250)
        node3.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node3.physicsBody?.affectedByGravity = false
        node3.physicsBody?.categoryBitMask = Category.node3
        node3.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node2
        node3.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node2

        contactDelegate.contactDidBegin = { contact in
            XCTAssertTrue(contact.involves(Category.node1, and: Category.node2))
            XCTAssertFalse(contact.involves(Category.node1, and: Category.node3))
            XCTAssertFalse(contact.involves(Category.node2, and: Category.node3))
            expectation.fulfill()
        }

        scene.physicsWorld.contactDelegate = contactDelegate

        scene.addChild(node1)
        scene.addChild(node2)
        scene.addChild(node3)

        sceneView.presentScene(scene)

        wait(for: [expectation], timeout: 0.1)
    }

    func testNodes() {

        let expectation = XCTestExpectation(description: "Nodes in contact are 1 and 2, but not 3")

        struct Category {
            static let node1: UInt32 = 0b0001
            static let node2: UInt32 = 0b0010
            static let node3: UInt32 = 0b0100
        }

        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let contactDelegate = ContactDelegateMock()

        let scene = SKScene(size: sceneView.frame.size)
        scene.scaleMode = .aspectFill

        let node1 = SKShapeNode(circleOfRadius: 50)
        node1.name = "Node 1"
        node1.position = CGPoint(x: 100, y: 100)
        node1.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node1.physicsBody?.affectedByGravity = false
        node1.physicsBody?.categoryBitMask = Category.node1
        node1.physicsBody?.contactTestBitMask ^= Category.node2 ^ Category.node3
        node1.physicsBody?.collisionBitMask ^= Category.node2 ^ Category.node3

        let node2 = SKShapeNode(circleOfRadius: 50)
        node2.name = "Node 2"
        node2.position = CGPoint(x: 150, y: 100)
        node2.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node2.physicsBody?.affectedByGravity = false
        node2.physicsBody?.categoryBitMask = Category.node2
        node2.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node3
        node2.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node3

        let node3 = SKShapeNode(circleOfRadius: 50)
        node3.name = "Node 3"
        node3.position = CGPoint(x: 250, y: 250)
        node3.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node3.physicsBody?.affectedByGravity = false
        node3.physicsBody?.categoryBitMask = Category.node3
        node3.physicsBody?.contactTestBitMask ^= Category.node1 ^ Category.node2
        node3.physicsBody?.collisionBitMask ^= Category.node1 ^ Category.node2

        contactDelegate.contactDidBegin = { contact in
            XCTAssertEqual(contact.nodes.count, 2)
            XCTAssertTrue(contact.nodes.contains(node1) && contact.nodes.contains(node2))
            XCTAssertFalse(contact.nodes.contains(node3))
            expectation.fulfill()
        }

        scene.physicsWorld.contactDelegate = contactDelegate

        scene.addChild(node1)
        scene.addChild(node2)
        scene.addChild(node3)

        sceneView.presentScene(scene)

        wait(for: [expectation], timeout: 0.1)
    }
}

fileprivate class ContactDelegateMock: NSObject, SKPhysicsContactDelegate {
    var contactDidBegin: ((SKPhysicsContact) -> Void)?
    var contactDidEnd: ((SKPhysicsContact) -> Void)?

    func didBegin(_ contact: SKPhysicsContact) {
        contactDidBegin?(contact)
    }

    func didEnd(_ contact: SKPhysicsContact) {
        contactDidEnd?(contact)
    }
}
