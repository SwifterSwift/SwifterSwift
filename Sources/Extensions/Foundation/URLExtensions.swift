//
//  URLExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 SwifterSwift
//

import Foundation

// MARK: - Methods
public extension URL {
	
	/// SwifterSwift: URL with appending query parameters.
	///
	///		let url = URL(string: "https://google.com")!
	///		let param = ["q": "Swifter Swift"]
	///		url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
	///
	/// - Parameter parameters: parameters dictionary.
	/// - Returns: URL with appending given query parameters.
	public func appendingQueryParameters(_ parameters: [String: String]) -> URL {
		var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
		var items = urlComponents.queryItems ?? []
		items += parameters.map({ URLQueryItem(name: $0, value: $1) })
		urlComponents.queryItems = items
		return urlComponents.url!
	}
	
	/// SwifterSwift: Append query parameters to URL.
	///
	///		var url = URL(string: "https://google.com")!
	///		let param = ["q": "Swifter Swift"]
	///		url.appendQueryParameters(params)
	///		print(url) // prints "https://google.com?q=Swifter%20Swift"
	///
	/// - Parameter parameters: parameters dictionary.
	public mutating func appendQueryParameters(_ parameters: [String: String]) {
		self = appendingQueryParameters(parameters)
	}
	
}
