//
//  URLExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class URLExtensionsTests: XCTestCase {

	var url = URL(string: "https://www.google.com")!
	let params = ["q": "swifter swift"]
	let queryUrl = URL(string: "https://www.google.com?q=swifter%20swift")!

    func testInitWithPercentEncoding() {
        let urlWithUnicode = "http://www.prothomalo.com/bangladesh/article/1472031/নারায়ণগঞ্জে-গ্যাসবোমার-ওপর-বসবাস-তাঁদের"
        let percentEncodedURL = "http://www.prothomalo.com/bangladesh/article/1472031/%E0%A6%A8%E0%A6%BE%E0%A6%B0%E0%A6%BE%E0%A6%AF%E0%A6%BC%E0%A6%A3%E0%A6%97%E0%A6%9E%E0%A7%8D%E0%A6%9C%E0%A7%87-%E0%A6%97%E0%A7%8D%E0%A6%AF%E0%A6%BE%E0%A6%B8%E0%A6%AC%E0%A7%8B%E0%A6%AE%E0%A6%BE%E0%A6%B0-%E0%A6%93%E0%A6%AA%E0%A6%B0-%E0%A6%AC%E0%A6%B8%E0%A6%AC%E0%A6%BE%E0%A6%B8-%E0%A6%A4%E0%A6%BE%E0%A6%81%E0%A6%A6%E0%A7%87%E0%A6%B0"

        XCTAssertNil(URL.init(string: urlWithUnicode))
        XCTAssertNotNil(URL.init(withPercentEncodingOfString: urlWithUnicode))
        XCTAssertEqual(URL.init(withPercentEncodingOfString: urlWithUnicode)?.absoluteString, percentEncodedURL)

    }

	func testAppendingQueryParameters() {
		XCTAssertEqual(url.appendingQueryParameters(params), queryUrl)
	}

	func testAppendQueryParameters() {
		url.appendQueryParameters(params)
		XCTAssertEqual(url, queryUrl)
	}

	func testQueryParameters() {
		let url = URL(string: "https://www.google.com?q=swifter%20swift&steve=jobs&empty")!
		guard let parameters = url.queryParameters else {
			XCTAssert(false)
			return
		}

		XCTAssertEqual(parameters.count, 2)
		XCTAssertEqual(parameters["q"], "swifter swift")
		XCTAssertEqual(parameters["steve"], "jobs")
		XCTAssertEqual(parameters["empty"], nil)
	}

    func testDeletingAllPathComponents() {
        let url = URL(string: "https://domain.com/path/other/")!
        let result = url.deletingAllPathComponents()
        XCTAssertEqual(result.absoluteString, "https://domain.com/")
    }

    func testDeleteAllPathComponents() {
        var url = URL(string: "https://domain.com/path/other/")!
        url.deleteAllPathComponents()
        XCTAssertEqual(url.absoluteString, "https://domain.com/")
    }

	#if os(iOS) || os(tvOS)
	func testThumbnail() {
		XCTAssertNil(url.thumbnail())

		let videoUrl = Bundle(for: URLExtensionsTests.self).url(forResource: "big_buck_bunny_720p_1mb", withExtension: "mp4")!
		XCTAssertNotNil(videoUrl.thumbnail())
		XCTAssertNotNil(videoUrl.thumbnail(fromTime: 1))
	}
	#endif

}
