// KeyedDecodingContainerExtensionsTests.swift - Copyright 2026 SwifterSwift

@testable import SwifterSwift
import XCTest

private struct Video: Decodable {
    let isPlaying: Bool
    let isFullScreen: Bool?

    private enum CodingKeys: CodingKey {
        case isPlaying
        case isFullScreen
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isPlaying = try container.decodeBoolAsIntOrString(forKey: .isPlaying)
        isFullScreen = try container.decodeBoolAsIntOrStringIfPresent(forKey: .isFullScreen)
    }
}

final class KeyedDecodingContainerTests: XCTestCase {
    func testDecodeBoolAsIntOrStringDataAsIntSuccessful() throws {
        let isPlayingAndIsFullScreenAsInt = #"{"isPlaying": 1, "isFullScreen": 0}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsInt)
        let video = try JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssert(video.isPlaying)
        XCTAssertEqual(video.isFullScreen, false)
    }

    func testDecodeBoolAsIntOrStringDataAsStringSuccessful() throws {
        let isPlayingAndIsFullScreenAsString = #"{"isPlaying": "true", "isFullScreen": "false"}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsString)
        let video = try JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssert(video.isPlaying)
        XCTAssertEqual(video.isFullScreen, false)
    }

    func testDecodeBoolAsIntOrStringDataAsBoolSuccessful() throws {
        let isPlayingAndIsFullScreenAsBool = #"{"isPlaying": true, "isFullScreen": false}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsBool)
        let video = try JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssert(video.isPlaying)
        XCTAssertEqual(video.isFullScreen, false)
    }

    func testDecodeBoolAsIntOrStringIfPresentSuccessful() throws {
        let isPlayingAsIntAndIsFullScreenNotPresent = #"{"isPlaying": 0}"#
        let data = mockJsonData(from: isPlayingAsIntAndIsFullScreenNotPresent)
        let video = try JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssertFalse(video.isPlaying)
        XCTAssertNil(video.isFullScreen)
    }

    func testDecodeBoolAsIntOrStringThrowsError() {
        let isPlayingAndIsFullScreenTypeMismatch = #"{"isPlaying": [1], "isFullScreen": ["true"]}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenTypeMismatch)
        XCTAssertThrowsError(try JSONDecoder().decode(Video.self, from: data))
    }

    private func mockJsonData(from json: String) -> Data {
        return Data(json.utf8)
    }
}
