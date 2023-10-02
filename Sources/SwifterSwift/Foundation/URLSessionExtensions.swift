// URLSessionExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Foundation)
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// MARK: - Methods

public extension URLSession {
    /// SwifterSwift: synchronous version of `dataTask(with:completionHandler:)`
    ///
    /// - Parameter request: A URL request object that provides the URL, cache policy, request type, body data or body
    /// stream, and so on.
    /// - Returns: The data returned by the server; An object that provides response metadata, such as HTTP headers and
    /// status code.
    func dataSync(with request: URLRequest) throws -> (Data, URLResponse) {
        var data: Data!
        var response: URLResponse!
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)
        dataTask(with: request) { receivedData, receivedResponse, receivedError in
            data = receivedData
            response = receivedResponse
            error = receivedError
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        if let error = error {
            throw error
        }
        return (data, response)
    }
}

#endif
