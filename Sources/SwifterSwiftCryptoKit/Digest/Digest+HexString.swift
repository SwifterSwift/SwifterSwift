// Digest+HexString.swift - Copyright 2026 SwifterSwift

#if canImport(CryptoKit)
import CryptoKit

public extension Digest {
    /// SwifterSwift: The digest's bytes as a lowercase hexadecimal string.
    ///
    /// Each byte becomes two hexadecimal digits, so the string is twice as long as the digest's `byteCount`: 64
    /// characters for SHA-256. The digits are lowercase, matching the output of command-line tools such as `shasum`
    /// and `openssl`. The digest's `description` contains the same digits, but after a prefix such as
    /// `"SHA256 digest: "`. For uppercase digits, call `uppercased()` on the result.
    ///
    /// ```swift
    /// let digest = SHA256.hash(data: Data("Hello, World!".utf8))
    /// digest.hexString  // "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f"
    /// Insecure.MD5.hash(data: Data()).hexString  // "d41d8cd98f00b204e9800998ecf8427e"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of bytes in the digest.
    var hexString: String {
        var digits: [UInt8] = []
        digits.reserveCapacity(Self.byteCount * 2)
        for byte in self {
            let high = byte >> 4
            let low = byte & 0x0F
            digits.append(high < 10 ? UInt8(ascii: "0") + high : UInt8(ascii: "a") + high - 10)
            digits.append(low < 10 ? UInt8(ascii: "0") + low : UInt8(ascii: "a") + low - 10)
        }
        return String(decoding: digits, as: UTF8.self)
    }
}
#endif
