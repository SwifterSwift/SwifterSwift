// SKNode+DescendantsTests.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import SpriteKit
import SwifterSwiftSpriteKit
import Testing

@MainActor
struct SKNodeDescendantsTests {
    @discardableResult
    func makeNode(_ name: String?, in parent: SKNode? = nil) -> SKNode {
        let node = SKNode()
        node.name = name
        parent?.addChild(node)
        return node
    }

    /// Builds `root → [a → [a1 → [a1x], a2], b → [b1]]`.
    func makeTree() -> SKNode {
        let root = makeNode("root")
        let a = makeNode("a", in: root)
        let a1 = makeNode("a1", in: a)
        makeNode("a1x", in: a1)
        makeNode("a2", in: a)
        let b = makeNode("b", in: root)
        makeNode("b1", in: b)
        return root
    }

    func identities(_ nodes: [SKNode]) -> [ObjectIdentifier] {
        nodes.map(ObjectIdentifier.init)
    }

    @Test
    func isEmptyForANodeWithoutChildren() {
        #expect(SKNode().descendants().isEmpty)
        #expect(SKSpriteNode(color: .black, size: CGSize(width: 10, height: 10)).descendants().isEmpty)
    }

    @Test
    func returnsTheChildrenInOrderWhenThereAreNoGrandchildren() {
        let parent = SKNode()
        let children = (0..<5).map { makeNode("child \($0)", in: parent) }
        #expect(identities(parent.descendants()) == identities(children))
    }

    @Test
    func listsTheNodesInDepthFirstPreOrder() {
        let root = makeTree()
        #expect(root.descendants().map(\.name) == ["a", "a1", "a1x", "a2", "b", "b1"])
    }

    @Test
    func containsTheSameNodesAsTheSDKSearchInADifferentOrder() {
        let root = makeTree()
        let search = root[".//*"]
        #expect(search.map(\.name) == ["a", "b", "a1", "a2", "a1x", "b1"])
        #expect(root.descendants().count == search.count)
        #expect(Set(identities(root.descendants())) == Set(identities(search)))
    }

    @Test
    func staysInsideTheSubtreeUnlikeTheRootSearch() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let branch = makeNode("branch", in: scene)
        makeNode("leaf", in: branch)
        let sibling = makeNode("sibling", in: scene)
        makeNode("cousin", in: sibling)

        #expect(branch.descendants().map(\.name) == ["leaf"])
        #expect(branch["//*"].count == 4)
    }

    @Test
    func doesNotIncludeTheNodeItselfOrItsAncestors() throws {
        let root = makeTree()
        let a = try #require(root.children.first)
        let descendants = identities(a.descendants())
        #expect(!descendants.contains(ObjectIdentifier(a)))
        #expect(!descendants.contains(ObjectIdentifier(root)))
        #expect(a.descendants().map(\.name) == ["a1", "a1x", "a2"])
    }

    @Test
    func includesUnnamedNodesAndNodesOfEveryType() {
        let parent = SKNode()
        let nodes: [SKNode] = [
            SKSpriteNode(color: .black, size: CGSize(width: 10, height: 10)),
            SKLabelNode(text: "Score"),
            SKShapeNode(circleOfRadius: 5),
            SKEmitterNode(),
            SKCameraNode(),
            SKNode()
        ]
        for node in nodes {
            parent.addChild(node)
        }
        let grandchild = SKNode()
        nodes[0].addChild(grandchild)

        #expect(identities(parent.descendants()) == identities([nodes[0], grandchild] + nodes.dropFirst()))
    }

    @Test
    func treatsNamesLiterallyEvenWhenTheyLookLikeSearchSyntax() {
        let parent = SKNode()
        let slash = makeNode("/", in: parent)
        let star = makeNode("*", in: slash)
        makeNode("..", in: star)
        makeNode("//*", in: parent)
        makeNode("", in: parent)
        #expect(parent.descendants().map(\.name) == ["/", "*", "..", "//*", ""])
    }

    @Test
    func includesNodesWithTheSameName() {
        let parent = SKNode()
        let first = makeNode("enemy", in: parent)
        let second = makeNode("enemy", in: parent)
        let nested = makeNode("enemy", in: first)
        #expect(identities(parent.descendants()) == identities([first, nested, second]))
    }

    @Test
    func returnsASnapshot() {
        let parent = SKNode()
        let child = makeNode("child", in: parent)
        let snapshot = parent.descendants()

        child.removeFromParent()
        makeNode("new", in: parent)
        #expect(identities(snapshot) == [ObjectIdentifier(child)])
        #expect(parent.descendants().map(\.name) == ["new"])
    }

    @Test
    func worksOnAScene() {
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        let player = makeNode("player", in: scene)
        makeNode("sword", in: player)
        makeNode("ground", in: scene)
        #expect(scene.descendants().map(\.name) == ["player", "sword", "ground"])
    }

    @Test
    func handlesDeepTrees() {
        let root = SKNode()
        var chain: [SKNode] = []
        var parent = root
        for _ in 0..<1_000 {
            let node = SKNode()
            parent.addChild(node)
            chain.append(node)
            parent = node
        }
        #expect(identities(root.descendants()) == identities(chain))
    }

    @Test
    func handlesWideTrees() {
        let root = SKNode()
        for index in 0..<1_000 {
            makeNode("\(index)", in: root)
        }
        #expect(root.descendants().map(\.name) == (0..<1_000).map { "\($0)" })
    }
}
#endif
