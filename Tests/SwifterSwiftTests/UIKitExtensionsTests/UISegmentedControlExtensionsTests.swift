//
//  UISegmentedControlExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/15/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)

import XCTest
@testable import SwifterSwift

class UISegmentedControlExtensionsTests: XCTestCase {

    func testSegmentTitles() {
        let segmentControl = UISegmentedControl()
        XCTAssert(segmentControl.segmentTitles.isEmpty)
        let titles = ["Title1", "Title2"]
        segmentControl.segmentTitles = titles
        XCTAssertEqual(segmentControl.segmentTitles, titles)
    }
    
    func testSegmentImages() {
        let segmentControl = UISegmentedControl()
        XCTAssert(segmentControl.segmentImages.isEmpty)
        let images = [UIImage(), UIImage()]
        segmentControl.segmentImages = images
        XCTAssertEqual(segmentControl.segmentImages, images)
    }
}
#endif
