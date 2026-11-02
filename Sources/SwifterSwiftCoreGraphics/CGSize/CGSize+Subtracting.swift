// CGSize+Subtracting.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    /// SwifterSwift: Returns the component-wise difference between this size and another size.
    ///
    /// Widths are subtracted from widths and heights from heights. The result isn't clamped, so subtracting a larger
    /// size gives negative dimensions. Core Graphics has no arithmetic for sizes.
    ///
    /// ```swift
    /// let container = CGSize(width: 300, height: 200)
    /// let insets = CGSize(width: 32, height: 16)
    /// container.subtracting(insets)  // (268.0, 184.0)
    /// container.subtracting(CGSize(width: 400, height: 0))  // (-100.0, 200.0)
    /// ```
    ///
    /// - Parameter size: The size whose dimensions to subtract.
    /// - Returns: A size with `width` equal to `self.width - size.width` and `height` equal to
    ///   `self.height - size.height`.
    func subtracting(_ size: CGSize) -> CGSize {
        CGSize(width: width - size.width, height: height - size.height)
    }
}
#endif
