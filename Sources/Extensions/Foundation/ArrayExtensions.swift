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
	///
	///		[1, 2, 3, 4, 5].sum -> 15
	///
	/// - Returns: sum of the array's elements.
	public func sum() -> Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
	
}


// MARK: - Methods (FloatingPoint)
public extension Array where Element: FloatingPoint {
	
	/// SwifterSwift: Average of all elements in array.
	///
	///		[1.2, 2.3, 4.5, 3.4, 4.5].average = 3.18
	///
	/// - Returns: average of the array's elements.
	public func average() -> Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : reduce(0, +) / Element(count)
	}

	/// SwifterSwift: Sum of all elements in array.
	///
	///		[1.2, 2.3, 4.5, 3.4, 4.5].sum -> 15.9
	///
	/// - Returns: sum of the array's elements.
	public func sum() -> Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return reduce(0, +)
	}
	
}

// MARK: - Methods
public extension Array {
	
	/// SwifterSwift: Element at the given index if it exists.
	///
	///		[1, 2, 3, 4, 5].item(at: 2) -> 3
	///		[1.2, 2.3, 4.5, 3.4, 4.5].item(at: 3) -> 3.4
	///		["h", "e", "l", "l", "o"].item(at: 10) -> nil
	///		// It also works for other types!
	///
	/// - Parameter index: index of element.
	/// - Returns: optional element (if exists).
	public func item(at index: Int) -> Element? {
		guard startIndex..<endIndex ~= index else { return nil }
		return self[index]
	}
	
	/// SwifterSwift: Remove last element from array and return it.
	///
	///		[1, 2, 3, 4, 5].pop() // returns 5 and remove it from the array.
	///		[].pop() // returns nil since the array is empty.
	///		// It also works for other types!
	///
	/// - Returns: last element in array (if applicable).
	@discardableResult public mutating func pop() -> Element? {
		return popLast()
	}
	
	/// SwifterSwift: Insert an element at the beginning of array.
	///
	///		[2, 3, 4, 5].prepend(1) -> [1, 2, 3, 4, 5]
	///		["e", "l", "l", "o"].prepend("h") -> ["h", "e", "l", "l", "o"]
	///		// It also works for other types!
	///
	/// - Parameter newElement: element to insert.
	public mutating func prepend(_ newElement: Element) {
		insert(newElement, at: 0)
	}
	
	/// SwifterSwift: Insert an element to the end of array.
	///
	///		[1, 2, 3, 4].push(5) -> [1, 2, 3, 4, 5]
	///		["h", "e", "l", "l"].push("o") -> ["h", "e", "l", "l", "o"]
	///		// It also works for other types!
	///
	/// - Parameter newElement: element to insert.
	public mutating func push(_ newElement: Element) {
		append(newElement)
	}
	
	/// SwifterSwift: Safely Swap values at index positions.
	///
	///		[1, 2, 3, 4, 5].safeSwap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
	///		["h", "e", "l", "l", "o"].safeSwap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
	///		// It also works for other types!
	///
	/// - Parameters:
	///   - index: index of first element.
	///   - otherIndex: index of other element.
	public mutating func safeSwap(from index: Int, to otherIndex: Int)  {
		guard index != otherIndex,
              startIndex..<endIndex ~= index,
              startIndex..<endIndex ~= otherIndex else { return }
		Swift.swap(&self[index], &self[otherIndex])
	}
	
	/// SwifterSwift: Swap values at index positions.
	///
	///		[1, 2, 3, 4, 5].swap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
	///		["h", "e", "l", "l", "o"].swap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
	///		// It also works for other types!
	///
	/// - Parameters:
	///   - index: index of first element.
	///   - otherIndex: index of other element.
	public mutating func swap(from index: Int, to otherIndex: Int)  {
		Swift.swap(&self[index], &self[otherIndex])
	}
    
