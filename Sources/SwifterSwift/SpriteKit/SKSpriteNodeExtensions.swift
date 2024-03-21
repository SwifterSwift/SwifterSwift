// SKSpriteNodeExtensions.swift - Copyright 2024 SwifterSwift

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
        if let textureSize = texture?.size() {
            let width = textureSize.width
            let height = textureSize.height

            // Avoid division by 0.
            guard width > 0, height > 0 else {
                return
            }

            let horizontalRatio = fillSize.width / width
            let verticalRatio = fillSize.height / height
            let ratio = horizontalRatio < verticalRatio ? horizontalRatio : verticalRatio
            size = CGSize(width: width * ratio, height: height * ratio)
        }
    }
}

#endif
