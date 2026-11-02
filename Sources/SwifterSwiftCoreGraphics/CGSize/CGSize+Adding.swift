// CGSize+Adding.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: Returns the component-wise sum of this size and another size.
    ///
    /// Widths are added to widths and heights to heights. Negative values are used as they are, so adding a size with
    /// a negative dimension shrinks that dimension, and the result isn't clamped at zero. Core Graphics has no
    /// arithmetic for sizes.
    ///
    /// ```swift
    /// let content = CGSize(width: 300, height: 200)
    /// let padding = CGSize(width: 32, height: 16)
    /// content.adding(padding)  // (332.0, 216.0)
    /// ```
    ///
    /// - Parameter size: The size whose dimensions to add.
    /// - Returns: A size with `width` equal to `self.width + size.width` and `height` equal to
    ///   `self.height + size.height`.
    func adding(_ size: CGSize) -> CGSize {
        CGSize(width: width + size.width, height: height + size.height)
    }
}
#endif
