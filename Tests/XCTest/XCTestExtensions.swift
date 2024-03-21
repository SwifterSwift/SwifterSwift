// XCTestExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(XCTest)
import XCTest

#if canImport(UIKit)
import UIKit

/// SwifterSwift: Color
public typealias SFColor = UIColor
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

/// SwifterSwift: Color
public typealias SFColor = NSColor
#endif

#if canImport(AppKit) || canImport(UIKit)
/// SwifterSwift: Asserts that the RGBA values of two `Color`s are equal within a certain accuracy.
/// - Parameters:
///   - expression1: A `Color`.
///   - expression2: A `Color`.
///   - accuracy: Describes the maximum difference between `expression1` and `expression2` for these values to be
/// considered equal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was
/// called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertEqual(_ expression1: @autoclosure () throws -> SFColor,
                           _ expression2: @autoclosure () throws -> SFColor,
                           accuracy: CGFloat,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #filePath,
                           line: UInt = #line) {
    var color1: SFColor!
    XCTAssertNoThrow(color1 = try expression1(), message(), file: file, line: line)
    var color2: SFColor!
    XCTAssertNoThrow(color2 = try expression2(), message(), file: file, line: line)
    var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
    var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0
    color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
    color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
    XCTAssertEqual(red1, red2, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(green1, green2, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(blue1, blue2, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(alpha1, alpha2, accuracy: accuracy, message(), file: file, line: line)
}
#endif

#if canImport(CoreGraphics)
/// SwifterSwift: Asserts that the RGBA values of two `CGAffineTransform`s are equal within a certain accuracy.
/// - Parameters:
///   - expression1: A `CGAffineTransform`.
///   - expression2: A `CGAffineTransform`.
///   - accuracy: Describes the maximum difference between `expression1` and `expression2` for these values to be
/// considered equal.
///   - message: An optional description of the failure.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was
/// called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
public func XCTAssertEqual(_ expression1: @autoclosure () throws -> CGAffineTransform,
                           _ expression2: @autoclosure () throws -> CGAffineTransform,
                           accuracy: CGFloat,
                           _ message: @autoclosure () -> String = "",
                           file: StaticString = #filePath,
                           line: UInt = #line) {
    var transform1: CGAffineTransform!
    XCTAssertNoThrow(transform1 = try expression1(), message(), file: file, line: line)
    var transform2: CGAffineTransform!
    XCTAssertNoThrow(transform2 = try expression2(), message(), file: file, line: line)
    XCTAssertEqual(transform1.a, transform2.a, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(transform1.b, transform2.b, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(transform1.c, transform2.c, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(transform1.d, transform2.d, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(transform1.tx, transform2.tx, accuracy: accuracy, message(), file: file, line: line)
    XCTAssertEqual(transform1.ty, transform2.ty, accuracy: accuracy, message(), file: file, line: line)
}
#endif

#endif
