//
//  ArrayExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


// MARK: - Methods (Integer)
public extension Array where Element: Integer {
	
	/// SwifterSwift: Sum of all elements in array.
	/// Returns: sum of the array's elements (Integer).
	public func sum() -> Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
	
}


// MARK: - Methods (FloatingPoint)
public extension Array where Element: FloatingPoint {
	
	/// SwifterSwift: Average of all elements in array.
	/// Returns: average of the array's elements (FloatingPoint).
	public func average() -> Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : reduce(0, +) / Element(count)
	}
	
	/// SwifterSwift: Sum of all elements in array.
	/// Returns: sum of the array's elements (FloatingPoint).
	public func sum() -> Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
	
}

// MARK: - Methods
public extension Array {
	
	/// SwifterSwift: Element at the given index if it exists.
	///
	/// - Parameter index: index of element.
	/// - Returns: optional element (if exists).
	public func item(at index: Int) -> Element? {
		guard startIndex...endIndex ~= index else { return nil }
		return self[index]
	}
	
	/// SwifterSwift: Remove last element from array and return it.
	///
	/// - Returns: last element in array (if applicable).
	@discardableResult public mutating func pop() -> Element? {
		return popLast()
	}
	
	/// SwifterSwift: Insert an element at the beginning of array.
	///
	/// - Parameter newElement: element to insert.
	public mutating func prepend(_ newElement: Element) {
		insert(newElement, at: 0)
	}
	
	/// SwifterSwift: Insert an element to the end of array.
	///
	/// - Parameter newElement: element to insert.
	public mutating func push(_ newElement: Element) {
		append(newElement)
	}
	
	/// SwifterSwift: Safely Swap values at index positions.
	///
	/// - Parameters:
	///   - index: index of first element.
	///   - otherIndex: index of other element.
	public mutating func safeSwap(from index: Int, to otherIndex: Int)  {
		guard index != otherIndex else {
			return
		}
		guard startIndex...endIndex ~= index else {
			return
		}
		guard startIndex...endIndex ~= otherIndex  else {
			return
		}
		Swift.swap(&self[index], &self[otherIndex])
	}
	
	/// SwifterSwift: Swap values at index positions.
	///
	/// - Parameters:
	///   - from: index of first element.
	///   - to: index of other element.
	public mutating func swap(from index: Int, to otherIndex: Int)  {
		Swift.swap(&self[index], &self[otherIndex])
	}
	
}


// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {
	
	/// SwifterSwift: Shuffle array. (Using Fisher-Yates Algorithm)
	public mutating func shuffle() {
		//http://stackoverflow.com/questions/37843647/shuffle-array-swift-3
		guard count > 1 else { return }
		for index in startIndex..<endIndex - 1 {
			let randomIndex = Int(arc4random_uniform(UInt32(endIndex - index))) + index
			if index != randomIndex { Swift.swap(&self[index], &self[randomIndex]) }
		}
	}
	
	/// SwifterSwift: Shuffled version of array. (Using Fisher-Yates Algorithm)
	/// Returns: the array with its elements shuffled.
	public func shuffled() -> [Element] {
		var array = self
		array.shuffle()
		return array
	}
	
	/// SwifterSwift: Check if array contains an array of elements.
	///
	/// - Parameter elements: array of elements to check.
	/// - Returns: true if array contains all given items.
	public func contains(_ elements: [Element]) -> Bool {
		guard !elements.isEmpty else { // elements array is empty
			return true
		}
		var found = true
		for element in elements {
			if !contains(element) {
				found = false
			}
		}
		return found
	}
	
	/// SwifterSwift: All indexes of specified item.
	///
	/// - Parameter item: item to check.
	/// - Returns: an array with all indexes of the given item.
	public func indexes(of item: Element) -> [Int] {
		var indexes: [Int] = []
		for index in startIndex..<endIndex {
			if self[index] == item {
				indexes.append(index)
			}
		}
		return indexes
	}
	
	/// SwifterSwift: Remove all instances of an item from array.
	///
	/// - Parameter item: item to remove.
	public mutating func removeAll(_ item: Element) {
		self = filter { $0 != item }
	}
	
	/// SwifterSwift: Remove all duplicate elements from Array.
	public mutating func removeDuplicates() {
		// Thanks to https://github.com/sairamkotha for improving the method
		self = reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
	}
	
	/// SwifterSwift: Return array with all duplicate elements removed.
	/// - Returns: An array of unique elements.
	public func duplicatesRemoved() -> [Element] {
		// Thanks to https://github.com/sairamkotha for improving the property
		return reduce([]){ ($0 as [Element]).contains($1) ? $0 : $0 + [$1] }
	}
	
	/// SwifterSwift: First index of a given item in an array.
	///
	/// - Parameter item: item to check.
	/// - Returns: first index of item in array (if exists).
	public func firstIndex(of item: Element) -> Int? {
		for (index, value) in lazy.enumerated() {
			if value == item { return index }
		}
		return nil
	}
	
	/// SwifterSwift: Last index of element in array.
	///
	/// - Parameter item: item to check.
	/// - Returns: last index of item in array (if exists).
	public func lastIndex(of item: Element) -> Int? {
		for (index, value) in lazy.enumerated().reversed() {
			if value == item { return index }
		}
		return nil
	}
	
}
