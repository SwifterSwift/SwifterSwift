// CGRect+Resizing.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGRect {
    /// SwifterSwift: Returns a copy of the rectangle with a new size, resized around an anchor point that stays put.
    ///
    /// The anchor is in unit coordinates of the rectangle: `(0, 0)` is the corner at `minX` and `minY`, `(1, 1)` is the
    /// corner at `maxX` and `maxY`, and the default `(0.5, 0.5)` is the center. The anchor point keeps its position
    /// while the rectangle grows or shrinks around it. Values outside `0...1` are allowed and anchor the resize to a
    /// point outside the rectangle.
    ///
    /// Where `(0, 0)` appears on screen depends on the coordinate system: it's the top-left corner in UIKit's flipped
    /// coordinates, and the bottom-left corner in the default Core Graphics and AppKit coordinates.
    ///
    /// The rectangle is read through `minX`, `minY`, `width` and `height`, which Core Graphics standardizes, so a
    /// rectangle with a negative width or height is resized like its standardized equivalent. `size` is used as is.
    ///
    /// ```swift
    /// let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    /// let size = CGSize(width: 50, height: 60)
    /// rect.resizing(to: size)  // (0.0, 10.0, 50.0, 60.0)
    /// rect.resizing(to: size, anchor: .zero)  // (10.0, 20.0, 50.0, 60.0)
    /// rect.resizing(to: size, anchor: CGPoint(x: 1, y: 1))  // (-10.0, 0.0, 50.0, 60.0)
    /// ```
    ///
    /// - Parameters:
    ///   - size: The size of the new rectangle.
    ///   - anchor: The point that stays in place, in unit coordinates of the rectangle. The default is the center.
    /// - Returns: A rectangle of the given size whose anchor point is at the same position as this rectangle's.
    func resizing(to size: CGSize, anchor: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> CGRect {
        CGRect(
            x: minX - (size.width - width) * anchor.x,
            y: minY - (size.height - height) * anchor.y,
            width: size.width,
            height: size.height
        )
    }
}
#endif
