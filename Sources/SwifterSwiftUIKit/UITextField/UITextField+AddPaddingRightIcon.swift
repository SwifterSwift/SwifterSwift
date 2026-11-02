// UITextField+AddPaddingRightIcon.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UITextField {
    /// SwifterSwift: Shows an icon with padding on the right side of the text field.
    ///
    /// The right view becomes a container `padding` points wider than the image, with the image centered in it, so
    /// half the padding is on each side of the icon. It's shown with `rightViewMode` set to `.always` and replaces any
    /// existing right view. The image keeps its size; use a template image to tint it with the text field's
    /// `tintColor`. Negative padding is treated as `0`.
    ///
    /// ```swift
    /// let icon = UIImage(systemName: "eye")!
    /// textField.addPaddingRightIcon(icon, padding: 16)
    /// textField.rightView?.frame.width  // icon.size.width + 16
    /// ```
    ///
    /// - Parameters:
    ///   - image: The icon to show.
    ///   - padding: The total horizontal space around the icon, in points.
    func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let size = CGSize(width: image.size.width + max(0, padding), height: image.size.height)
        let iconView = UIView(frame: CGRect(origin: .zero, size: size))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        rightView = iconView
        rightViewMode = .always
    }
}
#endif
