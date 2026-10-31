// SKSpriteNode+AspectFit.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import SpriteKit

public extension SKSpriteNode {
    /// SwifterSwift: Resizes the sprite to fit inside the given size while keeping its texture's aspect ratio.
    ///
    /// The new `size` has the texture's aspect ratio and is as large as possible without exceeding `targetSize`: one
    /// side matches `targetSize` exactly and the other is equal or smaller, so the whole sprite stays inside the
    /// target area. To cover the whole target area instead, use `aspectFill(to:)`. Only `size` changes; the node's
    /// `position`, `anchorPoint` and scale stay the same.
    ///
    /// Nothing changes if the sprite has no texture, if its texture has no area, or if `targetSize` has a negative,
    /// infinite or NaN width or height.
    ///
    /// ```swift
    /// let sprite = SKSpriteNode(texture: SKTexture(imageNamed: "banner"))  // a 400-by-100 image
    /// sprite.aspectFit(to: CGSize(width: 100, height: 100))
    /// sprite.size  // (100.0, 25.0)
    /// ```
    ///
    /// - Parameter targetSize: The size to fit in.
    func aspectFit(to targetSize: CGSize) {
        guard
            let textureSize = texture?.size(),
            textureSize.width > 0,
            textureSize.height > 0,
            targetSize.width >= 0,
            targetSize.height >= 0,
            targetSize.width.isFinite,
            targetSize.height.isFinite
        else {
            return
        }
        let ratio = min(targetSize.width / textureSize.width, targetSize.height / textureSize.height)
        size = CGSize(width: textureSize.width * ratio, height: textureSize.height * ratio)
    }
}
#endif
