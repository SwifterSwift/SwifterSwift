// String+CamelizeTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringCamelizeTests {
    @Test(arguments: [
        ("sOme vAriable naMe", "someVariableName"),
        ("Hello test", "helloTest"),
        ("helloWorld", "helloworld"),
        ("user_id", "userId"),
        ("foo-bar baz", "fooBarBaz"),
        ("straße ßtadt", "straßeSstadt")
    ])
    func convertsToCamelCase(_ string: String, _ expected: String) {
        var value = string
        value.camelize()
        #expect(value == expected)
    }

    @Test(arguments: ["", " ", "-_-", "😀"])
    func leavesEmptyStringWithoutWords(_ string: String) {
        var value = string
        value.camelize()
        #expect(value.isEmpty)
    }
}
