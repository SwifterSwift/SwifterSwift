//
//  UIImageViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/25/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - Methods
extension UIImageView {

	/// SwifterSwift: Set image from a URL.
	///
	/// - Parameters:
	///   - url: URL of image.
	///   - contentMode: imageView content mode (default is .scaleAspectFit).
	///   - placeHolder: optional placeholder image
	///   - completionHandler: optional completion handler to run when download finishs (default is nil).
	public func download(from url: URL,
	                     contentMode: UIViewContentMode = .scaleAspectFit,
	                     placeholder: UIImage? = nil,
	                     completionHandler: ((UIImage?, Error?) -> Void)? = nil) {

		image = placeholder
		self.contentMode = contentMode
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else {
					completionHandler?(nil, error)
					return
			}
			DispatchQueue.main.async() { () -> Void in
				self.image = image
				completionHandler?(image, nil)
			}
			}.resume()
	}

	/// SwifterSwift: Make image view blurry
	///
	/// - Parameter withStyle: UIBlurEffectStyle (default is .light).
	func blur(withStyle: UIBlurEffectStyle = .light) {
		let blurEffect = UIBlurEffect(style: withStyle)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		self.addSubview(blurEffectView)
		self.clipsToBounds = true
	}

	/// SwifterSwift: Blurred version of an image view
	///
	/// - Parameter withStyle: UIBlurEffectStyle (default is .light).
	/// - Returns: blurred version of self.
	func blurred(withStyle: UIBlurEffectStyle = .light) -> UIImageView {
		return self.blurred(withStyle: withStyle)
	}

}
