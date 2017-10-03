//
//  UIColorExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

// MARK: - Properties
public extension UIColor {
	
	/// SwifterSwift: Get components of hue, saturation, and brightness, and alpha (read-only).
	public var uInt: UInt {
		var colorAsUInt32: UInt32 = 0
		var r: CGFloat = 0
		var g: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 0
		
		self.getRed(&r, green: &g, blue: &b, alpha: &a)
		
		colorAsUInt32 += UInt32(r * 255.0) << 16
		colorAsUInt32 += UInt32(g * 255.0) << 8
		colorAsUInt32 += UInt32(b * 255.0)
		
		return UInt(colorAsUInt32)
	}
	
	/// SwifterSwift: Get color complementary (read-only, if applicable).
	public var complementary: UIColor? {
		return UIColor.init(complementaryFor: self)
	}
	
}

// MARK: - Initializers
public extension UIColor {
	
	/// SwifterSwift: Create UIColor from a complementary of a UIColor (if applicable).
	///
	/// - Parameter color: color of which opposite color is desired.
	public convenience init?(complementaryFor color: UIColor) {
		let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
		let convertColorToRGBSpace: ((_ color: UIColor) -> UIColor?) = { color -> UIColor? in
			if color.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
				let oldComponents = color.cgColor.components
				let components: [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
				let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
				let colorOut = UIColor(cgColor: colorRef!)
				return colorOut
			} else {
				return color
			}
		}
		
		let c = convertColorToRGBSpace(color)
		guard let componentColors = c?.cgColor.components else {
			return nil
		}
		
		let r: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
		let g: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
		let b: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255
		self.init(red: r, green: g, blue: b, alpha: 1.0)
	}
	
}
#endif
