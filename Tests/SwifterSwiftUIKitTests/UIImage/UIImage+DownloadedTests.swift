// UIImage+DownloadedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIImageDownloadedTests {
    @Test
    func downloadsAnImageFromAFileURL() async throws {
        let url = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "image.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let image = try await UIImage.downloaded(from: url)
        #expect(image.size == CGSize(width: 4, height: 2))
        #expect(image.scale == 1)
        #expect(image.cgImage?.width == 4)
    }

    @Test(
        arguments: zip(
            [CGFloat(1), 2, 4],
            [CGSize(width: 4, height: 2), CGSize(width: 2, height: 1), CGSize(width: 1, height: 0.5)]))
    func appliesTheScale(_ scale: CGFloat, expectedSize: CGSize) async throws {
        let url = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "image@2x.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let image = try await UIImage.downloaded(from: url, scale: scale)
        #expect(image.scale == scale)
        #expect(image.size == expectedSize)
    }

    @Test(arguments: [CGFloat(0), -1, -CGFloat.infinity, CGFloat.infinity, CGFloat.nan])
    func treatsAnInvalidScaleAsOne(_ scale: CGFloat) async throws {
        let url = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "image.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let image = try await UIImage.downloaded(from: url, scale: scale)
        #expect(image.scale == 1)
        #expect(image.size == CGSize(width: 4, height: 2))
    }

    @Test
    func decodesJPEGData() async throws {
        let jpeg = try #require(UIImage(data: makePNGData(width: 3, height: 5))?.jpegData(compressionQuality: 1))
        let url = try writeTemporaryFile(jpeg, named: "photo.jpg")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let image = try await UIImage.downloaded(from: url)
        #expect(image.size == CGSize(width: 3, height: 5))
    }

    @Test
    func decodesTheImageInADataURL() async throws {
        let base64 = try makePNGData(width: 2, height: 2).base64EncodedString()
        let url = try #require(URL(string: "data:image/png;base64," + base64))
        let image = try await UIImage.downloaded(from: url)
        #expect(image.size == CGSize(width: 2, height: 2))
    }

    @Test(arguments: [Data("Hello, SwifterSwift! 👋".utf8), Data(), Data([0x89, 0x50, 0x4E, 0x47])])
    func throwsCannotDecodeContentDataForDataThatIsNotAnImage(_ data: Data) async throws {
        let url = try writeTemporaryFile(data, named: "notes.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        let error = try await #require(throws: URLError.self) { try await UIImage.downloaded(from: url) }
        #expect(error.code == .cannotDecodeContentData)
        #expect(error.failingURL?.lastPathComponent == "notes.png")
    }

    @Test
    func rethrowsTheSessionErrorForAMissingFile() async throws {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathComponent("missing.png")
        let error = try await #require(throws: URLError.self) { try await UIImage.downloaded(from: url) }
        #expect(error.code == .fileDoesNotExist)
    }

    @Test(arguments: [200, 201, 203, 299])
    func acceptsSuccessfulHTTPStatusCodes(_ status: Int) async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let url = try makeStubURL(status: status, body: makePNGData(width: 4, height: 2))
        let image = try await UIImage.downloaded(from: url, session: session)
        #expect(image.size == CGSize(width: 4, height: 2))
    }

    @Test(arguments: [199, 300, 304, 400, 404, 500, 503])
    func throwsBadServerResponseForOtherHTTPStatusCodes(_ status: Int) async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let url = try makeStubURL(status: status, body: makePNGData(width: 4, height: 2))
        let error = try await #require(throws: URLError.self) {
            try await UIImage.downloaded(from: url, session: session)
        }
        #expect(error.code == .badServerResponse)
        #expect(error.failingURL == url)
        let reason = (error as NSError).localizedFailureReason
        #expect(reason == HTTPURLResponse.localizedString(forStatusCode: status))
    }

    @Test
    func checksTheDataRatherThanTheMIMEType() async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let png = try makeStubURL(
            status: 200, mimeType: "application/octet-stream", body: makePNGData(width: 4, height: 2))
        #expect(try await UIImage.downloaded(from: png, session: session).size == CGSize(width: 4, height: 2))

        let text = try makeStubURL(status: 200, mimeType: "image/png", body: Data("<html>Oops</html>".utf8))
        let error = try await #require(throws: URLError.self) {
            try await UIImage.downloaded(from: text, session: session)
        }
        #expect(error.code == .cannotDecodeContentData)
        #expect(error.failingURL == text)
    }

    @Test
    func throwsCannotDecodeContentDataForAnEmptyHTTPBody() async throws {
        let session = makeStubSession()
        defer { session.invalidateAndCancel() }
        let url = try makeStubURL(status: 204, body: Data())
        let error = try await #require(throws: URLError.self) {
            try await UIImage.downloaded(from: url, session: session)
        }
        #expect(error.code == .cannotDecodeContentData)
    }

    @Test @MainActor
    func throwsWhenTheTaskIsCancelled() async throws {
        let url = try writeTemporaryFile(makePNGData(width: 4, height: 2), named: "image.png")
        defer { try? FileManager.default.removeItem(at: url.deletingLastPathComponent()) }
        // The task can't start before the test suspends, so it's cancelled before it downloads anything.
        let task = Task { @MainActor in try await UIImage.downloaded(from: url) }
        task.cancel()
        #expect(isCancellation(await task.result))
    }

    /// Returns whether a result failed with `CancellationError` or `URLError(.cancelled)`.
    private func isCancellation(_ result: Result<UIImage, any Error>) -> Bool {
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

    /// Writes `data` to a file in a new temporary directory and returns the file's URL.
    private func writeTemporaryFile(_ data: Data, named name: String) throws -> URL {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent(name)
        try data.write(to: url)
        return url
    }

    /// Returns a session that answers every request with `DownloadedStubURLProtocol`, never the network.
    private func makeStubSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [DownloadedStubURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    /// Returns a URL that `DownloadedStubURLProtocol` answers with the given status code, MIME type and body.
    private func makeStubURL(status: Int, mimeType: String = "image/png", body: Data) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "images.example.com"
        components.path = "/photo.png"
        components.queryItems = [
            URLQueryItem(name: "status", value: String(status)),
            URLQueryItem(name: "type", value: mimeType),
            URLQueryItem(name: "body", value: body.base64EncodedString())
        ]
        return try #require(components.url)
    }
}

/// Answers every request with the HTTP status code, MIME type and Base64-encoded body in its URL's query, so the
/// tests never use the network.
private final class DownloadedStubURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool { true }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        let items = request.url.flatMap { URLComponents(url: $0, resolvingAgainstBaseURL: false)?.queryItems } ?? []
        let value = { (name: String) in items.first { $0.name == name }?.value }
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
