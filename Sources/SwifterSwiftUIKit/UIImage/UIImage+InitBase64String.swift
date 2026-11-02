// UIImage+InitBase64String.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import Foundation
import UIKit

public extension UIImage {
    /// SwifterSwift: Creates an image from Base64-encoded image data, such as a PNG or JPEG file.
    ///
    /// The string is decoded with `Data(base64Encoded:)`, which is strict: line breaks, whitespace and a `data:` URL
    /// prefix make it fail. The initializer returns `nil` when the string isn't valid Base64 or the data isn't an image
    /// format UIKit can read.
    ///
    /// ```swift
    /// let base64 = "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAE0lEQVR42mP8v5JhEwMaYKSBIADNAwvIr8dhZAAAAABJRU5ErkJggg=="
    /// UIImage(base64String: base64)?.size  // (5.0, 5.0)
    /// UIImage(base64String: base64, scale: 5)?.size  // (1.0, 1.0)
    /// UIImage(base64String: "not base64")  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - base64String: The Base64-encoded image data.
    ///   - scale: The scale factor of the image. At `1`, the image's size in points equals its size in pixels; at `2`,
    ///     it's half that.
    convenience init?(base64String: String, scale: CGFloat = 1) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }
}
#endif
