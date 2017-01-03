//
//  CollectionExtensions.swift
//  SwifterSwift
//
//  Created by Sergey Fedortsov on 19.12.16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


// MARK: - Methods
public extension Collection {
	
	private func indicesArray() -> [Self.Index] {
		var indices: [Self.Index] = []
		var index = self.startIndex
		while index != self.endIndex {
			indices.append(index)
			index = self.index(after: index)
		}
		return indices
	}
	
	/// SwifterSwift: performs `each` closure for each element of collection in parallel.
	///
	/// - Parameter each: closure to run for each element.
	public func forEachInParallel(_ each: (Self.Iterator.Element) -> ()) {
		let indices = indicesArray()
		
		DispatchQueue.concurrentPerform(iterations: indices.count) { (index) in
			let elementIndex = indices[index]
			each(self[elementIndex])
		}
	}
}

extension Collection where Indices.Iterator.Element == Index {
    
    /// SwifterSwift: safe protects the array from out of bounds by use of optional
    ///
    ///- Parameter index: index of element to access element.
    ///- Returns: an element if found at index else returns nil
    ///- Usage: array[safe: index]
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
