import XCTest

import SwifterSwiftFoundationTests
import SwifterSwiftStdlibTests

var tests = [XCTestCaseEntry]()
tests += SwifterSwiftFoundationTests.__allTests()
tests += SwifterSwiftStdlibTests.__allTests()

XCTMain(tests)
