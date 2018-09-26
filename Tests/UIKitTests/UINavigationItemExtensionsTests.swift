//
//  UINavigationItemExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/16/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UINavigationItemExtensionsTests: XCTestCase {

    func testReplaceTitle() {
        let navigationItem = UINavigationItem()
        let image = UIImage()
        navigationItem.replaceTitle(with: image)

        let imageView = navigationItem.titleView as? UIImageView
        XCTAssertNotNil(imageView)

        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        XCTAssertEqual(imageView?.frame, frame)

        XCTAssertEqual(imageView?.contentMode, .scaleAspectFit)
        XCTAssertEqual(imageView?.image, image)
    }

}
#endif
