//
//  DoubleExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 SwifterSwift
//

import CoreGraphics

// MARK: - Properties

public extension Double {
	
	/// SwifterSwift: Int.
	public var int: Int {
		return Int(self)
	}
	
	/// SwifterSwift: Float.
	public var float: Float {
		return Float(self)
	}
	
	/// SwifterSwift: CGFloat.
	public var cgFloat: CGFloat {
		return CGFloat(self)
	}
    
    /// SwifterSwift: Returns the current double (treated as meters) to kilometers.
    /// Based on Apple's [The Swift Programming Language (Swift 4.0.3) - Extensions](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html#//apple_ref/doc/uid/TP40014097-CH24-ID152)
    public var km: Double {
        return self / 1000.0
    }
    
    /// SwifterSwift: Returns the current double (treated as meters) to centimeters.
    /// Based on Apple's [The Swift Programming Language (Swift 4.0.3) - Extensions](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html#//apple_ref/doc/uid/TP40014097-CH24-ID152)
    public var cm: Double {
        return self * 100.0
    }
    
    /// SwifterSwift: Returns the current double (treated as meters) to millimeters.
    /// Based on Apple's [The Swift Programming Language (Swift 4.0.3) - Extensions](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html#//apple_ref/doc/uid/TP40014097-CH24-ID152)
    public var mm: Double {
        return self * 1000.0
    }
    
    /// SwifterSwift: Returns the current double (treated as meters) to feet.
    /// Based on Apple's [The Swift Programming Language (Swift 4.0.3) - Extensions](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html#//apple_ref/doc/uid/TP40014097-CH24-ID152)
    public var ft: Double {
        return self * 3.28084
    }
    
    /// SwifterSwift: Returns the current double (treated as meters) to miles.
    public var mi: Double {
        return self * 0.00062137
    }
    
    /// SwifterSwift: Returns the current double (treated as meters) to yards.
    public var yd: Double {
        return self * 1093.61
    }
    
    /// SwifterSwift: Returns the current double (treated as meters) to inches.
    public var inch: Double {
        return self * 39.3701
    }
	
}

// MARK: Methods

public extension Double {
    
    /// SwifterSwift: String representation of a double value (hours) as its duration in hours, minutes, and/or seconds.
    ///
    /// - Parameters:
    ///   - withSeconds: Determines if seconds is to be added. Defaults to true
    ///   - separator: String to serve as the separator between hours, minutes, and/or seconds.
    ///                The default value of "hms" will have an output of 00h 00m 00s.
    /// - Returns: String formatted to hours, minutes, seconds based on derived value from double.
    public func toDurationString(withSeconds: Bool = true, separatedBy separator: String = "hms") -> String {
        let totalSeconds = Int(self * 3600)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = (totalSeconds % 3600) % 60
        var format = ""
        
        if separator == "hms" {
            format = "%02ih %02im" + (withSeconds ? " %02is" : "")
        } else {
            format = "%02i\(separator)%02i" + (withSeconds ? "\(separator)%02i" : "")
        }
        
        return String(format: format,
                      hours,
                      minutes < 60 ? minutes : (minutes % 60),
                      seconds < 60 ? seconds : (seconds % 60))
    }
    
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
public func ** (lhs: Double, rhs: Double) -> Double {
	// http://nshipster.com/swift-operators/
	return pow(lhs, rhs)
}

prefix operator √
/// SwifterSwift: Square root of double.
///
/// - Parameter double: double value to find square root for.
/// - Returns: square root of given double.
public prefix func √ (double: Double) -> Double {
	// http://nshipster.com/swift-operators/
	return sqrt(double)
}
