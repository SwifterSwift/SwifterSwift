// URLRequestExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Foundation)
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// MARK: - Initializers

public extension URLRequest {
    /// SwifterSwift: Create URLRequest from URL string.
    ///
    /// - Parameter urlString: URL string to initialize URL request from
    init?(urlString: String) {
        guard let url = URL(string: urlString) else { return nil }
        self.init(url: url)
    }

    /// SwifterSwift: cURL command representation of this URL request.
    var curlString: String {
        guard let url = url else { return "" }

        var baseCommand = "curl \(url.absoluteString)"
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]
        if let method = httpMethod, method != "GET", method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody,
           let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }
}

// MARK: - Methods

public extension URLRequest {
    /// SwifterSwift: Duplicates the request and modifies the HTTP method (verb) for the request (i.e.: GET, POST, PUT)
    ///
    ///     let request = URLRequest(url: url)
    ///         .method("post")
    ///
    /// - Parameter methodString: The method as a String value
    /// - Returns: The modified request
    func method(_ methodString: String) -> Self {
        var request = self
        request.httpMethod = methodString.uppercased()
        return request
    }

    /// SwifterSwift: Duplicates the request and set a header with key and value
    ///
    ///     let request = URLRequest(url: url)
    ///         .header(name: "Content-Type", value: "application/json")
    ///
    /// - Parameters:
    ///   - name: The name of the header
    ///   - value: The value of the header
    /// - Returns: The modified request
    func header(name: String, value: String) -> Self {
        var request = self
        request.setValue(value, forHTTPHeaderField: name)
        return request
    }
}

#endif
