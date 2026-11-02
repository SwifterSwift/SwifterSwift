// CGSize+MinDimension.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: The smaller of the width and the height.
    ///
    /// The dimensions are compared as they are, so a negative width or height isn't treated as its magnitude. If either
    /// dimension is NaN, the result is NaN, whichever dimension it is.
    ///
    /// ```swift
    /// CGSize(width: 1920, height: 1080).minDimension  // 1080.0
    /// CGSize(width: 50, height: 80).minDimension  // 50.0
    /// ```
    var minDimension: CGFloat {
        width.isNaN || height.isNaN ? .nan : min(width, height)
    }
}
#endif
