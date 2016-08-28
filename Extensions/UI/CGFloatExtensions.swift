//
//  CGFloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension CGFloat {
	/// Return absolute of double value.
	public var abs: CGFloat {
		return Swift.abs(self)
	}
	
	/// Return ceil of CGFloat value.
	public var ceil: CGFloat {
		return Foundation.ceil(self)
	}
	
	/// Return radian value of degree input.
	public var degreesToRadians: CGFloat {
		return CGFloat(M_PI) * self / 180.0
	}
	
	/// Return random CGFloat value between two CGFloat values.
	public static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
		let delta = max - min
		return min + CGFloat(arc4random_uniform(UInt32(delta)))
	}
	
	/// Return floor of double value.
	public var floor: CGFloat {
		return Foundation.floor(self)
	}
	
	/// Return degree value of radian input.
	public var radiansToDegrees: CGFloat {
		return self * 180 / CGFloat(M_PI)
	}
}
