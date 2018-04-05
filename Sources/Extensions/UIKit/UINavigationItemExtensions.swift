//
//  UINavigationItemExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Methods
public extension UINavigationItem {

	/// SwifterSwift: Replace title label with an image in navigation item.
	///
	/// - Parameter image: UIImage to replace title with.
	public func replaceTitle(with image: UIImage) {
		let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
		logoImageView.contentMode = .scaleAspectFit
		logoImageView.image = image
		titleView = logoImageView
	}

}
#endif

#endif
