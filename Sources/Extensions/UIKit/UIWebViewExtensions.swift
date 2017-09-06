//
//  UIWebViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/5/17.
//
//

#if os(iOS)
import UIKit


// MARK: - Methods
public extension UIWebView {
	
	/// SwifterSwift: Load a URL
	///
	/// - Parameter url: URL
	public func loadURL(_ url: URL) {
		loadRequest(URLRequest(url: url))
	}
	
	/// SwifterSwift: Load a URL string
	///
	/// - Parameter urlString: URL string
	public func loadURLString(_ urlString: String) {
		guard let url = URL(string: urlString) else { return }
		loadRequest(URLRequest(url: url))
	}
	
}
#endif
