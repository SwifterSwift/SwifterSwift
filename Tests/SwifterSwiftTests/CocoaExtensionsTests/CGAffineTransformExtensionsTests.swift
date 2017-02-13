//
//  CGAffineTransformExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/12/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class CGAffineTransformTests: XCTestCase {
    
    func testSubtracting() {
        
        let originalTransform = CGAffineTransform(a: 10.0, b: 20.0, c: 30.0, d: 40.0, tx: 50.0, ty: 60.0)
        let transformToAdd = CGAffineTransform(a: 20.0, b: 40.0, c: 60.0, d: 80.0, tx: 100.0, ty: 120.0)
        
        let roundTripTransform = originalTransform.concatenating(transformToAdd).subtracting(transform: transformToAdd)
        
        XCTAssertEqual(originalTransform, roundTripTransform)
        
        let originalTransform2 = CGAffineTransform(scaleX: 50.0, y: 10.0)
        let nonInvertable = CGAffineTransform(scaleX: 100.0, y: 20.0)
        
        let nonInvertedRoundTripTransform = originalTransform2.concatenating(nonInvertable).subtracting(transform: nonInvertable)
        
        XCTAssertEqual(originalTransform2, nonInvertedRoundTripTransform)
    }
}
