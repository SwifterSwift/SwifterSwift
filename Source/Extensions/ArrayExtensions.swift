//
//  ArrayExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


// MARK: - Properties
public extension Array {
	
	/// SwifterSwift: Random item from array.
	public var randomItem: Element {
		let index = Int(arc4random_uniform(UInt32(self.count)))
		return self[index]
	}
	
	/// SwifterSwift: Shuffled version of array.
	public var shuffled: [Element] {
		var arr = self
		for _ in 0..<10 {
			arr.sort { (_,_) in arc4random() < arc4random() }
		}
		return arr
	}
	
}


// MARK: - Properties (Integer)
public extension Collection where Iterator.Element == Int, Index == Int {
	
	/// SwifterSwift: Average of all elements in array.
	public var average: Double {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : Double(reduce(0, +)) / Double(endIndex-startIndex)
	}
	
}


// MARK: - Properties (Integer)
public extension Array where Element: Integer {
	
	/// SwifterSwift: Sum of all elements in array.
	public var sum: Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
	
}


// MARK: - Properties (FloatingPoint)
public extension Array where Element: FloatingPoint {
	
	/// SwifterSwift: Average of all elements in array.
	public var average: Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : reduce(0, +) / Element(count)
	}
	
	/// SwifterSwift: Sum of all elements in array.
	public var sum: Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
	
}


// MARK: - Properties (Equatable)
public extension Array where Element: Equatable {
	
	/// SwifterSwift: Array with all duplicates removed from it.
	public var withoutDuplicates: [Element] {
		// Thanks to https://github.com/sairamkotha for improving the preperty
		return reduce([]){ ($0 as [Element]).contains($1) ? $0 : $0 + [$1] }
	}
	
}


// MARK: - Methods
public extension Array {
	
	/// SwifterSwift: Element at the given index if it exists.
	///
	/// - Parameter index: index of element.
	/// - Returns: optional element (if exists).
	public func item(at index: Int) -> Element? {
		guard index >= 0 && index < count else { return nil }
		return self[index]
	}
	
	/// SwifterSwift: First index of a given item in an array.
	///
	/// - Parameter item: item to check.
	/// - Returns: first index of item in array (if exists).
	public func firstIndex <Item: Equatable> (of item: Item) -> Int? {
		if item is Element {
			for (index, value) in self.lazy.enumerated() {
				if value as! Item == item {
					return index
				}
			}
			return nil
		}
		return nil
	}
	
	/// SwifterSwift: Last index of element in array.
	///
	/// - Parameter item: item to check.
	/// - Returns: last index of item in array (if exists).
	public func lastIndex <Item: Equatable> (of item: Item) -> Int? {
		if item is Element {
			for (index, value) in self.reversed().lazy.enumerated() {
				if value as! Item == item {
					return count - 1 - index
				}
			}
			return nil
		}
		return nil
	}
	
	/// SwifterSwift: Remove last element from array and return it.
	///
	/// - Returns: last elemets in array (if applicable).
	@discardableResult public mutating func pop() -> Element? {
		guard self.count > 0 else {
			return nil
		}
		return removeLast()
	}
	
	/// SwifterSwift: Insert an element at the beginning of array.
	///
	/// - Parameter newElement: element to insert.
	public mutating func prepend(_ newElement: Element) {
		self.insert(newElement, at: 0)
	}
	
	/// SwifterSwift: Insert an element to the end of array.
	///
	/// - Parameter newElement: element to insert.
	public mutating func push(_ newElement: Element) {
		return append(newElement)
	}
	
	/// SwifterSwift: Shuffle array.
	public mutating func shuffle() {
		// https://gist.github.com/ijoshsmith/5e3c7d8c2099a3fe8dc3
		for _ in 0..<10 {
			sort { (_,_) in arc4random() < arc4random() }
		}
	}
	
}


// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {
	
	/// SwifterSwift: Check if array contains an array of elements.
	///
	/// - Parameter elements: array of elements to check.
	/// - Returns: true if array contains all given items.
	public func contains(_ elements: [Element]) -> Bool {
		guard !elements.isEmpty else { // elements array is empty
			return false
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
		for index in 0..<self.count {
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
		self = self.filter { $0 != item }
	}
	
	/// SwifterSwift: Remove all duplicates from array.
	public mutating func removeDuplicates() {
		// Thanks to https://github.com/sairamkotha for improving the method
		self = reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
	}
	
}
