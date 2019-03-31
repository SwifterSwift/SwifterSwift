//
//  UIScrollViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by camila oliveira on 22/04/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIScrollViewExtensionsTest: XCTestCase {
    func testSnapshot() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let scroll = UIScrollView(frame: frame)
        scroll.contentSize = frame.size
        let snapshot = scroll.snapshot
        XCTAssertNotNil(snapshot)
        let view = UIScrollView()
        XCTAssertNil(view.snapshot)
    }

}

#endif
