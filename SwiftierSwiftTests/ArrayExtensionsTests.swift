//
//  ArrayExtensionsTests.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/9/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift

class ArrayExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    func testRandomItem() {
        let randomItem = [1,2,3,4,5].randomItem
        XCTAssert(randomItem == 1 || randomItem == 2 || randomItem == 3 || randomItem == 4 || randomItem == 5, "Couldn't get correct value for \(#function)")
    }
    
    func testFirstIndex() {
        XCTAssert([1,1,2,3,1,2].firstIndex(of: 2) == 2, "Couldn't get correct value for \(#function)")
    }
    
    func testLastIndex() {
        XCTAssert([1,1,2,3,1,2].lastIndex(of: 1) == 4, "Couldn't get correct value for \(#function)")
    }
    
    func testShuffle() {
        let arr = [1,2,3]
        XCTAssert(arr.shuffled.contains(1) && arr.shuffled.contains(2) && arr.shuffled.contains(3) && arr.shuffled.count == arr.count, "Couldn't get correct value for \(#function)")
    }
    
    func testShuffled() {
        let arr = [1,2,3]
        var arr1 = arr
        arr1.shuffle()
        
        XCTAssert(arr1.contains(1) && arr1.contains(2) && arr1.contains(3) && arr1.count == arr.count, "Couldn't get correct value for \(#function)")
    }
    
    func testUniqueValues() {
        XCTAssert([1,2,3,1,2,4].uniqueValues == [1,2,3,4], "Couldn't get correct value for \(#function)")
    }
    
    func testRemoveDuplicates() {
        var arr = [1,2,3,1,2,4]
        arr.removeDuplicates()
        XCTAssert(arr == [1,2,3,4], "Couldn't get correct value for \(#function)")
    }
    
    func testIndexes() {
        XCTAssert([1,2,3,1,2,4].indexes(of: 1) == [0,3], "Couldn't get correct value for \(#function)")
    }
    
    func testRemoveAll() {
        var arr = [1,1,2,3,1,2,4]
        arr.removeAll(object: 1)
        
        XCTAssert(arr == [2,3,2,4], "Couldn't get correct value for \(#function)")
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
}
