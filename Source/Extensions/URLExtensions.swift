//
//  URLExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import Foundation

public extension URL {
	
	/// SwifterSwift: URL with appending query parameters.
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
	/// - Parameter parameters: parameters dictionary.
	public mutating func appendQueryParameters(_ parameters: [String: String]) {
		self = appendingQueryParameters(parameters)
	}
	
}
