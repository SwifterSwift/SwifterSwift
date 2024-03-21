// SCNBoxExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SceneKit)
import SceneKit

final class SCNBoxExtensionsTests: XCTestCase {
    func testInitWithoutChamferRadius() {
        let box = SCNBox(width: 1, height: 2, length: 3)
        XCTAssertEqual(box.boundingSize, SCNVector3(1, 2, 3))
    }

    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let box = SCNBox(width: 1, height: 2, length: 3, chamferRadius: 0, material: material)
        XCTAssertEqual(box.materials, [material])
    }

    func testInitWithColor() {
        let color = SFColor.red
        let box = SCNBox(width: 1, height: 2, length: 3, chamferRadius: 0, color: color)
        XCTAssertEqual(box.materials[0].diffuse.contents as? SFColor, color)
    }

    func testInitWithSideLength() {
        let box = SCNBox(sideLength: 1)
        XCTAssertEqual(box.boundingSize, SCNVector3(1, 1, 1))
    }

    func testInitWithSideLengthAndMaterial() {
        let material = SCNMaterial(color: .red)
        let box = SCNBox(sideLength: 1, chamferRadius: 0, material: material)
        XCTAssertEqual(box.boundingSize, SCNVector3(1, 1, 1))
        XCTAssertEqual(box.materials, [material])
    }

    func testInitWithSideLengthAndColor() {
        let color = SFColor.red
        let box = SCNBox(sideLength: 1, chamferRadius: 0, color: color)
        XCTAssertEqual(box.boundingSize, SCNVector3(1, 1, 1))
        XCTAssertEqual(box.materials[0].diffuse.contents as? SFColor, color)
    }
}

#endif
