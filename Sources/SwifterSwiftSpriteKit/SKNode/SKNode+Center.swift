// SKNode+Center.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import SpriteKit

public extension SKNode {
    /// SwifterSwift: The center of the node's accumulated frame, in the parent's coordinate system.
    ///
    /// The accumulated frame, from `calculateAccumulatedFrame()`, is the smallest rectangle that contains the node's
    /// content and the content of all its descendants, after their position, scale and rotation are applied. So the
    /// center doesn't depend on the node's `anchorPoint`, and for a node without content, it's the node's `position`.
    ///
    /// Setting this property moves the node by changing its `position`, so that the center of the accumulated frame
    /// lands on the new value. The node's size, scale and rotation don't change, and setting the same value again
    /// leaves the node where it is.
    ///
    /// ```swift
    /// let scene = SKScene(size: CGSize(width: 100, height: 100))
    /// let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
    /// box.anchorPoint = .zero
    /// scene.addChild(box)
    ///
    /// box.center = CGPoint(x: 50, y: 50)
    /// box.frame  // (25.0, 25.0, 50.0, 50.0)
    /// box.position  // (25.0, 25.0)
    /// box.center  // (50.0, 50.0)
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of descendants of the node.
    var center: CGPoint {
        get {
            let frame = calculateAccumulatedFrame()
            return CGPoint(x: frame.midX, y: frame.midY)
        }
        set {
            let frame = calculateAccumulatedFrame()
            position = CGPoint(x: position.x + newValue.x - frame.midX, y: position.y + newValue.y - frame.midY)
        }
    }
}
#endif
