// URLRequest+CurlCommand.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation) && !os(WASI)
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension URLRequest {
    /// SwifterSwift: A shell command that sends the same request with `curl`.
    ///
    /// Every argument is single-quoted for POSIX shells such as `sh`, `bash` and `zsh`, so URLs with `&`, and headers
    /// or bodies with quotes, `$` or newlines, paste into a terminal safely. The command includes:
    ///
    /// - the URL;
    /// - the HTTP method, unless curl would pick the same one on its own (`--head` for `HEAD`);
    /// - every header field, sorted by name, including `Authorization` and `Cookie`, so take care where you log it;
    /// - the body, passed with `--data-raw` when it's UTF-8 text, or piped in through `printf` otherwise.
    ///
    /// ```swift
    /// let url = URL(string: "https://api.example.com/search?q=swift&page=2")!
    /// var request = URLRequest(url: url)
    /// request.httpMethod = "POST"
    /// request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    /// request.httpBody = Data(#"{"name":"Taylor's"}"#.utf8)
    /// print(request.curlCommand ?? "")
    /// // curl 'https://api.example.com/search?q=swift&page=2' \
    /// //   -X 'POST' \
    /// //   -H 'Content-Type: application/json' \
    /// //   --data-raw '{"name":"Taylor'\''s"}'
    /// ```
    ///
    /// A body set with `httpBodyStream`, and cookies that `URLSession` adds from `HTTPCookieStorage` when it sends
    /// the request, aren't part of the request value, so they aren't in the command. The property is `nil` when the
    /// request has no URL.
    ///
    /// - Complexity: O(*n*), where *n* is the combined size of the URL, the header fields and the body.
    var curlCommand: String? {
        guard let url else { return nil }
        let quote = { (text: String) in "'" + text.replacingOccurrences(of: "'", with: #"'\''"#) + "'" }
        let method = httpMethod ?? "GET"
        let body = httpBody ?? Data()

        var arguments = ["curl " + quote(url.absoluteString)]
        if method == "HEAD" {
            arguments.append("--head")
        } else if method != "GET" || !body.isEmpty {
            arguments.append("-X " + quote(method))
        }
        let headers = (allHTTPHeaderFields ?? [:]).sorted { $0.key.lowercased() < $1.key.lowercased() }
        for (name, value) in headers {
            // curl removes a header written as "Name:", so an empty value is written as "Name;".
            arguments.append("-H " + quote(value.isEmpty ? "\(name);" : "\(name): \(value)"))
        }

        var input = ""
        if !body.isEmpty {
            if !body.contains(0), let text = String(data: body, encoding: .utf8) {
                arguments.append("--data-raw " + quote(text))
            } else {
                // Binary data can't be a command-line argument, so printf writes it to curl's standard input.
                let escapedBytes = body.map { byte in
                    let octal = String(byte, radix: 8)
                    return "\\" + String(repeating: "0", count: 3 - octal.count) + octal
                }
                input = "printf '" + escapedBytes.joined() + "' | "
                arguments.append("--data-binary @-")
            }
        }
        return input + arguments.joined(separator: " \\\n  ")
    }
}
#endif
