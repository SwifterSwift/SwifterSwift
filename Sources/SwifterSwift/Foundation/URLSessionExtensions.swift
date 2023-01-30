// URLSessionExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Foundation)
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// MARK: - Methods

public extension URLSession {
    /// SwifterSwift: synchronious version of `func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask`
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
