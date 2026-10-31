// String+CamelCasedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringCamelCasedTests {
    @Test(arguments: [
        ("sOme vAriable naMe", "someVariableName"),
        ("Hello test", "helloTest"),
        ("Hellotest", "hellotest"),
        ("first_name", "firstName"),
        ("foo-bar baz", "fooBarBaz"),
        ("Content-Type header", "contentTypeHeader"),
        ("  leading and trailing  ", "leadingAndTrailing"),
        ("multi\nline\ttext", "multiLineText"),
        ("HTTP request", "httpRequest"),
        ("fooBar", "foobar"),
        ("version 2 beta", "version2Beta"),
        ("2 fast 2 furious", "2Fast2Furious"),
        ("élan vital", "élanVital"),
        ("straße ßtadt", "straßeSstadt"),
        ("hello, world!", "helloWorld"),
        ("a", "a")
    ])
    func convertsToCamelCase(_ string: String, _ expected: String) {
        #expect(string.camelCased == expected)
    }

    @Test(arguments: ["", " ", "   ", "-_-", "!?", "😀 🎉"])
    func returnsEmptyStringWithoutWords(_ string: String) {
        #expect(string.camelCased.isEmpty)
    }

    @Test
    func keepsCombiningMarksWithTheirLetters() {
        #expect("one e\u{301}clair".camelCased == "oneE\u{301}clair")
    }

    @Test
    func isIdempotentForCamelCaseWithoutCapitals() {
        #expect("hello".camelCased.camelCased == "hello")
    }
}
