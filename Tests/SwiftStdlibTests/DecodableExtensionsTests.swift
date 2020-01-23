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
    var location: CityLocation
    var url: String
}

private struct CityLocation: Decodable {
    var latitude: Double
    var longitude: Double
}
// swiftlint:enable identifier_name

final class DecodableExtensionsTests: XCTestCase {

    private var mockJsonData: Data {
        return #"{"id": 1, "name": "Şanlıurfa", "url": "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg", "location": { "latitude": 36.9751, "longitude": 38.4243 }}"#.data(using: .utf8)!
    }

    private var invalidMockJsonData: Data {
         #"{"id": "1", "name": "Şanlıurfa", "url": "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg", "location": { "latitude": "36.9751", "longitude": "38.4243" }}"#.data(using: .utf8)!
    }

    func testDecodeModel() {
        guard let city = City.init(from: mockJsonData) else {
            XCTAssert(false, "Could not parse model")
            return
        }

        XCTAssertEqual(city.id, 1)
        XCTAssertEqual(city.name, "Şanlıurfa")
        XCTAssertEqual(city.location.latitude, 36.9751)
        XCTAssertEqual(city.location.longitude, 38.4243)
        XCTAssertEqual(city.url, "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg")
    }

    func testDecodeModelInvalidData() {
        XCTAssertNil(City.init(from: invalidMockJsonData))
    }
}
