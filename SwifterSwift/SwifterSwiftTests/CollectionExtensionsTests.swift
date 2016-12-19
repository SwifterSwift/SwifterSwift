//
//  CollectionExtensionsTests.swift
//  SwifterSwift
//
//  Created by Sergey Fedortsov on 19.12.16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift
class CollectionExtensionsTests: XCTestCase {
    
    func testForEachInParallel() {
        var result = [Int]()
        
        let accessQueue = DispatchQueue(label: "access_queue")
        
        [1, 2, 3, 4, 5].forEachInParallel { element in
            accessQueue.sync {
                result.append(element * element)
            }
        }
        
        XCTAssertEqual(result.sorted(), [1, 4, 9, 16, 25])
    }
    
}
