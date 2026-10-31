// SKNode+Descendants.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import SpriteKit

public extension SKNode {
    /// SwifterSwift: Returns every node below this node in the tree: its children, their children, and so on.
    ///
    /// The node itself isn't included, so a node without children returns an empty array. The nodes are in
    /// depth-first pre-order: each child comes right before its own descendants, and siblings keep their order in
    /// `children`. Nodes are included whatever their type or name, including nodes without a name.
    ///
    /// The SDK's search `self[".//*"]` returns the same nodes in a different order, with all of a node's children
    /// before any of their descendants. Its search string is also easy to get wrong: `"//*"`, without the leading dot,
    /// searches the whole tree from its root, so it also returns this node and every other node in the scene.
    ///
    /// The returned array is a snapshot: adding or removing nodes later doesn't change it.
    ///
    /// ```swift
    /// let ship = SKNode()
    /// let engine = SKNode()
    /// let flame = SKEmitterNode()
    /// let cannon = SKSpriteNode(imageNamed: "cannon")
    /// ship.addChild(engine)
    /// engine.addChild(flame)
    /// ship.addChild(cannon)
    ///
    /// ship.descendants() == [engine, flame, cannon]  // true
    /// ship[".//*"] == [engine, cannon, flame]  // true
    ///
    /// let scene = SKScene(size: CGSize(width: 400, height: 300))
    /// scene.addChild(ship)
    /// scene.addChild(SKNode())
    /// ship.descendants().count  // 3
    /// ship["//*"].count  // 5, every node in the scene
    /// ```
    ///
    /// - Returns: The descendants of this node, in depth-first pre-order.
    /// - Complexity: O(*n*), where *n* is the number of descendants of the node.
    func descendants() -> [SKNode] {
        var descendants: [SKNode] = []
        var pending = Array(children.reversed())
        while let node = pending.popLast() {
            descendants.append(node)
            pending.append(contentsOf: node.children.reversed())
        }
        return descendants
    }
}
#endif
