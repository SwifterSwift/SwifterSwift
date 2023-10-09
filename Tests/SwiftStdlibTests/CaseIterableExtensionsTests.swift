// CaseIterableExtensionsTests.swift - Copyright 2023 SwifterSwift

@testable import SwifterSwift
import XCTest

final class CaseIterableExtensionsTests: XCTestCase {
    
    private enum Test: CaseIterable {
        case test1, test2, test3
    }
    
    func testNextCase() {
        var value: Test = .test1
        value.toggle()
        
        XCTAssert(
            value == .test2,
            "value was not increased after running `toggle()`"
        )
    }
    
    func testWithLimit() {
        var value: Test = .test3
        value.toggle(cycle: false)
        
        XCTAssert(
            value == .test3,
            "value should not change after reaching last case when running `toggle(cycle: false)`"
        )
    }
    
    func testWithoutLimit() {
        var value: Test = .test3
        value.toggle(cycle: true)
        
        XCTAssert(
            value == .test1,
            "value should be changed to first case after reaching last case when running `toggle(cycle: true)`"
        )
    }
    
    func testAvailableCases() {
        var value: Test = .test1
        value.toggle(between: [.test1, .test3])
        XCTAssert(
            value == .test3,
            "value should be changed to next case from given cases array."
        )
    }
    
}
