// NSImageExtensionsTests.swift - Copyright 2024 SwifterSwift

#if os(macOS)

@testable import SwifterSwift
import XCTest

final class NSImageExtensionsTests: XCTestCase {
    func testScaledToMaxSize() {
        let bundle = Bundle(for: NSImageExtensionsTests.self)
        let image = bundle.image(forResource: NSImage.Name(stringLiteral: "TestImage"))
        XCTAssertNotNil(image)

        let scaledImage = image?.scaled(toMaxSize: NSSize(width: 150, height: 150))
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage?.size.width, 150)
        XCTAssertEqual(scaledImage?.size.height, 34)
    }
}

#endif
