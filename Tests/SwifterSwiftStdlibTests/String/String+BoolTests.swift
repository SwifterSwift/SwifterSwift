// String+BoolTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringBoolTests {
    @Test(arguments: ["true", "TRUE", "True", "yes", "YES", "Yes", "1", "  true ", "\ttrue\n", "\r\nyes\r\n"])
    func returnsTrueForTrueSpellings(_ string: String) {
        #expect(string.bool == true)
    }

    @Test(arguments: ["false", "FALSE", "False", "no", "NO", "No", "0", " false ", "\n0\n"])
    func returnsFalseForFalseSpellings(_ string: String) {
        #expect(string.bool == false)
    }

    @Test(arguments: ["", " ", "\n", "maybe", "8s", "2", "-1", "01", "t", "y", "n", "tru e", "yes!", "١", "ｙｅｓ"])
    func returnsNilForOtherStrings(_ string: String) {
        #expect(string.bool == nil)
    }
}
