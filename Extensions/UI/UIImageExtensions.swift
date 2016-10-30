//
//  UIImageExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIImage {
	/// Crop image to CGRect.
	public func cropped(to rect: CGRect) -> UIImage {
		guard rect.size.height < self.size.height && rect.size.height < self.size.height else {
			return self
		}
		guard let cgImage: CGImage = self.cgImage?.cropping(to: rect) else {
			return self
		}
		return UIImage(cgImage: cgImage)
	}
	
	/// Create image from color and size.
	public convenience init(color: UIColor, size: CGSize) {
		UIGraphicsBeginImageContextWithOptions(size, false, 1)
		color.setFill()
		UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		self.init(cgImage: image.cgImage!)
	}
	
	/// Scale image to height with respect to aspect ratio.
	public func scaled(toHeight: CGFloat, with orientation: UIImageOrientation? = nil) -> UIImage? {
		let scale = toHeight / self.size.height
		let newWidth = self.size.width * scale
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: toHeight))
		self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}
	
	/// Scale image to width with respect to aspect ratio.
	public func scaled(toWidth: CGFloat, with orientation: UIImageOrientation? = nil) -> UIImage? {
		let scale = toWidth / self.size.width
		let newHeight = self.size.height * scale
		UIGraphicsBeginImageContext(CGSize(width: toWidth, height: newHeight))
		self.draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}
	
	/// Return image filled with color
	public func filled(withColor color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		color.setFill()
		guard let context = UIGraphicsGetCurrentContext() else {
			return self
		}
		context.translateBy(x: 0, y: self.size.height)
		context.scaleBy(x: 1.0, y: -1.0);
		context.setBlendMode(CGBlendMode.normal)
		
		let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
		guard let mask = self.cgImage else {
			return self
		}
		context.clip(to: rect, mask: mask)
		context.fill(rect)
		
		guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
			return self
		}
		UIGraphicsEndImageContext()
		return newImage
	}
	
}
