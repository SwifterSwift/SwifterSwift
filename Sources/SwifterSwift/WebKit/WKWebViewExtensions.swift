//
//  WKWebViewExtensions.swift
//  SwifterSwift
//
//  Created by Tigran Hambardzumyan on 5/23/20.
//  Copyright © 2020 SwifterSwift
//

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
    public func loadURLString(_ urlString: String) -> WKNavigation? {
        guard let url = URL(string: urlString) else { return nil }
        return load(URLRequest(url: url))
    }

}

#endif
