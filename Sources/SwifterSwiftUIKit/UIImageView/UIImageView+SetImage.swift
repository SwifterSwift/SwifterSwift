// UIImageView+SetImage.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIImageView {
    /// SwifterSwift: Shows a placeholder, then downloads an image from a URL and shows it.
    ///
    /// The image view shows `placeholder` right away, or no image when it's `nil`, which clears an image left over from
    /// a reused cell. The data is loaded with `session.data(from:)`, so it works for `https`, `file` and `data` URLs
    /// alike, and it's checked by decoding it, not by its MIME type. The image has a scale of `1`, so its size in points
    /// equals its size in pixels; the image view's `contentMode` decides how it's fitted.
    ///
    /// The calling task owns the download. Cancelling it cancels the download, and the method then throws and leaves the
    /// placeholder showing, even when the data arrived just before. Keep the task of a reusable cell and cancel it in
    /// `prepareForReuse()`, so a slow download can't show its image in a cell that now shows another item. When the
    /// download fails, the placeholder stays and the error is thrown.
    ///
    /// ```swift
    /// // In a cell subclass with an `imageView` property.
    /// var loadTask: Task<Void, Never>?
    ///
    /// func show(_ photo: Photo) {
    ///     loadTask = Task { try? await imageView.setImage(from: photo.url, placeholder: UIImage(systemName: "photo")) }
    /// }
    ///
    /// override func prepareForReuse() {
    ///     super.prepareForReuse()
    ///     loadTask?.cancel()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - url: The URL of the image.
    ///   - placeholder: The image to show while the image downloads, and if the download fails. The default is `nil`,
    ///     which shows no image.
    ///   - session: The session to download the image with. The default is the shared session.
    /// - Throws: `URLError(.badServerResponse)` for an HTTP status outside `200..<300`,
    ///   `URLError(.cannotDecodeContentData)` for data that isn't an image, `CancellationError` when the task was
    ///   cancelled, and any error from `session`, such as `URLError(.notConnectedToInternet)` or `URLError(.cancelled)`.
    @MainActor
    func setImage(from url: URL, placeholder: UIImage? = nil, session: URLSession = .shared) async throws {
        image = placeholder
        let (data, response) = try await session.data(from: url)
        try Task.checkCancellation()
        let failingURL = response.url ?? url
        if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
            let reason = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            throw URLError(
                .badServerResponse,
                userInfo: [NSURLErrorFailingURLErrorKey: failingURL, NSLocalizedFailureReasonErrorKey: reason])
        }
        guard let downloadedImage = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData, userInfo: [NSURLErrorFailingURLErrorKey: failingURL])
        }
        image = downloadedImage
    }
}
#endif
