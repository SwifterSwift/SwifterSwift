// NSUbiquitousKeyValueStoreTest.swift - Copyright 2020 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

final class NSUbiquitousKeyValueStoreTest: XCTestCase {

    func testURL() {
        #if !os(Linux) && !os(watchOS)
        let key = "urlTestKey"
        let url = URL(string: "https://www.github.com")
        NSUbiquitousKeyValueStore.default.set(url?.absoluteString, forKey: key)
        NSUbiquitousKeyValueStore.default.synchronize()
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default.url(forKey: key))
        XCTAssertEqual( NSUbiquitousKeyValueStore.default.url(forKey: key)!, url)
        #endif
    }
}

#endif
