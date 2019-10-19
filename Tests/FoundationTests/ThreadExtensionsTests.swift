//
//  ThreadExtensionsTests.swift
//  SwifterSwift
//
//  Created by Francesco Deliro on 18/10/2019.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class ThreadExtensionsTests: XCTestCase {

    private enum TestError: Error {
        case error
    }

    typealias StringCompletion = (Result<String, Error>) -> Void

    func testMainThreadCompletionSuccessful() {
        let completion: StringCompletion = { result in
            switch result {
            case .success(let text):
                XCTAssertTrue(text.isEmpty)
                XCTAssertTrue(Thread.isMainThread)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        DispatchQueue.global(qos: .background).async {
            Thread.mainThreadCompletion(completion, result: .success(""))
        }
    }

    func testMainThreadCompletionFailure() {
        let completion: StringCompletion = { result in
            switch result {
            case .success:
                XCTFail("result should fail")
            case .failure(let error):
                XCTAssertTrue(error is TestError)
                XCTAssertTrue(Thread.isMainThread)
            }
        }

        DispatchQueue.global(qos: .background).async {
            Thread.mainThreadCompletion(completion, result: .failure(TestError.error))
        }
    }

}

#endif
