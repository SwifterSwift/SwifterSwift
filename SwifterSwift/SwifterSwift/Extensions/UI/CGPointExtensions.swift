//
//  CGPointExtensions.swift
//  SSTests
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension CGPoint {

	/// SwifterSwift: Distance from another CGPoint.
	///
	/// - Parameter point: CGPoint to get distance from.
	/// - Returns: Distance between self and given CGPoint.
	public func distance(from point: CGPoint) -> CGFloat {
		return CGPoint.distance(from: self, to: point)
	}

	/// SwifterSwift: Distance between two CGPoints.
	///
	/// - Parameters:
	///   - point1: first CGPoint.
	///   - point2: second CGPoint.
	/// - Returns: distance between the two given CGPoints.
	public static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
		// http://stackoverflow.com/questions/6416101/calculate-the-distance-between-two-cgpoints
		return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
	}

}


// MARK: - Operators
public extension CGPoint {

	/// SwifterSwift: Add two CGPoints.
	///
	/// - Parameters:
	///   - lhs: CGPoint to add to.
	///   - rhs: CGPoint to add.
	/// - Returns: result of addition of the two given CGPoints.
	public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}

	/// SwifterSwift: Subtract two CGPoints.
	///
	/// - Parameters:
	///   - lhs: CGPoint to subtract from.
	///   - rhs: CGPoint to subtract.
	/// - Returns: result of subtract of the two given CGPoints.
	public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
		return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}

	/// SwifterSwift: Multiply a CGPoint with a scalar
	///
	/// - Parameters:
	///   - point: CGPoint to multiply.
	///   - scalar: scalar value.
	/// - Returns: result of multiplication of the given CGPoint with the scalar.
	public static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
		return CGPoint(x: point.x * scalar, y: point.y * scalar)
	}

	/// SwifterSwift: Multiply a CGPoint with a scalar
	///
	/// - Parameters:
	///   - scalar: scalar value.
	///   - point: CGPoint to multiply.
	/// - Returns: result of multiplication of the given CGPoint with the scalar.
	public static func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
		return CGPoint(x: point.x * scalar, y: point.y * scalar)
	}

}
