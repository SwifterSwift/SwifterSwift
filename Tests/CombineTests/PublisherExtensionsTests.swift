//
//  PublisherExtensionsTests.swift
//  SwifterSwift
//
//  Created by Heecheon Park on 7/28/23.
//  Copyright © 2023 SwifterSwift
//

// swiftlint:disable identifier_name
// swiftlint:disable large_tuple

@testable import SwifterSwift
import XCTest

#if canImport(Combine)
import Combine

final class PublisherExtensionsTests: XCTestCase {

    func testCombineLatest() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            var result: [(Int, Int, Int, Int, Int)] = []

            let p1 = PassthroughSubject<Int, Never>()
            let p2 = PassthroughSubject<Int, Never>()
            let p3 = PassthroughSubject<Int, Never>()
            let p4 = PassthroughSubject<Int, Never>()
            let p5 = PassthroughSubject<Int, Never>()
            
            let cancellable = p1.combineLatest(p2, p3, p4, p5)
                .sink { result.append(($0, $1, $2, $3, $4)) }
            
            defer { cancellable.cancel() }
            
            p1.send(1)
            p2.send(2)
            p3.send(3)
            p4.send(4)
            
            XCTAssertTrue(result.isEmpty)
            
            p5.send(5)
            
            XCTAssertFalse(result.isEmpty)
            XCTAssert(result.allSatisfy({
                $0.0 == 1 &&
                $0.1 == 2 &&
                $0.2 == 3 &&
                $0.3 == 4 &&
                $0.4 == 5
            }))
            
            p1.send(11)
            p2.send(22)
            p5.send(55)
            
            XCTAssert(result.count == 4)
            XCTAssert(result[0] == (1, 2, 3, 4, 5))
            XCTAssert(result[1] == (11, 2, 3, 4, 5))
            XCTAssert(result[2] == (11, 22, 3, 4, 5))
            XCTAssert(result[3] == (11, 22, 3, 4, 55))
            
            p3.send(33)
            p4.send(44)
            XCTAssert(result.count == 6)
            XCTAssert(result[4] == (11, 22, 33, 4, 55))
            XCTAssert(result[5] == (11, 22, 33, 44, 55))
        }
    }
    
    func testCombineLatestTransform() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            
            var result: [(Int, Int, Int?, Bool, String)] = []

            let p1 = PassthroughSubject<Int, Never>()
            let p2 = PassthroughSubject<Int, Never>()
            let p3 = PassthroughSubject<Int?, Never>()
            let p4 = PassthroughSubject<Bool, Never>()
            let p5 = PassthroughSubject<Character, Never>()
            
            let cancellable = p1.combineLatest(p2, p3, p4, p5, { v1, v2, v3, v4, v5 in
                return (v1, v2 * v2, v3 == nil ? nil : 1, v4, "\(v5)\(v5)")
            })
            .map { ($0 * 2, $1, $2, $3, $4 ) }
            .sink { result.append(($0, $1, $2, $3, $4)) }
            
            defer { cancellable.cancel() }
            
            p1.send(1)
            p2.send(2)
            XCTAssertTrue(result.isEmpty)
            
            p3.send(nil)
            p4.send(false)
            p5.send("A")
            XCTAssertFalse(result.isEmpty)
            XCTAssert(result.allSatisfy({
                $0.0 == 2 &&
                $0.1 == 4 &&
                $0.2 == nil &&
                $0.3 == false &&
                $0.4 == "AA"
            }))
            
            p2.send(7)
            p2.send(4)
            p5.send("Z")
            p3.send(80)
            p4.send(true)
            
            XCTAssert(result.count == 6)
            XCTAssert(result[0] == (2, 4, nil, false, "AA"))
            XCTAssert(result[1] == (2, 49, nil, false, "AA"))
            XCTAssert(result[2] == (2, 16, nil, false, "AA"))
            XCTAssert(result[3] == (2, 16, nil, false, "ZZ"))
            XCTAssert(result[4] == (2, 16, 1, false, "ZZ"))
            XCTAssert(result[5] == (2, 16, 1, true, "ZZ"))
        }
    }
}
#endif

// swiftlint:enable large_tuple
// swiftlint:enable identifier_name
