// UISegmentedControlExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UISegmentedControlExtensionsTests: XCTestCase {
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
