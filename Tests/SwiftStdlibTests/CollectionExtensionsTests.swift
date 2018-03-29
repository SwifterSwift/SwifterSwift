//
//  CollectionExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class CollectionExtensionsTests: XCTestCase {
	
	func testForEachInParallel() {
		let collection = [1, 2, 3, 4, 5]
		collection.forEachInParallel { item in
			XCTAssert(collection.contains(item))
		}
	}
	
    func testGroupBy() {
        let collection = [Pair(1, "Hello"), Pair(2, "Hello"), Pair(3, "Hello"), Pair(4, "World"), Pair(5, "Dev"), Pair(6, "Dev")]
        XCTAssertEqual(collection.group(by: \Pair.str), [
                "Hello": [Pair(1, "Hello"), Pair(2, "Hello"), Pair(3, "Hello")],
                "World": [Pair(4, "World")],
                "Dev": [Pair(5, "Dev"), Pair(6, "Dev")]
            ])
        
    }
    
	func testSafeSubscript() {
		let collection = [1, 2, 3, 4, 5]
		XCTAssertNotNil(collection[safe: 2])
		XCTAssertEqual(collection[safe: 2], 3)
		XCTAssertNil(collection[safe: 10])
	}
	
    func testRandomItem() {
        XCTAssertNotNil([1, 2, 3].randomItem)
        XCTAssert([1, 2, 3].contains([1, 2, 3].randomItem!))
        XCTAssertNil([].randomItem)
    }
}

struct Pair: Equatable {
    let num: Int
    let str: String
    
    init(_ num: Int, _ str: String) {
        self.num = num
        self.str = str
    }
}
