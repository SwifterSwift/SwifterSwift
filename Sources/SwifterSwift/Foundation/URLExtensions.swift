// URLExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(Foundation)
import Foundation

#if canImport(UIKit) && canImport(AVFoundation)
import AVFoundation
import UIKit
#endif

// MARK: - Properties

public extension URL {
    /// SwifterSwift: Dictionary of the URL's query parameters that have values.
    ///
    /// Duplicated query keys are ignored, taking only the first instance.
    var queryParameters: [String: String]? {
        guard let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
            return nil
        }

        return Dictionary(queryItems.lazy.compactMap {
            guard let value = $0.value else { return nil }
            return ($0.name, value)
        }) { first, _ in first }
    }

    /// SwifterSwift: Array of the URL's query parameters.
    var allQueryParameters: [URLQueryItem]? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems
    }
}

// MARK: - Initializers

public extension URL {
    /// SwifterSwift: Initializes an `URL` object with a base URL and a relative string. If `string` was malformed,
    /// returns `nil`.
    /// - Parameters:
    ///   - string: The URL string with which to initialize the `URL` object. Must conform to RFC 2396. `string` is
    /// interpreted relative to `url`.
    ///   - url: The base URL for the `URL` object.
    init?(string: String?, relativeTo url: URL? = nil) {
        guard let string else { return nil }
        self.init(string: string, relativeTo: url)
    }

    /**
     SwifterSwift: Initializes a forced unwrapped `URL` from string. Can potentially crash if string is invalid.
      - Parameter unsafeString: The URL string used to initialize the `URL`object.
      */
    init(unsafeString: String) {
        self.init(string: unsafeString)!
    }
}

// MARK: - Methods

public extension URL {
    /// SwifterSwift: URL with appending query parameters.
    ///
    ///		let url = URL(string: "https://google.com")!
    ///		let param = ["q": "Swifter Swift"]
    ///		url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    /// - Returns: URL with appending given query parameters.
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
            .map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url!
    }

    /// SwifterSwift: URL with appending query parameters.
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = [URLQueryItem(name: "q", value: "Swifter Swift")]
    ///        url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    /// - Returns: URL with appending given query parameters.
    func appendingQueryParameters(_ parameters: [URLQueryItem]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
        return urlComponents.url!
    }

    /// SwifterSwift: Append query parameters to URL.
    ///
    ///		var url = URL(string: "https://google.com")!
    ///		let param = ["q": "Swifter Swift"]
    ///		url.appendQueryParameters(params)
    ///		print(url) // prints "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    mutating func appendQueryParameters(_ parameters: [String: String]) {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
            .map { URLQueryItem(name: $0, value: $1) }
        self = urlComponents.url!
    }

    /// SwifterSwift: Append query parameters to URL.
    ///
    ///        var url = URL(string: "https://google.com")!
    ///        let param = [URLQueryItem(name: "q", value: "Swifter Swift")]
    ///        url.appendQueryParameters(params)
    ///        print(url) // prints "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    mutating func appendQueryParameters(_ parameters: [URLQueryItem]) {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
        self = urlComponents.url!
    }

    /// SwifterSwift: Get value of a query key.
    ///
    ///    var url = URL(string: "https://google.com?code=12345")!
    ///    queryValue(for: "code") -> "12345"
    ///
    /// - Parameter key: The key of a query value.
    func queryValue(for key: String) -> String? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == key }?
            .value
    }

    /// SwifterSwift: Returns a new URL by removing all the path components.
    ///
    ///     let url = URL(string: "https://domain.com/path/other")!
    ///     print(url.deletingAllPathComponents()) // prints "https://domain.com/"
    ///
    /// - Returns: URL with all path components removed.
    func deletingAllPathComponents() -> URL {
        guard !pathComponents.isEmpty else { return self }

        var url: URL = self
        for _ in 0..<pathComponents.count - 1 {
            url.deleteLastPathComponent()
        }
        return url
    }

    /// SwifterSwift: Remove all the path components from the URL.
    ///
    ///        var url = URL(string: "https://domain.com/path/other")!
    ///        url.deleteAllPathComponents()
    ///        print(url) // prints "https://domain.com/"
    mutating func deleteAllPathComponents() {
        guard !pathComponents.isEmpty else { return }

        for _ in 0..<pathComponents.count - 1 {
            deleteLastPathComponent()
        }
    }

    /// SwifterSwift: Generates new URL that does not have scheme.
    ///
    ///        let url = URL(string: "https://domain.com")!
    ///        print(url.droppedScheme()) // prints "domain.com"
    func droppedScheme() -> URL? {
        if let scheme {
            let droppedScheme = String(absoluteString.dropFirst(scheme.count + 3))
            return URL(string: droppedScheme)
        }

        guard host != nil else { return self }

        let droppedScheme = String(absoluteString.dropFirst(2))
        return URL(string: droppedScheme)
    }
}

// MARK: - Methods

public extension URL {
    #if os(iOS) || os(tvOS)
    /// SwifterSwift: Generate a thumbnail image from given url. Returns nil if no thumbnail could be created. This
    /// function may take some time to complete. It's recommended to dispatch the call if the thumbnail is not generated
    /// from a local resource.
    ///
    ///     var url = URL(string: "https://video.golem.de/files/1/1/20637/wrkw0718-sd.mp4")!
    ///     var thumbnail = url.thumbnail()
    ///     thumbnail = url.thumbnail(fromTime: 5)
    ///
    ///     DispatchQueue.main.async {
    ///         someImageView.image = url.thumbnail()
    ///     }
    ///
    /// - Parameter time: Seconds into the video where the image should be generated.
    /// - Returns: The UIImage result of the AVAssetImageGenerator
    func thumbnail(fromTime time: Float64 = 0) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: AVAsset(url: self))
        let time = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
        var actualTime = CMTimeMake(value: 0, timescale: 0)

        guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
    #endif
}

#endif
