// SKSpriteNodeExtensionTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SpriteKit) && canImport(UIKit)
import SpriteKit

final class SKSpriteNodeExtensionTests: XCTestCase {
    func testAspectFill() {
        let bundle = Bundle(for: SKSpriteNodeExtensionTests.self)
        let scene = SKScene(size: CGSize(width: 750, height: 1334))
        let node = SKSpriteNode()
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        node.size = CGSize(width: 300, height: 300)
        node.texture = SKTexture(image: image)
        scene.addChild(node)

        node.aspectFill(to: CGSize(width: 100, height: 100))

        let accuracy = CGFloat(0.01)
        XCTAssertEqual(node.size.width, 100, accuracy: accuracy)
        XCTAssertEqual(node.size.height, 23.2, accuracy: accuracy)
    }

    func testAspectFillWithEmptyImage() {
        let scene = SKScene(size: CGSize(width: 750, height: 1334))
        let node = SKSpriteNode()
        let image = UIImage(color: .clear, size: .zero)

        node.size = CGSize(width: 300, height: 300)
        node.texture = SKTexture(image: image)
        scene.addChild(node)

        let accuracy = CGFloat(0.01)
        node.aspectFill(to: CGSize(width: 100, height: 100))
        XCTAssertEqual(node.size.width, 300, accuracy: accuracy)
        XCTAssertEqual(node.size.height, 300, accuracy: accuracy)
    }
}

#endif
