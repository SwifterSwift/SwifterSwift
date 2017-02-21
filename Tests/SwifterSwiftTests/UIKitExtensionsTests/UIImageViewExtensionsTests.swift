//
//  UIImageViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/19/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
	
import XCTest
@testable import SwifterSwift

class UIImageViewExtensionsTests: XCTestCase {
	
	func testDownload() {
		let imageView = UIImageView()
		let url = URL(string: "https://developer.apple.com/swift/images/swift-og.png")!
		let placeHolder = UIImage()
		var completionCalled = false
		imageView.download(from: url, contentMode: .scaleAspectFill, placeholder: placeHolder) { image in
			completionCalled = true
			XCTAssert(completionCalled)
			XCTAssertEqual(imageView.image, image)
		}
		XCTAssertEqual(imageView.image, placeHolder)
		XCTAssertEqual(imageView.contentMode, .scaleAspectFill)
		
		let failingURL = URL(string: "https://developer.apple.com/")!
		var failingCompletionCalled = false
		imageView.download(from: failingURL, contentMode: .center, placeholder: nil) { image in
			failingCompletionCalled = true
			XCTAssertNil(image)
			XCTAssert(failingCompletionCalled)
		}
		XCTAssertEqual(imageView.contentMode, .center)
		XCTAssertNil(imageView.image)
	}
	
	func testBlur() {
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
		imageView.blur(withStyle: .dark)
		
		let blurView = imageView.subviews.first as? UIVisualEffectView
		XCTAssertNotNil(blurView)
		XCTAssertNotNil(blurView?.effect)
		XCTAssertEqual(blurView?.frame, imageView.bounds)
		XCTAssertEqual(blurView?.autoresizingMask, [.flexibleWidth, .flexibleHeight])
		XCTAssert(imageView.clipsToBounds)
	}
	
	func testBlurred() {
		let imageView = UIImageView()
		let blurredImageView = imageView.blurred(withStyle: .extraLight)
		XCTAssertEqual(blurredImageView, imageView)
	}
	
}
#endif
