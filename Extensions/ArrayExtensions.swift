//
//  ArrayExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

public extension Collection where Iterator.Element == Int, Index == Int {
	/// Return average of all elements in array.
	public var average: Double {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : Double(reduce(0, +)) / Double(endIndex-startIndex)
	}
}

public extension Array where Element: FloatingPoint {
	/// Return average of all elements in array.
	public var average: Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : reduce(0, +) / Element(count)
	}
}

public extension Array where Element: Equatable {
	/// Return an array of all items that are in self and not in given array.
	public func difference(from array: [Element]) -> [Element] {
		return self.filter {
			return self.contains($0 as Element) && !array.contains($0 as Element)
		}
	}
}

extension Array {
	/// Return first index of item in array.
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
}

public extension Array where Element: Equatable {
	/// Return all indexes of specified item.
	public func indexes(of item: Element) -> [Int] {
		var indexes: [Int] = []
		for index in 0..<self.count {
			if self[index] == item {
				indexes.append(index)
			}
		}
		return indexes
	}
}

extension Array {
	/// Return last index of element in array.
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
	
	/// Remove last item from array and return it.
	public mutating func pop() -> Element? {
		guard self.count > 0 else {
			return nil
		}
		return removeLast()
	}
	
	/// Prepend an element to array.
	public mutating func prepend(_ newItem: Element) {
		self.insert(newItem, at: 0)
	}
	
	/// Append an item to array.
	public mutating func push(_ newItem: Element) {
		return append(newItem)
	}
	
	/// Return random item from array.
	public var randomItem: Element {
		let index = Int(arc4random_uniform(UInt32(self.count)))
		return self[index]
	}
}

public extension Array where Element: Equatable {
	/// Remove all instances of an item from array.
	public mutating func removeAll(_ item: Element) {
		self = self.filter() { $0 != item }
	}
	
	/// Remove duplicates from array.
	public mutating func removeDuplicates() {
		var result: [Element] = []
		for value in self {
			if result.contains(value) == false {
				result.append(value)
			}
		}
		self = result
	}
}


public extension Array {
	/// Shuffle array.
	public mutating func shuffle() {
		// https://gist.github.com/ijoshsmith/5e3c7d8c2099a3fe8dc3
		for _ in 0..<10 {
			sort { (_,_) in arc4random() < arc4random() }
		}
	}
	
	/// Return shuffled version of array.
	public var shuffled: [Element] {
		var arr = self
		for _ in 0..<10 {
			arr.sort { (_,_) in arc4random() < arc4random() }
		}
		return arr
	}
}

public extension Array where Element: Integer {
	/// Return sum of all elements in array.
	public var sum: Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
}

public extension Array where Element: FloatingPoint {
	/// Return sum of all elements in array.
	public var sum: Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
}

public extension Array where Element: Equatable {
	/// Return unique values of array.
	public var uniqueValues: [Element] {
		var result: [Element] = []
		for value in self {
			if result.contains(value) == false {
				result.append(value)
			}
		}
		return result
	}
}
