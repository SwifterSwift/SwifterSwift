//
//  CodableExtensionsTests.swift
//  SwifterSwift
//
//  Created by Mustafa GUNES on 16.01.2020.
//  Copyright © 2020 SwifterSwift
//

import XCTest

@testable import SwifterSwift

private struct City: Codable {
    var cityId: Int
    var name: String
    var photoUrl: String

    private enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case name
        case photoUrl = "photo_url"
    }
}

final class CodableExtensionsTests: XCTestCase {

    private var mockJsonData: Data {
        return #"{"id": 1, "name": "Şanlıurfa", "photo_url": "https://cdn.pixabay.com/photo/2017/09/27/20/55/sanliurfa-2793424_1280.jpg"}"#.data(using: .utf8)!
    }

    func testDecodeModel() {
        do {
            let city = try City.decode(mockJsonData)
            XCTAssertEqual(city?.cityId, 1)
            XCTAssertEqual(city?.name, "Şanlıurfa")
        } catch {
            XCTAssert(false, "Could not parse model")
        }
    }
}
