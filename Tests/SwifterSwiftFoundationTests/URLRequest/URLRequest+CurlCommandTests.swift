// URLRequest+CurlCommandTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation) && !os(WASI)
import Foundation
import SwifterSwiftFoundation
import Testing
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct URLRequestCurlCommandTests {
    func makeRequest(_ string: String) throws -> URLRequest {
        URLRequest(url: try #require(URL(string: string)))
    }

    @Test
    func returnsNilWithoutAURL() throws {
        var request = try makeRequest("https://api.example.com")
        request.url = nil
        #expect(request.curlCommand == nil)
    }

    @Test
    func quotesTheURL() throws {
        let request = try makeRequest("https://api.example.com/search?q=swift&page=2")
        #expect(request.curlCommand == "curl 'https://api.example.com/search?q=swift&page=2'")
    }

    @Test
    func escapesSingleQuotesInTheURL() throws {
        let request = try makeRequest("https://example.com/it's")
        #expect(request.curlCommand == #"curl 'https://example.com/it'\''s'"#)
    }

    @Test
    func writesTheMethodHeadersAndBody() throws {
        var request = try makeRequest("https://api.example.com/search?q=swift&page=2")
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data(#"{"name":"Taylor's"}"#.utf8)
        let expected = #"""
            curl 'https://api.example.com/search?q=swift&page=2' \
              -X 'POST' \
              -H 'Content-Type: application/json' \
              --data-raw '{"name":"Taylor'\''s"}'
            """#
        #expect(request.curlCommand == expected)
    }

    @Test
    func usesTheHeadOption() throws {
        var request = try makeRequest("https://example.com")
        request.httpMethod = "HEAD"
        #expect(request.curlCommand == "curl 'https://example.com' \\\n  --head")
    }

    @Test
    func writesTheMethodWhenCurlWouldPickAnotherOne() throws {
        var request = try makeRequest("https://example.com")
        request.httpBody = Data("a=1".utf8)
        #expect(request.curlCommand == "curl 'https://example.com' \\\n  -X 'GET' \\\n  --data-raw 'a=1'")

        request.httpMethod = "DELETE"
        request.httpBody = nil
        #expect(request.curlCommand == "curl 'https://example.com' \\\n  -X 'DELETE'")
    }

    @Test
    func sortsHeadersAndKeepsCookieAndAuthorization() throws {
        var request = try makeRequest("https://example.com")
        request.setValue("1", forHTTPHeaderField: "zeta")
        request.setValue("session=abc", forHTTPHeaderField: "Cookie")
        request.setValue("Bearer token", forHTTPHeaderField: "Authorization")
        request.setValue("2", forHTTPHeaderField: "x-lower")
        request.setValue("3", forHTTPHeaderField: "Alpha")
        #if canImport(Darwin)
        let (lower, zeta) = ("x-lower", "zeta")
        #else
        // Foundation outside Apple platforms capitalizes header names.
        let (lower, zeta) = ("X-Lower", "Zeta")
        #endif
        let expected = """
            curl 'https://example.com' \\
              -H 'Alpha: 3' \\
              -H 'Authorization: Bearer token' \\
              -H 'Cookie: session=abc' \\
              -H '\(lower): 2' \\
              -H '\(zeta): 1'
            """
        #expect(request.curlCommand == expected)
    }

    @Test
    func writesEmptyHeaderValuesSoCurlSendsThem() throws {
        var request = try makeRequest("https://example.com")
        request.setValue("", forHTTPHeaderField: "X-Empty")
        #expect(request.curlCommand == "curl 'https://example.com' \\\n  -H 'X-Empty;'")
    }

    @Test
    func keepsUnicodeText() throws {
        var request = try makeRequest("https://example.com")
        request.httpMethod = "PUT"
        request.httpBody = Data("Grüße 👋🏽 🇸🇾".utf8)
        #expect(request.curlCommand == "curl 'https://example.com' \\\n  -X 'PUT' \\\n  --data-raw 'Grüße 👋🏽 🇸🇾'")
    }

    @Test
    func pipesBinaryBodiesThroughPrintf() throws {
        var request = try makeRequest("https://example.com/upload")
        request.httpMethod = "POST"
        request.httpBody = Data([0x00, 0xFF, 0x41, 0x0A])
        let expected =
            #"printf '\000\377\101\012' | curl 'https://example.com/upload' \"# + "\n  -X 'POST' \\\n"
            + "  --data-binary @-"
        #expect(request.curlCommand == expected)
    }

    @Test
    func pipesTextContainingNullBytesThroughPrintf() throws {
        var request = try makeRequest("https://example.com")
        request.httpMethod = "POST"
        request.httpBody = Data("a\u{0}b".utf8)
        #expect(request.curlCommand?.hasPrefix(#"printf '\141\000\142' | curl"#) == true)
    }

    @Test
    func ignoresAnEmptyBody() throws {
        var request = try makeRequest("https://example.com")
        request.httpBody = Data()
        #expect(request.curlCommand == "curl 'https://example.com'")
    }

    #if os(macOS) || os(Linux)
    /// Runs the command in `/bin/sh` with `curl` replaced by a function that prints its arguments, separated by NUL
    /// bytes, to standard output, and copies its standard input to standard error.
    func runInShell(_ command: String) throws -> (arguments: [String], input: Data) {
        let stub = #"curl() { for argument in "$@"; do printf '%s\0' "$argument"; done; cat >&2; }"#
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = ["-c", stub + "\n" + command]
        let output = Pipe()
        let errors = Pipe()
        process.standardOutput = output
        process.standardError = errors
        process.standardInput = FileHandle.nullDevice
        try process.run()
        let outputData = output.fileHandleForReading.readDataToEndOfFile()
        let errorData = errors.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        let arguments = outputData.split(separator: 0, omittingEmptySubsequences: false).dropLast()
        return (arguments.map { String(decoding: $0, as: UTF8.self) }, errorData)
    }

    @Test
    func passesEveryArgumentThroughTheShellUnchanged() throws {
        let url = "https://example.com/a?b=1&c=$HOME;d=(x)*!&e=it's"
        var request = try makeRequest(url)
        request.httpMethod = "POST"
        request.setValue(#"it's "quoted" $HOME `id` \ back"#, forHTTPHeaderField: "X-Tricky")
        request.httpBody = Data("line 1\nit's $HOME `id` \\n 'x' \"y\" 👍🏽".utf8)

        let result = try runInShell(try #require(request.curlCommand))
        #expect(
            result.arguments == [
                url, "-X", "POST", "-H", #"X-Tricky: it's "quoted" $HOME `id` \ back"#,
                "--data-raw", "line 1\nit's $HOME `id` \\n 'x' \"y\" 👍🏽"
            ]
        )
        #expect(result.input.isEmpty)
    }

    @Test
    func pipesEveryByteOfABinaryBodyThroughTheShell() throws {
        var request = try makeRequest("https://example.com/upload")
        request.httpMethod = "POST"
        let body = Data((0...255).map { UInt8($0) })
        request.httpBody = body

        let result = try runInShell(try #require(request.curlCommand))
        #expect(result.arguments == ["https://example.com/upload", "-X", "POST", "--data-binary", "@-"])
        #expect(result.input == body)
    }
    #endif
}
#endif
