// UIImageExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit)
import UIKit

final class UIImageExtensionsTests: XCTestCase {
    func testAverageColor() {
        let size = CGSize(width: 10, height: 5)

        // simple fill test
        XCTAssertEqual(UIColor.blue, UIImage(color: .blue, size: size).averageColor()!, accuracy: 0.01)
        XCTAssertEqual(UIColor.orange, UIImage(color: .orange, size: size).averageColor()!, accuracy: 0.01)

        // more interesting - red + green = yellow
        let renderer = UIGraphicsImageRenderer(size: size)
        let yellow = renderer.image {
            var rect = CGRect(x: 0, y: 0, width: size.width / 2, height: size.height)
            for color in [UIColor.red, UIColor.green] {
                $0.cgContext.beginPath()
                $0.cgContext.setFillColor(color.cgColor)
                $0.cgContext.addRect(rect)
                $0.cgContext.fillPath()
                rect.origin.x += rect.size.width
            }
        }
        XCTAssertEqual(UIColor(red: 0.5, green: 0.5, blue: 0, alpha: 1), yellow.averageColor()!, accuracy: 0.01)
    }

    func testBytesSize() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        if #available(iOS 17.0, *) {
            XCTAssertEqual(image.bytesSize, 68717)
        } else {
            XCTAssertEqual(image.bytesSize, 68665)
        }
        XCTAssertEqual(UIImage().bytesSize, 0)
    }

    func testKilobytesSize() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        XCTAssertEqual(image.kilobytesSize, 67)
    }

    func testOriginal() {
        let image = UIImage(color: .blue, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.original, image.withRenderingMode(.alwaysOriginal))
    }

    func testTemplate() {
        let image = UIImage(color: .blue, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.template, image.withRenderingMode(.alwaysTemplate))
    }

    func testCompressed() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        let originalSize = image.kilobytesSize
        let compressedImage = image.compressed(quality: 0.2)
        XCTAssertNotNil(compressedImage)
        XCTAssertLessThan(compressedImage!.kilobytesSize, originalSize)
        XCTAssertNil(UIImage().compressed())
    }

    func testCompressedData() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        let originalSize = image.bytesSize
        let compressedImageData = image.compressedData(quality: 0.2)
        XCTAssertNotNil(compressedImageData)
        XCTAssertLessThan(compressedImageData!.count, originalSize)
        XCTAssertNil(UIImage().compressedData())
    }

    func testCropped() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        var cropped = image.cropped(to: CGRect(x: 0, y: 0, width: 40, height: 40))
        XCTAssertEqual(image, cropped)
        cropped = image.cropped(to: CGRect(x: 0, y: 0, width: 10, height: 10))
        let small = UIImage(color: .black, size: CGSize(width: 10, height: 10))
        XCTAssertEqual(cropped.bytesSize, small.bytesSize)

        let equalHeight = image.cropped(to: CGRect(x: 0, y: 0, width: 18, height: 20))
        XCTAssertNotEqual(image, equalHeight)

        let equalWidth = image.cropped(to: CGRect(x: 0, y: 0, width: 20, height: 18))
        XCTAssertNotEqual(image, equalWidth)

        guard let cgImage = image.cgImage else {
            XCTFail("Get cgImage from image failed")
            return
        }

        let imageWithScale = UIImage(cgImage: cgImage, scale: 2.0, orientation: .up)
        cropped = imageWithScale.cropped(to: CGRect(x: 0, y: 0, width: 15, height: 15))
        XCTAssertEqual(imageWithScale, cropped)

        cropped = imageWithScale.cropped(to: CGRect(x: 0, y: 0, width: 5, height: 6))
        XCTAssertEqual(imageWithScale.scale, cropped.scale)

        XCTAssertEqual(10, cropped.size.width * cropped.scale)
        XCTAssertEqual(12, cropped.size.height * cropped.scale)
    }

    func testScaledToHeight() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        let scaledImage = image.scaled(toHeight: 300)
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage!.size.height, 300, accuracy: 0.1)
    }

    func testScaledToWidth() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        let scaledImage = image.scaled(toWidth: 300)
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage!.size.width, 300, accuracy: 0.1)
    }

    func testRotatedByMeasurement() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        let halfRotatedImage = image.rotated(by: Measurement(value: 90, unit: .degrees))
        XCTAssertNotNil(halfRotatedImage)
        XCTAssertEqual(halfRotatedImage!.size, CGSize(width: image.size.height, height: image.size.width))

        let rotatedImage = image.rotated(by: Measurement(value: 180, unit: .degrees))
        XCTAssertNotNil(rotatedImage)
        XCTAssertEqual(rotatedImage!.size, image.size)
        XCTAssertNotEqual(image.jpegData(compressionQuality: 1), rotatedImage!.jpegData(compressionQuality: 1))
    }

    func testRotatedByRadians() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        let halfRotatedImage = image.rotated(by: .pi / 2)
        XCTAssertNotNil(halfRotatedImage)
        XCTAssertEqual(halfRotatedImage!.size, CGSize(width: image.size.height, height: image.size.width))

        let rotatedImage = image.rotated(by: .pi)
        XCTAssertNotNil(rotatedImage)
        XCTAssertEqual(rotatedImage!.size, image.size)
        XCTAssertNotEqual(image.jpegData(compressionQuality: 1), rotatedImage!.jpegData(compressionQuality: 1))
    }

    func testFilled() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        let image2 = UIImage(color: .yellow, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(image.filled(withColor: .yellow).bytesSize, image2.bytesSize)

        var emptyImage = UIImage()
        var filledImage = emptyImage.filled(withColor: .red)
        XCTAssertEqual(emptyImage, filledImage)

        emptyImage = UIImage(color: .yellow, size: CGSize.zero)
        filledImage = emptyImage.filled(withColor: .red)
        XCTAssertEqual(emptyImage, filledImage)
    }

    func testBase64() {
        let base64String =
            "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAE0lEQVR42mP8v5JhEwMaYKSBIADNAwvIr8dhZAAAAABJRU5ErkJggg=="
        let image = UIImage(base64String: base64String)
        XCTAssertNotNil(image)

        let size = CGSize(width: 5, height: 5)
        XCTAssertEqual(image?.size, size)

        if #available(iOS 17.0, *) {
            XCTAssertEqual(image?.bytesSize, 839)
        } else {
            XCTAssertEqual(image?.bytesSize, 787)
        }

        let scale = CGFloat(5.0)
        let scaledSize = CGSize(width: size.width / scale, height: size.height / scale)

        let scaledImage = UIImage(base64String: base64String, scale: scale)
        XCTAssertEqual(scaledImage?.size, scaledSize)
    }

    func testURL() {
        let bundle = Bundle(for: UIImageExtensionsTests.self)
        guard let swifterSwiftLogo = bundle.url(forResource: "TestImage", withExtension: "png") else { XCTAssert(false, "Swifter Swift Test Image not available, or url is no longer valid."); return }
        let image = try? UIImage(url: swifterSwiftLogo)
        XCTAssertNotNil(image)

        let size = CGSize(width: 1000, height: 232)
        XCTAssertEqual(image?.size, size)

        let scale: CGFloat = 5.0
        let scaledSize = CGSize(width: size.width / scale, height: size.height / scale)

        let scaledImage = try? UIImage(url: swifterSwiftLogo, scale: scale)
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage?.size, scaledSize)

        guard let throwingURL = URL(string: "SwifterSwift://fakeurl/image1") else {
            XCTAssert(false, "Fake URL cannot be made")
            return
        }

        XCTAssertThrowsError(try UIImage(url: throwingURL))
    }

    func testTinted() {
        let baseImage = UIImage(color: .white, size: CGSize(width: 20, height: 20))
        let tintedImage = baseImage.tint(.black, blendMode: .overlay)
        let testImage = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(testImage.bytesSize, tintedImage.bytesSize)
    }

    func testWithBackgroundColor() {
        let size = CGSize(width: 1, height: 1)
        let clearImage = UIImage(color: .clear, size: size)
        let imageWithBackgroundColor = clearImage.withBackgroundColor(.black)
        XCTAssertNotNil(imageWithBackgroundColor)
        let blackImage = UIImage(color: .black, size: size)
        XCTAssertEqual(imageWithBackgroundColor.pngData(), blackImage.pngData())
    }

    func testWithCornerRadius() {
        let image = UIImage(color: .black, size: CGSize(width: 20, height: 20))
        XCTAssertNotNil(image.withRoundedCorners())
        XCTAssertNotNil(image.withRoundedCorners(radius: 5))
        XCTAssertNotNil(image.withRoundedCorners(radius: -10))
        XCTAssertNotNil(image.withRoundedCorners(radius: 30))
    }

    func testPNGBase64String() {
        let image = UIImage(color: .blue, size: CGSize(width: 1, height: 1))
        let base64String: String
        if #available(iOS 17.0, *) {
            base64String =
                "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAIRlWElmTU0AKgAAAAgABQESAAMAAAABAAEAAAEaAAUAAAABAAAASgEbAAUAAAABAAAAUgEoAAMAAAABAAIAAIdpAAQAAAABAAAAWgAAAAAAAABIAAAAAQAAAEgAAAABAAOgAQADAAAAAQABAACgAgAEAAAAAQAAAAGgAwAEAAAAAQAAAAEAAAAAChjw/QAAAAlwSFlzAAALEwAACxMBAJqcGAAAAA1JREFUCB1jYGD4/x8AAwIB/6fhVKUAAAAASUVORK5CYII="
        } else {
            base64String =
                "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD5Ip3+AAAADUlEQVQIHWNgYPj/HwADAgH/p+FUpQAAAABJRU5ErkJggg=="
        }
        XCTAssertEqual(
            image.pngBase64String(),
            base64String)
    }

    func testJPEGBase64String() {
        let image = UIImage(color: .blue, size: CGSize(width: 1, height: 1))
        let base64String: String
        if #available(iOS 17.0, *) {
            base64String =
                "/9j/4AAQSkZJRgABAQAASABIAAD/4QCMRXhpZgAATU0AKgAAAAgABQESAAMAAAABAAEAAAEaAAUAAAABAAAASgEbAAUAAAABAAAAUgEoAAMAAAABAAIAAIdpAAQAAAABAAAAWgAAAAAAAABIAAAAAQAAAEgAAAABAAOgAQADAAAAAQABAACgAgAEAAAAAQAAAAGgAwAEAAAAAQAAAAEAAAAA/+0AOFBob3Rvc2hvcCAzLjAAOEJJTQQEAAAAAAAAOEJJTQQlAAAAAAAQ1B2M2Y8AsgTpgAmY7PhCfv/AABEIAAEAAQMBEQACEQEDEQH/xAAfAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUGBwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/3QAEAAH/2gAMAwEAAhEDEQA/AP456/7+D+Vz/9k="
        } else {
            base64String =
                "/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgAAQABAwERAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/dAAQAAf/aAAwDAQACEQMRAD8A/jnr/v4P5XP/2Q=="
        }
        XCTAssertEqual(
            image.jpegBase64String(compressionQuality: 1),
            base64String)
    }

    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testWithAlwaysOriginalTintColor() {
        let image = UIImage(color: .blue, size: CGSize(width: 20, height: 20))
        XCTAssertEqual(
            image.withAlwaysOriginalTintColor(.red),
            image.withTintColor(.red, renderingMode: .alwaysOriginal))
    }
}

#endif
