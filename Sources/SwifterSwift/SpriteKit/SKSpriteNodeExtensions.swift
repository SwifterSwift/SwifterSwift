// SKSpriteNodeExtensions.swift - Copyright 2021 SwifterSwift

#if canImport(SpriteKit)
import SpriteKit

// MARK: - Methods

public extension SKSpriteNode {
    /// SwifterSwift: SKSpriteNode sized with respect to aspect ratio.
    ///
    ///        node.aspectFill(to: CGSize(width: 300, height: 300)
    ///
    /// - Parameter fillSize: fill size to use for aspect ratio calculation.
    func aspectFill(to fillSize: CGSize) {
        if let texture = self.texture {
            let horizontalRatio = fillSize.width / texture.size().width
            let verticalRatio = fillSize.height / texture.size().height
            let ratio = horizontalRatio < verticalRatio ? horizontalRatio : verticalRatio
            size = CGSize(width: texture.size().width * ratio,
                          height: texture.size().height * ratio)
        }
    }
}

#endif
