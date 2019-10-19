//
//  ThreadExtensions.swift
//  SwifterSwift
//
//  Created by Francesco Deliro on 18/10/2019.
//  Copyright © 2019 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Methods
public extension Thread {

    /// SwifterSwift: Execute a completion block on the main thread.
    ///
    /// - Parameter completion: The completion to execute.
    /// - Parameter result: The result of the completion.
    static func mainThreadCompletion<T>(
        _ completion: @escaping (Result<T, Error>) -> Void,
        result: Result<T, Error>
    ) {
        if isMainThread {
            completion(result)
        } else {
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

}

#endif
