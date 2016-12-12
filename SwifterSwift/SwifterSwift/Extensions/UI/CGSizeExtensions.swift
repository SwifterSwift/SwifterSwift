//
//  CGSizeExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - Methods
public extension CGSize {
	
	/// SwifterSwift: Aspect fit CGSize.
	///
	/// - Parameter boundingSize: bounding size to fit self to.
	/// - Returns: self fitted into given bounding size
	public func aspectFit(to boundingSize: CGSize) -> CGSize {
		let minRatio = min(boundingSize.width / width, boundingSize.height / height)
		return CGSize(width: width * minRatio, height: height * minRatio)
	}
	
	/// SwifterSwift: Aspect fill CGSize.
	///
	/// - Parameter boundingSize: bounding size to fill self to.
	/// - Returns: self filled into given bounding size
	public func aspectFill(to boundingSize: CGSize) -> CGSize {
		let minRatio = max(boundingSize.width / width, boundingSize.height / height)
		return CGSize(width: width * minRatio, height: height * minRatio)
	}
	
}
