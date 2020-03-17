//
//  UIButtonExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/14/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIButtonExtensionsTests: XCTestCase {

    func testImageForDisabled() {
        let button = UIButton()
        XCTAssertEqual(button.imageForDisabled, button.image(for: .disabled))

        let newImage = UIImage()
        button.imageForDisabled = newImage
        XCTAssertEqual(button.imageForDisabled, newImage)
    }

    func testImageForHighlighted() {
        let button = UIButton()
        XCTAssertEqual(button.imageForHighlighted, button.image(for: .highlighted))

        let newImage = UIImage()
        button.imageForHighlighted = newImage
        XCTAssertEqual(button.imageForHighlighted, newImage)
    }

    func testImageForNormal() {
        let button = UIButton()
        XCTAssertEqual(button.imageForNormal, button.image(for: .normal))

        let newImage = UIImage()
        button.imageForNormal = newImage
        XCTAssertEqual(button.imageForNormal, newImage)
    }

    func testImageForSelected() {
        let button = UIButton()
        XCTAssertEqual(button.imageForSelected, button.image(for: .selected))

        let newImage = UIImage()
        button.imageForSelected = newImage
        XCTAssertEqual(button.imageForSelected, newImage)
    }

    func testTitleColorForDisabled() {
        let button = UIButton()
        XCTAssertEqual(button.titleColorForDisabled, button.titleColor(for: .disabled))

        button.titleColorForDisabled = .green
        XCTAssertEqual(button.titleColorForDisabled, .green)
    }

    func testTitleColorForHighlighted() {
        let button = UIButton()
        XCTAssertEqual(button.titleColorForHighlighted, button.titleColor(for: .highlighted))

        button.titleColorForHighlighted = .green
        XCTAssertEqual(button.titleColorForHighlighted, .green)
    }

    func testTitleColorForNormal() {
        let button = UIButton()
        XCTAssertEqual(button.titleColorForNormal, button.titleColor(for: .normal))

        button.titleColorForNormal = .green
        XCTAssertEqual(button.titleColorForNormal, .green)
    }

    func testTitleColorForSelected() {
        let button = UIButton()
        XCTAssertEqual(button.titleColorForSelected, button.titleColor(for: .selected))

        button.titleColorForSelected = .green
        XCTAssertEqual(button.titleColorForSelected, .green)
    }

    func testTitleForDisabled() {
        let button = UIButton()
        XCTAssertEqual(button.titleForDisabled, button.title(for: .disabled))

        let title = "Disabled"
        button.titleForDisabled = title
        XCTAssertEqual(button.titleForDisabled, title)
    }

    func testTitleForHighlighted() {
        let button = UIButton()
        XCTAssertEqual(button.titleForHighlighted, button.title(for: .highlighted))

        let title = "Highlighted"
        button.titleForHighlighted = title
        XCTAssertEqual(button.titleForHighlighted, title)
    }

    func testTitleForNormal() {
        let button = UIButton()
        XCTAssertEqual(button.titleForNormal, button.title(for: .normal))

        let title = "Normal"
        button.titleForNormal = title
        XCTAssertEqual(button.titleForNormal, title)
    }

    func testTitleForSelected() {
        let button = UIButton()
        XCTAssertEqual(button.titleForSelected, button.title(for: .selected))

        let title = "Selected"
        button.titleForSelected = title
        XCTAssertEqual(button.titleForSelected, title)
    }

    func testSetImageForAllStates() {
        let button = UIButton()
        let image = UIImage()
        button.setImageForAllStates(image)

        XCTAssertEqual(button.imageForDisabled, image)
        XCTAssertEqual(button.imageForHighlighted, image)
        XCTAssertEqual(button.imageForNormal, image)
        XCTAssertEqual(button.imageForSelected, image)
    }

    func testSetTitleColorForAllStates() {
        let button = UIButton()
        let color = UIColor.green
        button.setTitleColorForAllStates(color)

        XCTAssertEqual(button.titleColorForDisabled, color)
        XCTAssertEqual(button.titleColorForHighlighted, color)
        XCTAssertEqual(button.titleColorForNormal, color)
        XCTAssertEqual(button.titleColorForSelected, color)
    }

    func testSetTitleForAllStates() {
        let button = UIButton()
        let title = "Title"
        button.setTitleForAllStates(title)

        XCTAssertEqual(button.titleForDisabled, title)
        XCTAssertEqual(button.titleForHighlighted, title)
        XCTAssertEqual(button.titleForNormal, title)
        XCTAssertEqual(button.titleForSelected, title)
    }

    func testCenterTextAndImage() {
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        let image = UIImage(color: .green, size: CGSize(width: 10, height: 10))
        button.setTitleForAllStates("Title")
        button.setImageForAllStates(image)

        XCTAssertNotNil(button.imageView)
        XCTAssertNotNil(button.titleLabel)

        let spacing: CGFloat = 20

        // Image on the left of text
        button.centerTextAndImage(spacing: spacing)
        var imageFrame = button.imageView!.frame
        var titleFrame = button.titleLabel!.frame

        XCTAssert(titleFrame.midX > imageFrame.midX)
        XCTAssertEqual(titleFrame.midY, imageFrame.midY, accuracy: 1.0)
        XCTAssertEqual(titleFrame.minX - spacing, imageFrame.maxX, accuracy: 1.0)

        // Image above text
        button.centerTextAndImage(imageAboveText: true, spacing: spacing)
        imageFrame = button.imageView!.frame
        titleFrame = button.titleLabel!.frame

        XCTAssert(titleFrame.midY > imageFrame.midY)
        XCTAssertEqual(titleFrame.midX, imageFrame.midX, accuracy: 1.0)
        XCTAssertEqual(titleFrame.minY - spacing, imageFrame.maxY, accuracy: 1.0)
    }

}

#endif