    /// SwifterSwift: Get first index where condition is met.
	///
	///		[1, 7, 1, 2, 4, 1, 6].firstIndex { $0 % 2 == 0 } -> 3
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: first index where the specified condition evaluates to true. (optional)
    public func firstIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated() {
            if try condition(value) { return index }
        }
        return nil
    }
    
    /// SwifterSwift: Get last index where condition is met.
	///
	///		[1, 7, 1, 2, 4, 1, 8].lastIndex { $0 % 2 == 0 } -> 6
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: last index where the specified condition evaluates to true. (optional)
    public func lastIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated().reversed() {
            if try condition(value) { return index }
        }
        return nil
    }
    
    /// SwifterSwift: Get all indices where condition is met.
	///
	///		[1, 7, 1, 2, 4, 1, 8].indices(where: { $0 == 1 }) -> [0, 2, 5]
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: all indices where the specified condition evaluates to true. (optional)
    public func indices(where condition: (Element) throws -> Bool) rethrows -> [Int]? {
        var indicies: [Int] = []
        for (index, value) in lazy.enumerated() {
            if try condition(value) { indicies.append(index) }
        }
        return indicies.isEmpty ? nil : indicies
    }
    
    /// SwifterSwift: Check if all elements in array match a conditon.
	///
	///		[2, 2, 4].all(matching: {$0 % 2 == 0}) -> true
	///		[1,2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    public func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }
    
    /// SwifterSwift: Check if no elements in array match a conditon.
	///
	///		[2, 2, 4].none(matching: {$0 % 2 == 0}) -> false
	///		[1, 3, 5, 7].none(matching: {$0 % 2 == 0}) -> true
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    public func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }
    
    /// SwifterSwift: Get last element that satisfies a conditon.
	///
	///		[2, 2, 4, 7].last(where: {$0 % 2 == 0}) -> 4
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: the last element in the array matching the specified condition. (optional)
    public func last(where condition: (Element) throws -> Bool) rethrows -> Element? {
        for element in reversed() {
          if try condition(element) { return element }
        }
        return nil
    }
    
    /// SwifterSwift: Filter elements based on a rejection condition.
	///
	///		[2, 2, 4, 7].reject(where: {$0 % 2 == 0}) -> [7]
	///		// It also works for other types!
	///
	/// - Parameter condition: to evaluate the exclusion of an element from the array.
    /// - Returns: the array with rejected values filtered from it.
    public func reject(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { return try !condition($0) }
    }
    
    /// SwifterSwift: Get element count based on condition.
	///
	///		[2, 2, 4, 7].count(where: {$0 % 2 == 0}) -> 3
	///		// It also works for all other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: number of times the condition evaluated to true.
    public func count(where condition: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try condition(element) { count += 1 }
        }
        return count
    }
    
    /// SwifterSwift: Iterate over a collection in reverse order. (right to left)
	///
	///		[0, 2, 4, 7].forEachReversed({ print($0)}) -> //Order of print: 7,4,2,0
	///		// It also works for other types!
	///
	/// - Parameter body: a closure that takes an element of the array as a parameter.
    public func forEachReversed(_ body: (Element) throws -> Void) rethrows {
        try reversed().forEach { try body($0) }
    }
	
	/// SwifterSwift: Calls given closure with each element where condition is true.
	///
	///		[0, 2, 4, 7].forEach( where: {$0 % 2 == 0}, body: { print($0)}) -> //print: 0, 2, 4
	///		// It also works for all other types!
	///
	/// - Parameters:
    ///   - condition: condition to evaluate each element against.
    ///   - body: a closure that takes an element of the array as a parameter.
    public func forEach(where condition: (Element) throws -> Bool, body: (Element) throws -> Void) rethrows {
        for element in self where try condition(element) {
           try body(element)
        }
    }
	
	/// SwifterSwift: Reduces an array while returning each interim combination.
	///
	/// - Parameters:
    ///   - initial: initial value.
    ///   - next: closure that combines the accumulating value and next element of the array.
    /// - Returns: an array of the final accumulated value and each interim combination.
    public func accumulate<U>(initial: U, next: (U, Element) throws -> U) rethrows -> [U] {
        var runningTotal = initial
        return try map { element in
            runningTotal = try next(runningTotal, element)
            return runningTotal
        }
    }
    
    /// SwifterSwift: Filtered and map in a single operation.
	///
	/// - Parameters:
    ///   - isIncluded: condition of inclusion to evaluate each element against.
    ///   - transform: transform element function to evaluate every element.
    /// - Returns: Return an filtered and mapped array.
    public func filtered<T>(_ isIncluded: (Element) throws -> Bool, map transform: (Element) throws -> T) rethrows ->  [T] {
        return try flatMap({
            if try isIncluded($0) {
                return try transform($0)
            }
            return nil
        })
    }

    
    /// SwifterSwift: Keep elements of Array while condition is true.
	///
	///		[0, 2, 4, 7].keep( where: {$0 % 2 == 0}) -> [0, 2, 4]
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    public mutating func keep(while condition: (Element) throws -> Bool) rethrows {
        for (index, element) in lazy.enumerated() {
            if try !condition(element) {
                self = Array(self[startIndex..<index])
                break
            }
        }
    }
    
    /// SwifterSwift: Take element of Array while condition is true.
	///
	///		[0, 2, 4, 7, 6, 8].take( where: {$0 % 2 == 0}) -> [0, 2, 4]
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to evaluate each element against.
    /// - Returns: All elements up until condition evaluates to false.
    public func take(while condition: (Element) throws -> Bool) rethrows -> [Element] {
        for (index, element) in lazy.enumerated() {
            if try !condition(element) {
                return Array(self[startIndex..<index])
            }
        }
        return self
    }
    
    /// SwifterSwift: Skip elements of Array while condition is true.
	///
	///		[0, 2, 4, 7, 6, 8].skip( where: {$0 % 2 == 0}) -> [6, 8]
	///		// It also works for other types!
	///
	/// - Parameter condition: condition to eveluate each element against.
    /// - Returns: All elements after the condition evaluates to false.
    public func skip(while condition: (Element) throws-> Bool) rethrows -> [Element] {
        for (index, element) in lazy.enumerated() {
            if try !condition(element) {
                return Array(self[index..<endIndex])
            }
        }
        return [Element]()
    }
    
    /// SwifterSwift: Calls given closure with an array of size of the parameter slice where condition is true.
	///
	/// - Parameters:
    ///   - slice: size of array in each interation.
    ///   - body: a closure that takes an array of slice size as a parameter.
    public func forEach(slice: Int,  body: ([Element]) throws -> Void) rethrows {
        guard slice > 0, !isEmpty else { return }
        
        var value : Int = 0
        while value < count {
            try body(Array(self[Swift.max(value,startIndex)..<Swift.min(value + slice, endIndex)]))
            value += slice
        }
    }
    
    
    /// SwifterSwift: Returns an array of slices of length "size" from the array.  If array can't be split evenly, the final slice will be the remaining elements.
	///
	/// - Parameters:
    ///   - size: The size of the slices to be returned.
    public func group(by size: Int) -> [[Element]]? {
        //Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var value : Int = 0
        var slices : [[Element]] = []
        while value < count {
            slices.append(Array(self[Swift.max(value,startIndex)..<Swift.min(value + size, endIndex)]))
            value += size
        }
        return slices
    }
    
    /// SwifterSwift: Group the elements of the array in a dictionary.
	///
	/// - Parameter getKey: Clousure to define the key for each element.
    /// - Returns: A dictionary with values grouped with keys.
    public func groupByKey<K: Hashable>(keyForValue: (_ element: Element) throws -> K) rethrows -> [K: [Element]] {
        var group : [K: [Element]] = [:]
        for value in self {
            let key = try keyForValue(value)
            group[key] = (group[key] ?? []) + [value]
        }
        return group
    }
    
    /// SwifterSwift: Returns a new rotated array by the given places.
    ///
    /// - Parameter places: Number of places that the array be rotated. If the value is positive the end becomes the start, if it negative it's that start becom the end.
    /// - Returns: The new rotated array
    public func rotated(by places: Int) -> [Element] {
        //Inspired by: https://ruby-doc.org/core-2.2.0/Array.html#method-i-rotate
        guard places != 0 && places < count else {
            return self
        }
        var array : [Element] = self
        if places > 0 {
            let range = (array.count - places)..<array.endIndex
            let slice = array[range]
            array.removeSubrange(range)
            array.insert(contentsOf: slice, at: 0)
        } else {
            let range = array.startIndex..<(places * -1)
            let slice = array[range]
            array.removeSubrange(range)
            array.append(contentsOf: slice)
        }
        return array
    }
    
    /// SwifterSwift: Rotate the array by the given places.
    ///
    /// - Parameter places: Number of places that the array should be rotated. If the value is positive the end becomes the start, if it negative it's that start becom the end.
    public mutating func rotate(by places: Int) {
        self = rotated(by: places)
    }
}


// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {
	
	/// SwifterSwift: Shuffle array. (Using Fisher-Yates Algorithm)
	///
	///		[1, 2, 3, 4, 5].shuffle() // shuffles array
	///		// It also works for other types!
	///
	public mutating func shuffle() {
		//http://stackoverflow.com/questions/37843647/shuffle-array-swift-3
		guard count > 1 else { return }
		for index in startIndex..<endIndex - 1 {
			let randomIndex = Int(arc4random_uniform(UInt32(endIndex - index))) + index
			if index != randomIndex { Swift.swap(&self[index], &self[randomIndex]) }
		}
	}

	/// SwifterSwift: Shuffled version of array. (Using Fisher-Yates Algorithm)
	///
	///		[1, 2, 3, 4, 5].shuffled // return a shuffled version from given array e.g. [2, 4, 1, 3, 5].
	///		// It also works for other types!
	///
	/// - Returns: the array with its elements shuffled.
	public func shuffled() -> [Element] {
		var array = self
		array.shuffle()
		return array
	}
	
	/// SwifterSwift: Check if array contains an array of elements.
	///
	///		[1, 2, 3, 4, 5].contains([1, 2]) -> true
	///		[1.2, 2.3, 4.5, 3.4, 4.5].contains([2, 6]) -> false
	///		["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
	///		// It also works for other types!
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
	///		[1, 2, 2, 3, 4, 2, 5].indexes(of 2) -> [1, 2, 5]
	///		[1.2, 2.3, 4.5, 3.4, 4.5].indexes(of 2.3) -> [1]
	///		["h", "e", "l", "l", "o"].indexes(of "l") -> [2, 3]
	///		// It also works for other types!
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
	///		[1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
	///		["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
	///		// It also works for other types!
	///
	/// - Parameter item: item to remove.
	public mutating func removeAll(_ item: Element) {
		self = filter { $0 != item }
	}
    
    /// SwifterSwift: Remove all instances contained in items parameter from array.
	///
	///		[1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
	///		["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
	///		// It also works for other types!
	///
	/// - Parameter items: items to remove.
    public mutating func removeAll(_ items: [Element]) {
		guard !items.isEmpty else { return }
		self = filter { !items.contains($0) }
	}
	
	/// SwifterSwift: Remove all duplicate elements from Array.
	///
	///		[1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
	///		["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
	///		// It also works for other types!
	///
	public mutating func removeDuplicates() {
		// Thanks to https://github.com/sairamkotha for improving the method
		self = reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
	}

	/// SwifterSwift: Return array with all duplicate elements removed.
	///
	///		[1, 2, 2, 3, 4, 5, 5].duplicatesRemoved() -> [ 2, 5]
	///		["h", "e", "l", "l", "o"]. duplicatesRemoved() -> ["l"]
	///		// It also works for other types!
	///
	/// - Returns: an array of unique elements.
	public func duplicatesRemoved() -> [Element] {
		// Thanks to https://github.com/sairamkotha for improving the property
		return reduce([]){ ($0 as [Element]).contains($1) ? $0 : $0 + [$1] }
	}
	
	/// SwifterSwift: First index of a given item in an array.
	///
	///		[1, 2, 2, 3, 4, 2, 5].firstIndex(of 2) -> 1
	///		[1.2, 2.3, 4.5, 3.4, 4.5].firstIndex(of 6.5) -> nil
	///		["h", "e", "l", "l", "o"].firstIndex(of "l") -> 2
	///		// It also works for other types!
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
	///		[1, 2, 2, 3, 4, 2, 5].lastIndex(of 2) -> 5
	///		[1.2, 2.3, 4.5, 3.4, 4.5].lastIndex(of 6.5) -> nil
	///		["h", "e", "l", "l", "o"].lastIndex(of "l") -> 3
	///		// It also works for other types!
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
