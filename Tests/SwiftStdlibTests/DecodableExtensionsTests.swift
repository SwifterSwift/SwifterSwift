//
//  DecodableExtensionsTests.swift
//  SwifterSwift
//
//  Created by Mustafa GUNES on 16.01.2020.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

// swiftlint:disable identifier_name
private struct City: Decodable {
    var id: Int
    var name: String
    var url: URL
}
// swiftlint:enable identifier_name

final class DecodableExtensionsTests: XCTestCase {

    private var mockJsonData: Data {
        return #"{"id": 1, "name": "Şanlıurfa", "url": "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg"}"#.data(using: .utf8)!
    }

    private var invalidMockJsonData: Data {
       return #"{"id": "1", "name": "Şanlıurfa", "url": "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg"}"#.data(using: .utf8)!
    }

    func testDecodeModel() {
        guard let city = City(from: mockJsonData) else {
            XCTAssert(false, "Could not parse model")
            return
        }

        XCTAssertEqual(city.id, 1)
        XCTAssertEqual(city.name, "Şanlıurfa")
        XCTAssertEqual(city.url, URL(string: "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg"))
    }

    func testDecodeModelInvalidData() {
        XCTAssertNil(City(from: invalidMockJsonData))
    }
}
