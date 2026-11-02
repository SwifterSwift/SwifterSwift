// SKSpriteNode+AspectFill.swift - Copyright 2026 SwifterSwift

#if canImport(SpriteKit)
import CoreGraphics
import SpriteKit

public extension SKSpriteNode {
    /// SwifterSwift: Resizes the sprite to cover the given size while keeping its texture's aspect ratio.
    ///
    /// The new `size` has the texture's aspect ratio and is just large enough to cover `targetSize`: one side matches
    /// `targetSize` exactly and the other is equal or larger, so part of the sprite extends past the target area. To
    /// fit the whole sprite inside the target area instead, use `aspectFit(to:)`. Only `size` changes; the node's
    /// `position`, `anchorPoint` and scale stay the same.
    ///
    /// Nothing changes if the sprite has no texture, if its texture has no area, or if `targetSize` has a negative,
    /// infinite or NaN width or height.
    ///
    /// ```swift
    /// let sprite = SKSpriteNode(texture: SKTexture(imageNamed: "banner"))  // a 400-by-100 image
    /// sprite.aspectFill(to: CGSize(width: 100, height: 100))
    /// sprite.size  // (400.0, 100.0)
    /// ```
    ///
    /// - Parameter targetSize: The size to cover.
    func aspectFill(to targetSize: CGSize) {
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
        let ratio = max(targetSize.width / textureSize.width, targetSize.height / textureSize.height)
        size = CGSize(width: textureSize.width * ratio, height: textureSize.height * ratio)
    }
}
#endif
