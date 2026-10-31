// SKNode+BottomLeftTests.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import SpriteKit
import SwifterSwiftSpriteKit
import Testing

@MainActor
struct SKNodeBottomLeftTests {
    func makeBox(in scene: SKScene? = nil) -> SKSpriteNode {
        let box = SKSpriteNode(color: .black, size: CGSize(width: 50, height: 50))
        scene?.addChild(box)
        return box
    }

    @Test
    func readsThePointOfTheAccumulatedFrame() {
        let box = makeBox()
        box.anchorPoint = .zero
        box.position = CGPoint(x: 10, y: 20)
        #expect(box.bottomLeft == CGPoint(x: 10, y: 20))
    }

    @Test
    func movesTheNodeSoThePointLandsOnTheNewValue() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let box = makeBox(in: scene)
        box.bottomLeft = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        #expect(box.bottomLeft == CGPoint(x: 50, y: 50))
        #expect(box.frame == CGRect(x: 50, y: 50, width: 50, height: 50))
    }

    @Test
    func settingTheSameValueAgainKeepsTheNodeInPlace() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let box = makeBox(in: scene)
        box.bottomLeft = CGPoint(x: 50, y: 50)
        let position = box.position
        box.bottomLeft = CGPoint(x: 50, y: 50)
        #expect(box.position == position)
        #expect(box.frame == CGRect(x: 50, y: 50, width: 50, height: 50))
    }

    @Test(arguments: [CGPoint(x: 200, y: -30), CGPoint(x: -75.5, y: 12.25), CGPoint(x: 0, y: 0)])
    func worksFromAnyStartingPosition(_ start: CGPoint) {
        let box = makeBox()
        box.position = start
        box.bottomLeft = CGPoint(x: 10, y: 20)
        #expect(box.bottomLeft == CGPoint(x: 10, y: 20))
        #expect(box.size == CGSize(width: 50, height: 50))
    }

    @Test(arguments: [CGPoint(x: -1_000, y: -2_000), CGPoint(x: 0.5, y: -0.25), CGPoint(x: 4_096, y: 8_192)])
    func reachesAnyPoint(_ target: CGPoint) {
        let box = makeBox()
        box.bottomLeft = target
        #expect(box.bottomLeft == target)
    }

    @Test
    func doesNotDependOnTheAnchorPoint() {
        let centered = makeBox()
        let corner = makeBox()
        corner.anchorPoint = CGPoint(x: 1, y: 0)
        centered.bottomLeft = CGPoint(x: 30, y: 40)
        corner.bottomLeft = CGPoint(x: 30, y: 40)
        #expect(centered.frame == corner.frame)
    }

    @Test
    func includesDescendants() {
        let parent = SKNode()
        let child = SKSpriteNode(color: .black, size: CGSize(width: 20, height: 20))
        child.position = CGPoint(x: 100, y: 0)
        parent.addChild(child)
        #expect(parent.bottomLeft == CGPoint(x: 90, y: -10))

        parent.bottomLeft = .zero
        #expect(parent.position == CGPoint(x: -90, y: 10))
        #expect(child.position == CGPoint(x: 100, y: 0))
        #expect(parent.bottomLeft == .zero)
    }

    @Test
    func keepsSizeScaleAndRotation() {
        let box = makeBox()
        box.zRotation = .pi / 4
        box.xScale = 2
        let rotation = box.zRotation
        let size = box.size
        box.bottomLeft = CGPoint(x: 30, y: -40)
        let frame = box.calculateAccumulatedFrame()
        #expect(abs(frame.minX - 30) < 1e-3)
        #expect(abs(frame.minY - -40) < 1e-3)
        #expect(box.zRotation == rotation)
        #expect(box.xScale == 2)
        #expect(box.size == size)
    }

    @Test
    func usesThePositionOfANodeWithoutContent() {
        let node = SKNode()
        node.position = CGPoint(x: 7, y: -3)
        #expect(node.bottomLeft == CGPoint(x: 7, y: -3))
        node.bottomLeft = CGPoint(x: 1, y: 2)
        #expect(node.position == CGPoint(x: 1, y: 2))
    }
}
#endif
