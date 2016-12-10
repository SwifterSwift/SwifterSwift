//
//  UISegmentedControlExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - Properties
public extension UISegmentedControl {
	
	/// SwifterSwift: Segments titles.
	public var segmentTitles: [String?] {
		get {
			var titles: [String?] = []
			var i = 0
			while i < numberOfSegments {
				titles.append(titleForSegment(at: i))
				i += 1
			}
			return titles
		}
		set {
			removeAllSegments()
			for (index, title) in newValue.enumerated() {
				insertSegment(withTitle: title, at: index, animated: false)
			}
		}
	}
	
	/// SwifterSwift: Segments images.
	public var segmentImages: [UIImage?] {
		get {
			var images: [UIImage?] = []
			var i = 0
			while i < numberOfSegments {
				images.append(imageForSegment(at: i))
				i += 1
			}
			return images
		}
		set {
			removeAllSegments()
			for (index, image) in newValue.enumerated() {
				insertSegment(with: image, at: index, animated: false)
			}
		}
	}
	
}
