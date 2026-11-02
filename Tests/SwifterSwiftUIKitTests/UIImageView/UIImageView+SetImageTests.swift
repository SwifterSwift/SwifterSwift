// UIImageView+SetImageTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIImageViewSetImageTests {
    @Test
    func showsTheDownloadedImage() async throws {
        let url = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "image.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let imageView = UIImageView()
        try await imageView.setImage(from: url, placeholder: makeImage(width: 1, height: 1))
        let image = try #require(imageView.image)
        #expect(image.size == CGSize(width: 4, height: 2))
        #expect(image.scale == 1)
    }

    @Test
    func keepsTheContentMode() async throws {
        let url = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "image.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        try await imageView.setImage(from: url)
        #expect(imageView.contentMode == .scaleAspectFill)
        #expect(imageView.image?.size == CGSize(width: 4, height: 2))
    }

    @Test
    func showsThePlaceholderWhileTheImageDownloads() async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let url = try makeStubURL(status: 200, body: Data(), hangs: true)
        let placeholder = try makeImage(width: 1, height: 1)
        let imageView = UIImageView(image: try makeImage(width: 2, height: 2))
        let task = Task { @MainActor in
            try await imageView.setImage(from: url, placeholder: placeholder, session: session)
        }
        var attempts = 0
        while imageView.image !== placeholder, attempts < 1_000 {
            await Task.yield()
            attempts += 1
        }
        #expect(imageView.image === placeholder)
        task.cancel()
        #expect(isCancellation(await task.result))
        #expect(imageView.image === placeholder)
    }

    @Test
    func keepsThePlaceholderWhenTheDownloadFails() async throws {
        let url = try writeTemporaryFile(Data("Not an image".utf8), named: "image.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let placeholder = try makeImage(width: 1, height: 1)
        let imageView = UIImageView(image: try makeImage(width: 2, height: 2))
        let error = try await #require(throws: URLError.self) {
            try await imageView.setImage(from: url, placeholder: placeholder)
        }
        #expect(error.code == .cannotDecodeContentData)
        #expect(error.failingURL?.lastPathComponent == "image.png")
        #expect(imageView.image === placeholder)
    }

    @Test
    func clearsTheImageWithoutAPlaceholder() async throws {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathComponent("missing.png")
        let imageView = UIImageView(image: try makeImage(width: 2, height: 2))
        let error = try await #require(throws: URLError.self) { try await imageView.setImage(from: url) }
        #expect(error.code == .fileDoesNotExist)
        #expect(imageView.image == nil)
    }

    @Test(arguments: [200, 201, 299])
    func acceptsSuccessfulHTTPStatusCodes(_ status: Int) async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let url = try makeStubURL(status: status, body: makePNGData(width: 4, height: 2))
        let imageView = UIImageView()
        try await imageView.setImage(from: url, session: session)
        #expect(imageView.image?.size == CGSize(width: 4, height: 2))
    }

    @Test(arguments: [199, 300, 304, 404, 500])
    func throwsBadServerResponseForOtherHTTPStatusCodes(_ status: Int) async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let url = try makeStubURL(status: status, body: makePNGData(width: 4, height: 2))
        let placeholder = try makeImage(width: 1, height: 1)
        let imageView = UIImageView()
        let error = try await #require(throws: URLError.self) {
            try await imageView.setImage(from: url, placeholder: placeholder, session: session)
        }
        #expect(error.code == .badServerResponse)
        #expect(error.failingURL == url)
        #expect((error as NSError).localizedFailureReason == HTTPURLResponse.localizedString(forStatusCode: status))
        #expect(imageView.image === placeholder)
    }

    @Test
    func checksTheDataRatherThanTheMIMEType() async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let imageView = UIImageView()
        let png = try makeStubURL(
            status: 200, mimeType: "application/octet-stream", body: makePNGData(width: 4, height: 2))
        try await imageView.setImage(from: png, session: session)
        #expect(imageView.image?.size == CGSize(width: 4, height: 2))

        let html = try makeStubURL(status: 200, mimeType: "image/png", body: Data("<html>Oops</html>".utf8))
        let error = try await #require(throws: URLError.self) {
            try await imageView.setImage(from: html, session: session)
        }
        #expect(error.code == .cannotDecodeContentData)
        #expect(imageView.image == nil)
    }

    @Test
    func doesNotSetTheImageOnceTheTaskIsCancelled() async throws {
        let url = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "image.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let placeholder = try makeImage(width: 1, height: 1)
        let imageView = UIImageView()
        // The task can't start before the test suspends, so it's cancelled before it downloads anything.
        let task = Task { @MainActor in try await imageView.setImage(from: url, placeholder: placeholder) }
        task.cancel()
        #expect(isCancellation(await task.result))
        #expect(imageView.image === placeholder)
    }

    @Test
    func showsTheImageOfTheLastTaskThatWasNotCancelled() async throws {
        let first = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "first.png")
        let second = try writeTemporaryFile(makePNGData(width: 3, height: 3), named: "second.png")
        defer {
            try? FileManager.default.removeItem(at: first.deletingLastPathComponent())
            try? FileManager.default.removeItem(at: second.deletingLastPathComponent())
        }
        let imageView = UIImageView()
        let stale = Task { @MainActor in try await imageView.setImage(from: first) }
        stale.cancel()
        let current = Task { @MainActor in try await imageView.setImage(from: second) }
        _ = await stale.result
        try await current.value
        #expect(imageView.image?.size == CGSize(width: 3, height: 3))
    }

    /// Returns whether a result failed with `CancellationError` or `URLError(.cancelled)`.
    private func isCancellation(_ result: Result<Void, any Error>) -> Bool {
        guard case .failure(let error) = result else { return false }
        return error is CancellationError || (error as? URLError)?.code == .cancelled
    }

    /// Returns PNG data for an opaque red image of the given size, in pixels.
    private func makePNGData(width: Int, height: Int) throws -> Data {
        let colorSpace = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let context = try #require(
            CGContext(
                data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.setFillColor(CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1))
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        let cgImage = try #require(context.makeImage())
        return try #require(UIImage(cgImage: cgImage).pngData())
    }

    /// Returns an image of the given size, in pixels, decoded from PNG data. Images of different sizes are never equal,
    /// which matters because `UIImageView` ignores an image that's equal to the one it shows.
    private func makeImage(width: Int, height: Int) throws -> UIImage {
        try #require(UIImage(data: makePNGData(width: width, height: height)))
    }

    /// Writes `data` to a file in a new temporary directory and returns the file's URL.
    private func writeTemporaryFile(_ data: Data, named name: String) throws -> URL {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent(name)
        try data.write(to: url)
        return url
    }

    /// Returns a session that answers every request with `SetImageStubURLProtocol`, never the network.
    private func makeStubSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [SetImageStubURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    /// Returns a URL that `SetImageStubURLProtocol` answers with the given status code, MIME type and body, or never
    /// answers if `hangs` is `true`.
    private func makeStubURL(status: Int, mimeType: String = "image/png", body: Data, hangs: Bool = false) throws
        -> URL
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "images.example.com"
        components.path = "/photo.png"
        components.queryItems = [
            URLQueryItem(name: "status", value: String(status)),
            URLQueryItem(name: "type", value: mimeType),
            URLQueryItem(name: "body", value: body.base64EncodedString()),
            URLQueryItem(name: "hangs", value: hangs ? "1" : "0")
        ]
        return try #require(components.url)
    }
}

/// Answers every request with the HTTP status code, MIME type and Base64-encoded body in its URL's query, or never
/// answers when the query has `hangs=1`, so the tests never use the network.
private final class SetImageStubURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool { true }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        let items = request.url.flatMap { URLComponents(url: $0, resolvingAgainstBaseURL: false)?.queryItems } ?? []
        let value = { (name: String) in items.first { $0.name == name }?.value }
        guard value("hangs") != "1" else { return }
        guard let url = request.url, let status = value("status").flatMap({ Int($0) }),
            let body = value("body").flatMap({ Data(base64Encoded: $0) }),
            let response = HTTPURLResponse(
                url: url, statusCode: status, httpVersion: "HTTP/1.1",
                headerFields: ["Content-Type": value("type") ?? "image/png"])
        else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: body)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
#endif
