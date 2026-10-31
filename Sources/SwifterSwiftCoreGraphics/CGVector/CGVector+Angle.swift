// CGVector+Angle.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: The direction of the vector, in radians, measured from the positive x-axis.
    ///
    /// The angle is `atan2(dy, dx)`, in the range `-π...π`. It's 0 for a vector along the positive x-axis, and
    /// positive angles turn toward the positive y-axis: counterclockwise in Core Graphics, AppKit and SpriteKit
    /// coordinates, and clockwise on screen in UIKit's flipped coordinates.
    ///
    /// A vector along the negative x-axis has an angle of `π`, or `-π` if its `dy` is negative zero. The zero vector
    /// has an angle of 0.
    ///
    /// ```swift
    /// CGVector(dx: 1, dy: 0).angle  // 0.0
    /// CGVector(dx: 0, dy: 1).angle  // 1.5707963267948966
    /// CGVector(dx: -1, dy: -1).angle  // -2.356194490192345
    /// ```
    var angle: CGFloat {
        atan2(dy, dx)
    }
}
#endif
