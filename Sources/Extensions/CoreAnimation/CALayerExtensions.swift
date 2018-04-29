//
//  CALayerExtension.swift
//  SwifterSwift
//
//  Created by Morgan Dock on 4/26/18.
//  Copyright © 2018 SwifterSwift
//

#if !os(watchOS)

public extension CALayer {

    /// SwifterSwift: Create a shadow affect, using the same parameters used in design software such as Sketch, Zeplin, and others.
    /// This Extension originates from here: https://stackoverflow.com/questions/34269399/how-to-control-shadow-spread-and-blur/34270362
    ///
    /// - Parameters:
    ///   - color: the tint of the shadow effect.  No Default is provided
    ///   - alpha: opacity of the color applied to the shaddow effect.  Default is 0.08
    ///   - offset: the x and y offsets represented as a CGSize.  Default is (0, 3)
    ///   - blur: if set to 0 the shadow will be sharp, the higher the number, the more blurred it will be.  Default is 5.
    ///   - spread: positive values increase the size of the shadow, negative values decrease the size. Default is 0.
    public func applyShadow(withColor color: CGColor, alpha: Float = 0.08, offset: CGSize = CGSize(width: 0, height: 3), blur: CGFloat = 5, spread: CGFloat = 0) {
        shadowColor = color
        shadowOpacity = alpha
        shadowOffset = offset
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dirX = -spread
            shadowPath = CGPath(rect: bounds.insetBy(dx: dirX, dy: dirX), transform: nil)
        }
    }

}
#endif
