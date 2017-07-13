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
	/// - Returns: average of the array's elements.
	public func average() -> Element {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : reduce(0, +) / Element(count)
	}

	/// SwifterSwift: Sum of all elements in array.
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
	/// - Parameter index: index of element.
	/// - Returns: optional element (if exists).
	public func item(at index: Int) -> Element? {
		guard startIndex..<endIndex ~= index else { return nil }
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
		guard index != otherIndex,
              startIndex..<endIndex ~= index,
              startIndex..<endIndex ~= otherIndex else { return }
        
		Swift.swap(&self[index], &self[otherIndex])
	}
	
	/// SwifterSwift: Swap values at index positions.
	///
	/// - Parameters:
	///   - index: index of first element.
	///   - otherIndex: index of other element.
	public mutating func swap(from index: Int, to otherIndex: Int)  {
		Swift.swap(&self[index], &self[otherIndex])
	}
    
    /// SwifterSwift: Get first index where condition is met.
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
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    public func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }
    
    /// SwifterSwift: Check if no elements in array match a conditon.
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    public func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }
    
    /// SwifterSwift: Get last element that satisfies a conditon.
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
    /// - Parameter condition: to evaluate the exclusion of an element from the array.
    /// - Returns: the array with rejected values filtered from it.
    public func reject(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { return try !condition($0) }
    }
    
    /// SwifterSwift: Get element count based on condition.
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
    /// - Parameter body: a closure that takes an element of the array as a parameter.
    public func forEachReversed(_ body: (Element) throws -> Void) rethrows {
        try reversed().forEach { try body($0) }
    }
	
	/// SwifterSwift: Calls given closure with each element where condition is true.
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
	///
	/// - Returns: the array with its elements shuffled.
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
    
    /// SwifterSwift: Remove all instances contained in items parameter from array.
    ///
    /// - Parameter items: items to remove.
    public mutating func removeAll(_ items: [Element]) {
		guard !items.isEmpty else { return }
		self = filter { !items.contains($0) }
	}
	
	/// SwifterSwift: Remove all duplicate elements from Array.
	public mutating func removeDuplicates() {
		// Thanks to https://github.com/sairamkotha for improving the method
		self = reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
	}

	/// SwifterSwift: Return array with all duplicate elements removed.
	///
	/// - Returns: an array of unique elements.
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

}
