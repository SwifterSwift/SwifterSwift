// Digest+HexStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(CryptoKit)
import CryptoKit
import Foundation
import SwifterSwiftCryptoKit
import Testing

struct DigestHexStringTests {
    /// Expected values from `shasum`, `md5` and `openssl dgst`.
    @Test(arguments: [
        (
            SHA256.hash(data: Data()).hexString,
            "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
        ),
        (
            SHA256.hash(data: Data("Hello, World!".utf8)).hexString,
            "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f"
        ),
        (
            SHA384.hash(data: Data()).hexString,
            "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b"
        ),
        (
            SHA512.hash(data: Data("Hello, World!".utf8)).hexString,
            "374d794a95cdcfd8b35993185fef9ba368f160d8daf432d08ba9f1ed1e5abe6c"
                + "c69291e0fa2fe0006a52570ef18c19def4e617c33ce52ef0a6e5fbe318cb0387"
        ),
        (Insecure.MD5.hash(data: Data()).hexString, "d41d8cd98f00b204e9800998ecf8427e"),
        (Insecure.SHA1.hash(data: Data("abc".utf8)).hexString, "a9993e364706816aba3e25717850c26c9cd0d89d")
    ])
    func matchesKnownDigests(hexString: String, expected: String) {
        #expect(hexString == expected)
    }

    @Test
    func hashesUnicodeInputByItsUTF8Bytes() {
        let digest = SHA256.hash(data: Data("🚀 cafe\u{301} 🇸🇾".utf8))
        #expect(digest.hexString == "f15975a41ab86b724e48a305fb4ccb37dc2d26f48ff1c19b9ee560cd39283a50")
    }

    @Test
    func keepsLeadingZerosOfEachByte() {
        // The MD5 digest of an empty input contains the bytes 0x00 and 0x04.
        let hexString = Insecure.MD5.hash(data: Data()).hexString
        #expect(hexString.contains("8f00b204"))
    }

    @Test(arguments: [Data(), Data("a".utf8), Data(repeating: 0, count: 1_000), Data(repeating: 0xFF, count: 64)])
    func hasTwoLowercaseDigitsPerByte(_ data: Data) {
        let digests: [(hexString: String, byteCount: Int)] = [
            (SHA256.hash(data: data).hexString, SHA256.byteCount),
            (SHA384.hash(data: data).hexString, SHA384.byteCount),
            (SHA512.hash(data: data).hexString, SHA512.byteCount),
            (Insecure.MD5.hash(data: data).hexString, Insecure.MD5.byteCount),
            (Insecure.SHA1.hash(data: data).hexString, Insecure.SHA1.byteCount)
        ]
        for digest in digests {
            #expect(digest.hexString.count == digest.byteCount * 2)
            #expect(digest.hexString.allSatisfy { "0123456789abcdef".contains($0) })
        }
    }

    @Test(arguments: [Data(), Data("SwifterSwift".utf8), Data(repeating: 7, count: 4_096)])
    func matchesTheDigitsInTheDescription(_ data: Data) {
        let sha256 = SHA256.hash(data: data)
        let sha512 = SHA512.hash(data: data)
        let md5 = Insecure.MD5.hash(data: data)
        #expect(sha256.description == "SHA256 digest: " + sha256.hexString)
        #expect(sha512.description == "SHA512 digest: " + sha512.hexString)
        #expect(md5.description == "MD5 digest: " + md5.hexString)
    }

    @Test
    func matchesTheDigestBytes() {
        let digest = SHA256.hash(data: Data("SwifterSwift".utf8))
        let expected = digest.map { byte in
            let digits = String(byte, radix: 16)
            return digits.count == 1 ? "0" + digits : digits
        }
        .joined()
        #expect(digest.hexString == expected)
    }

    @Test
    func worksForMessageDigestsOfStreamedInput() {
        var hasher = SHA256()
        hasher.update(data: Data("Hello, ".utf8))
        hasher.update(data: Data("World!".utf8))
        #expect(hasher.finalize().hexString == "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f")
    }
}
#endif
