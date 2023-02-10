// URLSessionExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Foundation) && canImport(FoundationNetworking)
import Foundation
import FoundationNetworking

// MARK: - Methods

public extension URLSession {
    /// SwifterSwift: synchronious version of `func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask`
    ///
    /// - Parameter request: A URL request object that provides the URL, cache policy, request type, body data or body stream, and so on.
    /// - Returns: The data returned by the server; An object that provides response metadata, such as HTTP headers and status code. If you are making an HTTP or HTTPS request, the returned object is actually an HTTPURLResponse object.
    func dataSync(with request: URLRequest) throws -> (Data, URLResponse) {
        var data: Data!
        var response: URLResponse!
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)
        dataTask(with: request) { receivedData, receivedResponse, recievedError in
            data = receivedData
            response = receivedResponse
            error = recievedError
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
