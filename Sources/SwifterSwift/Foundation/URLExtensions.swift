//
//  URLExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation)
import Foundation

#if canImport(UIKit) && canImport(AVFoundation)
import UIKit
import AVFoundation
#endif

// MARK: - Properties
public extension URL {

    /// SwifterSwift: Dictionary of the URL's query parameters
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }

        var items: [String: String] = [:]

        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }

        return items
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
	/// - Parameter replaceExisting: whether replace existing query parameters or not.
    /// - Returns: URL with appending given query parameters.
    func appendingQueryParameters(_ parameters: [String: String], replaceExisting: Bool = false) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        if replaceExisting {
            var queryItems = urlComponents.queryItems ?? []
            for param in parameters {
                if let index = queryItems.firstIndex(where: { $0.name == param.key }) {
                    queryItems[index] = URLQueryItem(name: param.key, value: param.value)
                } else {
                    queryItems.append(URLQueryItem(name: param.key, value: param.value))
                }
            }
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
                .map { URLQueryItem(name: $0, value: $1) }
        }
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
	/// - Parameter replaceExisting: whether replace existing query parameters or not.
    mutating func appendQueryParameters(_ parameters: [String: String], replaceExisting: Bool = false) {
        self = appendingQueryParameters(parameters, replaceExisting: replaceExisting)
    }

    /// SwifterSwift: Get value of a query key.
    ///
    ///    var url = URL(string: "https://google.com?code=12345")!
    ///    queryValue(for: "code") -> "12345"
    ///
    /// - Parameter key: The key of a query value.
    func queryValue(for key: String) -> String? {
        return URLComponents(string: absoluteString)?
            .queryItems?
            .first(where: { $0.name == key })?
            .value
    }

    /// SwifterSwift: Returns a new URL by removing all the path components.
    ///
    ///     let url = URL(string: "https://domain.com/path/other")!
    ///     print(url.deletingAllPathComponents()) // prints "https://domain.com/"
    ///
    /// - Returns: URL with all path components removed.
    func deletingAllPathComponents() -> URL {
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
        for _ in 0..<pathComponents.count - 1 {
            deleteLastPathComponent()
        }
    }

	/// SwifterSwift: Returns a new URL by removing all the query parameters.
    ///
    ///     let url = URL(string: "https://domain.com?query=true")!
    ///     print(url.deletingAllQueryParameters()) // prints "https://domain.com"
    ///
    /// - Returns: URL with all query parameters removed.
    func deletingAllQueryParameters() -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = nil
        return urlComponents.url!
    }
    
	/// SwifterSwift: Remove all the query parameters from the URL.
	///
	///     var url = URL(string: "https://domain.com?query=true")!
	///     url.deleteAllQueryParameters()
	///     print(url) // prints "https://domain.com"
    mutating func deleteAllQueryParameters() {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = nil
        self = urlComponents.url!
    }
	
    /// SwifterSwift: Generates new URL that does not have scheme.
    ///
    ///        let url = URL(string: "https://domain.com")!
    ///        print(url.droppedScheme()) // prints "domain.com"
    func droppedScheme() -> URL? {
        if let scheme = scheme {
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
    /// SwifterSwift: Generate a thumbnail image from given url. Returns nil if no thumbnail could be created. This function may take some time to complete. It's recommended to dispatch the call if the thumbnail is not generated from a local resource.
    ///
    ///     var url = URL(string: "https://video.golem.de/files/1/1/20637/wrkw0718-sd.mp4")!
    ///     var thumbnail = url.thumbnail()
    ///     thumbnail = url.thumbnail(fromTime: 5)
    ///
    ///     DisptachQueue.main.async {
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
