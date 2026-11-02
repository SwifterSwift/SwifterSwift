// UIBezierPath+InitRectOf.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIBezierPath {
    /// SwifterSwift: Creates a rectangle of the given size, centered on the origin or with its top-left corner there.
    ///
    /// This is `init(rect:)` with the rectangle worked out for you. A centered path is handy for a `CAShapeLayer`, whose
    /// `position` then marks the middle of the rectangle.
    ///
    /// ```swift
    /// UIBezierPath(rectOf: CGSize(width: 100, height: 50), centered: true).bounds  // (-50.0, -25.0, 100.0, 50.0)
    /// UIBezierPath(rectOf: CGSize(width: 100, height: 50), centered: false).bounds  // (0.0, 0.0, 100.0, 50.0)
    /// ```
    ///
    /// - Parameters:
    ///   - size: The width and height of the rectangle.
    ///   - centered: `true` to center the rectangle on the origin, `false` to put its top-left corner on the origin.
    convenience init(rectOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(rect: CGRect(origin: origin, size: size))
    }
}
#endif
