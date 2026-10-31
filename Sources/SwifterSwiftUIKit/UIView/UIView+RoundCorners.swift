// UIView+RoundCorners.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Rounds the given corners of the view and leaves the others square.
    ///
    /// The method sets `layer.cornerRadius` and maps the corners to `layer.maskedCorners`, the part that's easy to get
    /// wrong: `.topLeft` is `.layerMinXMinYCorner`, `.bottomRight` is `.layerMaxXMaxYCorner`, and so on. Because no
    /// mask layer is involved, the corners stay rounded when the view's size changes, and `layer.mask` is left as it
    /// is. The corners are physical ones, so `.topLeft` stays on the left in a right-to-left layout. An empty set of
    /// corners leaves every corner square. A negative or NaN radius counts as `0`.
    ///
    /// As with `layer.cornerRadius` on its own, the rounding applies to the view's background color and border. To
    /// also clip the view's content and subviews, such as the image of a `UIImageView`, set `clipsToBounds` to `true`;
    /// that clips the layer's shadow too.
    ///
    /// ```swift
    /// sheetView.roundCorners([.topLeft, .topRight], radius: 16)
    /// sheetView.layer.maskedCorners  // [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    /// sheetView.layer.cornerRadius  // 16.0
    /// ```
    ///
    /// - Parameters:
    ///   - corners: The corners to round.
    ///   - radius: The radius of the rounded corners, in points.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var maskedCorners: CACornerMask = []
        if corners.contains(.topLeft) {
            maskedCorners.insert(.layerMinXMinYCorner)
        }
        if corners.contains(.topRight) {
            maskedCorners.insert(.layerMaxXMinYCorner)
        }
        if corners.contains(.bottomLeft) {
            maskedCorners.insert(.layerMinXMaxYCorner)
        }
        if corners.contains(.bottomRight) {
            maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        layer.maskedCorners = maskedCorners
        layer.cornerRadius = radius.isNaN ? 0 : max(radius, 0)
    }
}
#endif
