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
    var url: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "photo_url"
    }
}
// swiftlint:enable identifier_name

final class DecodableExtensionsTests: XCTestCase {

    private var mockJsonData: Data {
        return #"{"id": 1, "name": "Şanlıurfa", "photo_url": "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg"}"#.data(using: .utf8)!
    }

    func testDecodeModel() {
        guard let city = City.init(from: mockJsonData) else {
            XCTAssert(false, "Could not parse model")
            return
        }
        XCTAssertEqual(city.id, 1)
        XCTAssertEqual(city.name, "Şanlıurfa")
        XCTAssertEqual(city.url, "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg")
    }
}
