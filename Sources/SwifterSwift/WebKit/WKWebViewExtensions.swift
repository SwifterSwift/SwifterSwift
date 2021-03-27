// WKWebViewExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(WebKit)
import WebKit

// MARK: - Methods

extension WKWebView {
    /// SwifterSwift: Navigate to `url`.
    /// - Parameter url: URL to navigate.
    /// - Returns: A new navigation for given `url`.
    @discardableResult
    public func loadURL(_ url: URL) -> WKNavigation? {
        return load(URLRequest(url: url))
    }

    /// SwifterSwift: Navigate to url using `String`.
    /// - Parameter urlString: The string specifying the URL to navigate to.
    /// - Returns: A new navigation for given `urlString`.
    @discardableResult
    public func loadURLString(_ urlString: String, timeout: TimeInterval? = nil) -> WKNavigation? {
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        if let timeout = timeout {
          request.timeoutInterval = timeout
        }
        return load(request)
    }
}

#endif
