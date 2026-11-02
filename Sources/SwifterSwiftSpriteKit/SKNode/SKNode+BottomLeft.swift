// SKNode+BottomLeft.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import SpriteKit

public extension SKNode {
    /// SwifterSwift: The bottom-left corner of the node's accumulated frame, in the parent's coordinate system.
    ///
    /// The accumulated frame, from `calculateAccumulatedFrame()`, is the smallest rectangle that contains the node's
    /// content and the content of all its descendants, after their position, scale and rotation are applied. In
    /// SpriteKit the y-axis points up, so the bottom-left corner is (`minX`, `minY`) of that rectangle.
    ///
    /// Setting this property moves the node by changing its `position`, so that the bottom-left corner of the
    /// accumulated frame lands on the new value. The node's size, scale and rotation don't change, and setting the
    /// same value again leaves the node where it is.
    ///
    /// ```swift
    /// let scene = SKScene(size: CGSize(width: 100, height: 100))
    /// let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
    /// scene.addChild(box)
    ///
    /// box.bottomLeft = CGPoint(x: 50, y: 50)
    /// box.frame  // (50.0, 50.0, 50.0, 50.0)
    /// box.position  // (75.0, 75.0)
    /// box.bottomLeft  // (50.0, 50.0)
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of descendants of the node.
    var bottomLeft: CGPoint {
        get {
            let frame = calculateAccumulatedFrame()
            return CGPoint(x: frame.minX, y: frame.minY)
        }
        set {
            let frame = calculateAccumulatedFrame()
            position = CGPoint(x: position.x + newValue.x - frame.minX, y: position.y + newValue.y - frame.minY)
        }
    }
}
#endif
