// UIImageViewDeprecated.swift - Copyright 2024 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UIImageView {
    /// SwifterSwift: Blurred version of an image view.
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    /// - Returns: blurred version of self.
    @available(
        *,
        deprecated,
        message: "Use UIView.blur() instead. This method incorrectly does the same thing, as it doesn't copy the image view.")
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
}

#endif
