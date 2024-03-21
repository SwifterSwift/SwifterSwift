// SCNShapeExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SceneKit)
import SceneKit

#if canImport(UIKit)
import UIKit
#endif

final class SCNShapeExtensionsTests: XCTestCase {
    let rect = CGRect(x: 0, y: 0, width: 10, height: 10)

    #if canImport(UIKit)
    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let shape = SCNShape(path: UIBezierPath(rect: rect), extrusionDepth: 1, material: material)
        XCTAssertEqual(shape.materials, [material])
    }

    func testInitWithColor() {
        let color = UIColor.red
        let shape = SCNShape(path: UIBezierPath(rect: rect), extrusionDepth: 1, color: color)
        XCTAssertEqual(shape.materials[0].diffuse.contents as? SFColor, color)
    }
    #endif
}

#endif
