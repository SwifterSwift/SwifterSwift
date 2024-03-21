// SCNSphereExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SceneKit)
import SceneKit

final class SCNSphereExtensionsTests: XCTestCase {
    func testInitWithDiameter() {
        let sphere = SCNSphere(diameter: 10)
        XCTAssertEqual(sphere.boundingSize, SCNVector3(10, 10, 10))
    }

    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let sphere = SCNSphere(radius: 5, material: material)
        XCTAssertEqual(sphere.materials, [material])
    }

    func testInitWithColor() {
        let color = SFColor.red
        let sphere = SCNSphere(radius: 5, color: color)
        XCTAssertEqual(sphere.materials[0].diffuse.contents as? SFColor, color)
    }

    func testInitWithDiameterAndMaterial() {
        let material = SCNMaterial(color: .red)
        let sphere = SCNSphere(diameter: 10, material: material)
        XCTAssertEqual(sphere.boundingSize, SCNVector3(10, 10, 10))
        XCTAssertEqual(sphere.materials, [material])
    }

    func testInitWithDiameterAndColor() {
        let color = SFColor.red
        let sphere = SCNSphere(diameter: 10, color: color)
        XCTAssertEqual(sphere.boundingSize, SCNVector3(10, 10, 10))
        XCTAssertEqual(sphere.materials[0].diffuse.contents as? SFColor, color)
    }
}

#endif
