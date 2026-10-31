// UIBezierPath+InitOvalOf.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIBezierPath {
    /// SwifterSwift: Creates an oval of the given size, centered on the origin or with its top-left corner there.
    ///
    /// This is `init(ovalIn:)` with the rectangle worked out for you. A centered path is handy for a `CAShapeLayer`,
    /// whose `position` then marks the middle of the oval. A size with equal sides gives a circle.
    ///
    /// ```swift
    /// UIBezierPath(ovalOf: CGSize(width: 100, height: 50), centered: true).bounds  // (-50.0, -25.0, 100.0, 50.0)
    /// UIBezierPath(ovalOf: CGSize(width: 100, height: 50), centered: false).bounds  // (0.0, 0.0, 100.0, 50.0)
    /// ```
    ///
    /// - Parameters:
    ///   - size: The width and height of the oval.
    ///   - centered: `true` to center the oval on the origin, `false` to put its top-left corner on the origin.
    convenience init(ovalOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(ovalIn: CGRect(origin: origin, size: size))
    }
}
#endif
