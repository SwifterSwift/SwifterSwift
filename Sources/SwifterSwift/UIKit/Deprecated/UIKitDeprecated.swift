// UIKitDeprecated.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIButton {
    /// SwifterSwift: Center align title text and image
    /// - Parameters:
    ///   - imageAboveText: set true to make image above title text, default is false, image on left of text
    ///   - spacing: spacing between title text and image.
    @available(*, deprecated, message: "Please use setImageLeftOfText() or setImageAboveText() instead.")
    func centerTextAndImage(imageAboveText: Bool = false, spacing: CGFloat) {
        if imageAboveText {
            setImageAboveText(spacing: spacing)
        } else {
            setImageLeftOfText(spacing: spacing)
        }
    }
}

#endif
