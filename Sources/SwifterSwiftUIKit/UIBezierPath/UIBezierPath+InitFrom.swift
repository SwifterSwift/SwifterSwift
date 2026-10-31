// UIBezierPath+InitFrom.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIBezierPath {
    /// SwifterSwift: Creates a path made of a single straight line between two points.
    ///
    /// The path starts with a move to `from` and adds one line to `otherPoint`. It isn't closed, so stroke it rather
    /// than fill it. Passing the same point twice gives a zero-length line.
    ///
    /// ```swift
    /// let divider = UIBezierPath(from: CGPoint(x: 0, y: 10), to: CGPoint(x: 100, y: 10))
    /// divider.currentPoint  // (100.0, 10.0)
    /// divider.bounds  // (0.0, 10.0, 100.0, 0.0)
    /// ```
    ///
    /// - Parameters:
    ///   - from: The point where the line starts.
    ///   - otherPoint: The point where the line ends.
    convenience init(from: CGPoint, to otherPoint: CGPoint) {
        self.init()
        move(to: from)
        addLine(to: otherPoint)
    }
}
#endif
