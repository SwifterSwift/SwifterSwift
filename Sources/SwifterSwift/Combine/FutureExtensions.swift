// FutureExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Combine)
import Combine

// MARK: - Methods

@available(iOS 13.00, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Future where Failure == Error {
    #if !os(Linux) && swift(>=5.5) && canImport(_Concurrency)
    /// Creates a `Future` from an `async` function
    /// - Parameter asyncFunc: The asynchronous function to execute.
    convenience init(asyncFunc: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let result = try await asyncFunc()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
    #endif
}

@available(iOS 13.00, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Future where Failure == Never {
    #if !os(Linux) && swift(>=5.5) && canImport(_Concurrency)
    /// Create a `Future` from an `async` throwing function
    /// - Parameter asyncFunc: `async` throwing function
    convenience init(asyncFunc: @escaping () async -> Output) {
        self.init { promise in
            Task {
                let result = await asyncFunc()
                promise(.success(result))
            }
        }
    }
    #endif
}

#endif
