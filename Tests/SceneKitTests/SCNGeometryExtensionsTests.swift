// SCNGeometryExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SceneKit)
import SceneKit

final class SCNGeometryExtensionsTests: XCTestCase {
    func testBoundingSize() {
        let box = SCNBox(width: 10, height: 20, length: 30, chamferRadius: 0)
        XCTAssertEqual(box.boundingSize, SCNVector3(10, 20, 30))
    }
}

#endif
