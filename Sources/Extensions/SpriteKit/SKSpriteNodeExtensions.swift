//
//  SKSpriteNodeExtensions.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 7/20/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(SpriteKit)
import SpriteKit

// MARK: - Methods
public extension SKSpriteNode {
    /// SwifterSwift: Creates and runs an action that animates changes to a sprite’s texture,
    /// possibly resizing the sprite. When the action executes, the sprite’s texture property
    /// animates through the textures in the texture atlas. The total duration of the action is
    /// the number of textures multiplied by the `timePerFrame`.
    ///
    /// **Note**
    ///
    /// If the restore parameter is true and this action is removed from a node before it completes,
    /// then node’s texture is still restored. This differs from the default behavior of removing an action.
    ///
    /// - Parameters:
    ///   - atlasName: The name of the texture atlas, without the `.atlas` or `.spriteatlas` extension.
    ///   - seconds: The amount of time, in seconds, that each texture is displayed.
    ///   - resize: If `true`, the sprite is resized to match each new texture. If `false`, the size of the sprite remains at a constant size.
    ///   - restore:
    ///
    ///     * If `true`:
    ///
    ///       When the action completes, the sprite’s texture is restored to the texture it had
    ///       before the action completed. (If the resize parameter is true, the sprite is resized
    ///       to match the size of the original texture.)
    ///
    ///     * If `false`:
    ///
    ///       When the action completes, the sprite’s texture remains set to the final texture in the array.
    ///
    ///   - completion: The block to run when the animation is complete.
    public func animate(
        withAtlasNamed atlasName: String,
        timePerFrame seconds: TimeInterval,
        resize: Bool,
        restore: Bool,
        completion: (() -> Void)? = nil) {

        let textureAtlas = SKTextureAtlas(named: atlasName)

        let textures = textureAtlas.textureNames
            .sorted()
            .map { SKTexture(imageNamed: $0) }

        run(SKAction.animate(with: textures, timePerFrame: seconds, resize: resize, restore: restore)) {
            completion?()
        }
    }
}
#endif
