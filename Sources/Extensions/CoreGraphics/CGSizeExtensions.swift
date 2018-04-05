//
//  CGSizeExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Methods
public extension CGSize {

	/// SwifterSwift: Aspect fit CGSize.
	///
	///     let rect = CGSize(width: 120, height: 80)
	///     let parentRect  = CGSize(width: 100, height: 50)
	///     let newRect = rect.aspectFit(to: parentRect)
	///     //newRect.width = 75 , newRect = 50
	///
	/// - Parameter boundingSize: bounding size to fit self to.
	/// - Returns: self fitted into given bounding size
	public func aspectFit(to boundingSize: CGSize) -> CGSize {
		let minRatio = min(boundingSize.width / width, boundingSize.height / height)
		return CGSize(width: width * minRatio, height: height * minRatio)
	}

	/// SwifterSwift: Aspect fill CGSize.
	///
	///     let rect = CGSize(width: 20, height: 120)
	///     let parentRect  = CGSize(width: 100, height: 60)
	///     let newRect = rect.aspectFit(to: parentRect)
	///     //newRect.width = 100 , newRect = 60
	///
	/// - Parameter boundingSize: bounding size to fill self to.
	/// - Returns: self filled into given bounding size
	public func aspectFill(to boundingSize: CGSize) -> CGSize {
		let minRatio = max(boundingSize.width / width, boundingSize.height / height)
		let aWidth = min(width * minRatio, boundingSize.width)
		let aHeight = min(height * minRatio, boundingSize.height)
		return CGSize(width: aWidth, height: aHeight)
	}

}
#endif
