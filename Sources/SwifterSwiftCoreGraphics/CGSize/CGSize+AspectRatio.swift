// CGSize+AspectRatio.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: The ratio of the width to the height.
    ///
    /// A ratio greater than 1 describes a landscape size, and a ratio less than 1 a portrait size. When the height is
    /// zero the ratio is undefined, so the property returns 0 instead of infinity or NaN. Negative dimensions are used
    /// as they are, so the ratio can be negative.
    ///
    /// ```swift
    /// CGSize(width: 1920, height: 1080).aspectRatio  // 1.7777777777777777
    /// CGSize(width: 100, height: 200).aspectRatio  // 0.5
    /// CGSize(width: 100, height: 0).aspectRatio  // 0.0
    /// ```
    var aspectRatio: CGFloat {
        height == 0 ? 0 : width / height
    }
}
#endif
