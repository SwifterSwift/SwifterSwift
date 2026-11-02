// UIImage+Downloaded.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import Foundation
import UIKit

public extension UIImage {
    /// SwifterSwift: Downloads an image from a URL.
    ///
    /// The data is loaded with `session.data(from:)`, so it works for `https`, `file` and `data` URLs alike, follows
    /// redirects, and uses the session's cache and configuration. The data is checked by decoding it, not by its MIME
    /// type, so an image served as `application/octet-stream` still loads, while an HTML error page doesn't.
    ///
    /// The calling task owns the download: cancelling it cancels the download, and the method then throws, even when
    /// the data arrived just before. For an HTTP response, a status code outside `200..<300` throws
    /// `URLError(.badServerResponse)`, with the status code's localized description as its failure reason. Data UIKit
    /// can't decode as an image, such as an empty body, throws `URLError(.cannotDecodeContentData)`. Both errors carry
    /// the response's URL as their `failingURL`.
    ///
    /// Unlike `Data(contentsOf:)`, it doesn't block the calling thread while the data loads.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com/avatar@2x.png")!
    /// let avatar = try await UIImage.downloaded(from: url, scale: 2)  // A 2x image.
    /// avatar.scale  // 2.0
    /// ```
    ///
    /// - Parameters:
    ///   - url: The URL of the image.
    ///   - scale: The scale of the image. At `1`, its size in points equals its size in pixels; at `2`, it's half
    ///     that. A value that isn't positive and finite is treated as `1`. The default is `1`.
    ///   - session: The session to download the image with. The default is the shared session.
    /// - Returns: The downloaded image.
    /// - Throws: `URLError(.badServerResponse)` for an HTTP status outside `200..<300`,
    ///   `URLError(.cannotDecodeContentData)` for data that isn't an image, `CancellationError` when the task was
    ///   cancelled, and any error from `session`, such as `URLError(.notConnectedToInternet)` or `URLError(.cancelled)`.
    static func downloaded(from url: URL, scale: CGFloat = 1, session: URLSession = .shared) async throws -> UIImage {
        let (data, response) = try await session.data(from: url)
        try Task.checkCancellation()
        let failingURL = response.url ?? url
        if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
            let reason = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            throw URLError(
                .badServerResponse,
                userInfo: [NSURLErrorFailingURLErrorKey: failingURL, NSLocalizedFailureReasonErrorKey: reason])
        }
        guard let image = UIImage(data: data, scale: scale > 0 && scale.isFinite ? scale : 1) else {
            throw URLError(.cannotDecodeContentData, userInfo: [NSURLErrorFailingURLErrorKey: failingURL])
        }
        return image
    }
}
#endif
