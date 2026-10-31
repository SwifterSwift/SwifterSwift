// String+IsValidEmailTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringIsValidEmailTests {
    // Many of these cases come from https://learn.microsoft.com/archive/blogs/testing123/email-address-test-cases.
    @Test(arguments: [
        "email@domain.com",
        "firstname.lastname@domain.com",
        "email@subdomain.domain.com",
        "firstname+lastname@domain.com",
        "email@123.123.123.123",
        "email@[123.123.123.123]",
        "\"email\"@domain.com",
        "1234567890@domain.com",
        "email@domain-one.com",
        "_______@domain.com",
        "email@domain.name",
        "email@domain.co.jp",
        "firstname-lastname@domain.com",
        "a#b!c$d@domain.com",
        "john@DOE.com",
        "JOHN@DOE.COM",
        "John.Doe@Example.Co.UK",
        "josé@exämple.com",
        "jose\u{301}@example.com",
        "用户@例子.广告",
        "user@xn--bcher-kva.example",
        "user@[IPv6:2001:db8::1]"
    ])
    func acceptsValidAddresses(_ string: String) {
        #expect(string.isValidEmail)
    }

    @Test(arguments: [
        "",
        "plainaddress",
        "#@%^%#$@#$@#.com",
        "@domain.com",
        "email@",
        "Joe Smith <email@domain.com>",
        "email.domain.com",
        "email@domain@domain.com",
        ".email@domain.com",
        "email.@domain.com",
        "email..email@domain.com",
        "email@domain.com (Joe Smith)",
        "email@domain",
        "email@-domain.com",
        "email@domain-.com",
        "email@domain..com",
        "email@.domain.com",
        "a b@domain.com",
        "email@domain .com",
        " email@domain.com",
        "email@domain.com ",
        "\nemail@domain.com",
        "email@domain.com\n",
        "nemail@domain.com   \n\n",
        "email@[999.1.1.1]",
        "email@[1.2.3]",
        "email😀@domain.com"
    ])
    func rejectsInvalidAddresses(_ string: String) {
        #expect(!string.isValidEmail)
    }
}
