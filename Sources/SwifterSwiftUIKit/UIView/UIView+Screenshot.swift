// UIView+Screenshot.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Renders the view and its subviews into an image.
    ///
    /// The image covers the view's `bounds`, so it has the view's own size even when a `transform` rotates or scales
    /// it, and its scale is the `displayScale` of the view's trait collection. The result is `nil` when the view has
    /// no area.
    ///
    /// A view that's in a window is captured with `drawHierarchy(in:afterScreenUpdates:)`, which includes the content
    /// Core Animation can't render offscreen, such as visual effect views. A view without a window, or one whose
    /// hierarchy can't be captured that way, is rendered with `CALayer.render(in:)`, which draws its layers but skips
    /// visual effects. To capture a view for display only, `snapshotView(afterScreenUpdates:)` is cheaper.
    ///
    /// ```swift
    /// let badge = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    /// badge.backgroundColor = .red
    /// badge.screenshot()?.size  // (40.0, 20.0)
    /// UIView().screenshot()  // nil
    /// ```
    ///
    /// - Parameter afterScreenUpdates: Whether to wait until recent changes are on screen before capturing a view
    ///   that's in a window. Pass `true` right after changing the view.
    /// - Returns: An image of the view, or `nil` if its width or height isn't a positive, finite number.
    /// - Complexity: O(*n*), where *n* is the number of pixels in the image.
    func screenshot(afterScreenUpdates: Bool = false) -> UIImage? {
        guard bounds.width > 0, bounds.height > 0, bounds.width.isFinite, bounds.height.isFinite else { return nil }
        let format = UIGraphicsImageRendererFormat(for: traitCollection)
        return UIGraphicsImageRenderer(bounds: bounds, format: format).image { context in
            if window == nil || !drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates) {
                layer.render(in: context.cgContext)
            }
        }
    }
}
#endif
