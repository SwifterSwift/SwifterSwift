//
//  UIKitDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 7/21/17.
//
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - Deprecated
extension UIColor {
	
	@available(*, deprecated: 3.1.0, message: "Use rgbComponenets.red instead", renamed: "rgbComponenets.red")
	/// SwifterSwift: Red component of UIColor (read-only).
	public var redComponent: Int {
		let red = CIColor(color: self).red
		return Int(red * CGFloat(255.0))
	}
	
	@available(*, deprecated: 3.1.0, message: "Use rgbComponenets.green instead", renamed: "rgbComponenets.green")
	/// SwifterSwift: Green component of UIColor (read-only).
	public var greenComponent: Int {
		var green: CGFloat = 0.0
		getRed(nil, green: &green, blue: nil, alpha: nil)
		return Int(green * CGFloat(255.0))
	}
	
	@available(*, deprecated: 3.1.0, message: "Use rgbComponenets.blue instead", renamed: "rgbComponenets.blue")
	/// SwifterSwift: blue component of UIColor (read-only).
	public var blueComponent: Int {
		var blue: CGFloat = 0.0
		getRed(nil, green: nil, blue: &blue, alpha: nil)
		return Int(blue * CGFloat(255.0))
	}
	
}
#endif
