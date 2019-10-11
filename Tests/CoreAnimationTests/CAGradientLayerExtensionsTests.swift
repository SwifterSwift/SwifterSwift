//
//  CAGradientLayerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Jay Mehta on 11/10/19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if !os(watchOS)

final class CAGradientLayerExtensionsTests: XCTestCase {

    func testInitWithGradientAttributes() {
        let gradientLayer = CAGradientLayer(colors: [.red, .blue, .orange, .yellow], locations: nil, startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5), type: .axial)

        XCTAssertEqual(gradientLayer.startPoint, CGPoint(x: 0.0, y: 0.5))
        XCTAssertEqual(gradientLayer.colors?.count, 4)
    }

}

#endif
