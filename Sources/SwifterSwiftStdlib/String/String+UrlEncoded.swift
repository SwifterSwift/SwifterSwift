// String+UrlEncoded.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: The string percent-encoded for use as a single URL component, such as a query value.
    ///
    /// Every character except the unreserved characters of RFC 3986 (`A`–`Z`, `a`–`z`, `0`–`9`, `-`, `.`, `_` and `~`)
    /// is replaced by the percent-encoded bytes of its UTF-8 form, with uppercase hex digits. A space becomes `%20`,
    /// not `+`.
    ///
    /// Foundation's predefined sets are easy to misuse here: `.urlQueryAllowed` and `.urlHostAllowed` leave `&`, `=`
    /// and `+` unescaped, so a value containing them would break the surrounding query. This property needs only the
    /// standard library.
    ///
    /// ```swift
    /// "it's easy".urlEncoded  // "it%27s%20easy"
    /// "a&b=c+d".urlEncoded  // "a%26b%3Dc%2Bd"
    /// "café".urlEncoded  // "caf%C3%A9"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string in UTF-8 bytes.
    var urlEncoded: String {
        let hexDigits = Array("0123456789ABCDEF".unicodeScalars)
        var result = String.UnicodeScalarView()
        for byte in utf8 {
            switch byte {
            case UInt8(ascii: "A")...UInt8(ascii: "Z"), UInt8(ascii: "a")...UInt8(ascii: "z"),
                UInt8(ascii: "0")...UInt8(ascii: "9"), UInt8(ascii: "-"), UInt8(ascii: "."), UInt8(ascii: "_"),
                UInt8(ascii: "~"):
                result.append(Unicode.Scalar(byte))
            default:
                result.append("%")
                result.append(hexDigits[Int(byte >> 4)])
                result.append(hexDigits[Int(byte & 0x0F)])
            }
        }
        return String(result)
    }
}
