//
//  ArrayExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Methods
public extension Array {

	/// SwifterSwift: Insert an element at the beginning of array.
	///
	///		[2, 3, 4, 5].prepend(1) -> [1, 2, 3, 4, 5]
	///		["e", "l", "l", "o"].prepend("h") -> ["h", "e", "l", "l", "o"]
	///
	/// - Parameter newElement: element to insert.
	public mutating func prepend(_ newElement: Element) {
		insert(newElement, at: 0)
	}

	/// SwifterSwift: Safely Swap values at index positions.
	///
	///		[1, 2, 3, 4, 5].safeSwap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
	///		["h", "e", "l", "l", "o"].safeSwap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
	///
	/// - Parameters:
	///   - index: index of first element.
	///   - otherIndex: index of other element.
	public mutating func safeSwap(from index: Index, to otherIndex: Index) {
		guard index != otherIndex,
			startIndex..<endIndex ~= index,
			startIndex..<endIndex ~= otherIndex else { return }
		swapAt(index, otherIndex)
	}

	/// SwifterSwift: Keep elements of Array while condition is true.
	///
	///		[0, 2, 4, 7].keep( where: {$0 % 2 == 0}) -> [0, 2, 4]
	///
	/// - Parameter condition: condition to evaluate each element against.
	/// - Returns: self after applying provided condition.
	/// - Throws: provided condition exception.
	@discardableResult
    public mutating func keep(while condition: (Element) throws -> Bool) rethrows -> [Element] {
		for (index, element) in lazy.enumerated() where try !condition(element) {
			self = Array(self[startIndex..<index])
			break
		}
		return self
	}

	/// SwifterSwift: Take element of Array while condition is true.
	///
	///		[0, 2, 4, 7, 6, 8].take( where: {$0 % 2 == 0}) -> [0, 2, 4]
	///
	/// - Parameter condition: condition to evaluate each element against.
	/// - Returns: All elements up until condition evaluates to false.
	public func take(while condition: (Element) throws -> Bool) rethrows -> [Element] {
		for (index, element) in lazy.enumerated() where try !condition(element) {
			return Array(self[startIndex..<index])
		}
		return self
	}

	/// SwifterSwift: Skip elements of Array while condition is true.
	///
	///		[0, 2, 4, 7, 6, 8].skip( where: {$0 % 2 == 0}) -> [6, 8]
	///
	/// - Parameter condition: condition to evaluate each element against.
	/// - Returns: All elements after the condition evaluates to false.
	public func skip(while condition: (Element) throws-> Bool) rethrows -> [Element] {
		for (index, element) in lazy.enumerated() where try !condition(element) {
			return Array(self[index..<endIndex])
		}
		return [Element]()
	}

	/// SwifterSwift: Separates an array into 2 arrays based on a predicate.
	///
	///     [0, 1, 2, 3, 4, 5].divided { $0 % 2 == 0 } -> ( [0, 2, 4], [1, 3, 5] )
	///
	/// - Parameter condition: condition to evaluate each element against.
	/// - Returns: Two arrays, the first containing the elements for which the specified condition evaluates to true, the second containing the rest.
	public func divided(by condition: (Element) throws -> Bool) rethrows -> (matching: [Element], nonMatching: [Element]) {
		//Inspired by: http://ruby-doc.org/core-2.5.0/Enumerable.html#method-i-partition
		var matching = [Element]()
		var nonMatching = [Element]()
		for element in self {
			if try condition(element) {
				matching.append(element)
			} else {
				nonMatching.append(element)
			}
		}
		return (matching, nonMatching)
	}

	/// SwifterSwift: Returns a new rotated array by the given places.
	///
	///     [1, 2, 3, 4].rotated(by: 1) -> [4,1,2,3]
	///     [1, 2, 3, 4].rotated(by: 3) -> [2,3,4,1]
	///     [1, 2, 3, 4].rotated(by: -1) -> [2,3,4,1]
	///
	/// - Parameter places: Number of places that the array be rotated. If the value is positive the end becomes the start, if it negative it's that start becom the end.
	/// - Returns: The new rotated array
	public func rotated(by places: Int) -> [Element] {
		//Inspired by: https://ruby-doc.org/core-2.2.0/Array.html#method-i-rotate
		guard places != 0 && places < count else { return self }
		var array: [Element] = self
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
	///     [1, 2, 3, 4].rotate(by: 1) -> [4,1,2,3]
	///     [1, 2, 3, 4].rotate(by: 3) -> [2,3,4,1]
	///     [1, 2, 3, 4].rotated(by: -1) -> [2,3,4,1]
	///
	/// - Parameter places: The number of places that the array should be rotated. If the value is positive the end becomes the start, if it negative it's that start become the end.
	/// - Returns: self after rotating.
	@discardableResult
	public mutating func rotate(by places: Int) -> [Element] {
		self = rotated(by: places)
		return self
	}

	/// SwifterSwift: Shuffle array. (Using Fisher-Yates Algorithm)
	///
	///		[1, 2, 3, 4, 5].shuffle() // shuffles array
	///
	/// - Returns: self after shuffling.
	@discardableResult
	public mutating func shuffle() -> [Element] {
		// http://stackoverflow.com/questions/37843647/shuffle-array-swift-3
		guard count > 1 else { return self }
		for index in startIndex..<endIndex - 1 {
			let randomIndex = Int(arc4random_uniform(UInt32(endIndex - index))) + index
			if index != randomIndex { swapAt(index, randomIndex) }
		}
		return self
	}

	/// SwifterSwift: Shuffled version of array. (Using Fisher-Yates Algorithm)
	///
	///		[1, 2, 3, 4, 5].shuffled // return a shuffled version from given array e.g. [2, 4, 1, 3, 5].
	///
	/// - Returns: the array with its elements shuffled.
	public func shuffled() -> [Element] {
		var array = self
		return array.shuffle()
	}

	/// SwifterSwift: Returns a sorted array based on an optional keypath.
	///
	/// - Parameter path: Key path to sort. The key path type must be Comparable.
	/// - Parameter ascending: If order must be ascending.
	/// - Returns: Sorted array based on keyPath.
	public func sorted<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
		return sorted(by: { (lhs, rhs) -> Bool in
			guard let lhsValue = lhs[keyPath: path], let rhsValue = rhs[keyPath: path] else { return false }
			if ascending {
				return lhsValue < rhsValue
			}
			return lhsValue > rhsValue
		})
	}

	/// SwifterSwift: Returns a sorted array based on a keypath.
	///
	/// - Parameter path: Key path to sort. The key path type must be Comparable.
	/// - Parameter ascending: If order must be ascending.
	/// - Returns: Sorted array based on keyPath.
	public func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
		return sorted(by: { (lhs, rhs) -> Bool in
			if ascending {
				return lhs[keyPath: path] < rhs[keyPath: path]
			}
			return lhs[keyPath: path] > rhs[keyPath: path]
		})
	}

	/// SwifterSwift: Sort the array based on an optional keypath.
	///
	/// - Parameters:
	///   - path: Key path to sort, must be Comparable.
	///   - ascending: whether order is ascending or not.
	/// - Returns: self after sorting.
	@discardableResult
	public mutating func sort<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
		self = sorted(by: path, ascending: ascending)
		return self
	}

	/// SwifterSwift: Sort the array based on a keypath.
	///
	/// - Parameters:
	///   - path: Key path to sort, must be Comparable.
	///   - ascending: whether order is ascending or not.
	/// - Returns: self after sorting.
	@discardableResult
	public mutating func sort<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
		self = sorted(by: path, ascending: ascending)
		return self
	}

    /// SwifterSwift: Removes the first element of the collection which satisfies the given predicate.
    ///
    ///        [1, 2, 2, 3, 4, 2, 5].removeFirst { $0 % 2 == 0 } -> [1, 2, 3, 4, 2, 5]
    ///        ["h", "e", "l", "l", "o"].removeFirst { $0 == "e" } -> ["h", "l", "l", "o"]
    ///
    /// - Parameter predicate: A closure that takes an element as its argument and returns a Boolean value that indicates whether the passed element represents a match.
    /// - Returns: The first element for which predicate returns true, after removing it. If no elements in the collection satisfy the given predicate, returns `nil`.
    @discardableResult
    public mutating func removeFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try index(where: predicate) else { return nil }
        return remove(at: index)
    }

}

// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {

	/// SwifterSwift: All indices of specified item.
	///
	///		[1, 2, 2, 3, 4, 2, 5].indices(of 2) -> [1, 2, 5]
	///		[1.2, 2.3, 4.5, 3.4, 4.5].indices(of 2.3) -> [1]
	///		["h", "e", "l", "l", "o"].indices(of "l") -> [2, 3]
	///
	/// - Parameter item: item to check.
	/// - Returns: an array with all indices of the given item.
	public func indices(of item: Element) -> [Index] {
		var indices: [Index] = []
		for index in startIndex..<endIndex where self[index] == item {
			indices.append(index)
		}
		return indices
	}

	/// SwifterSwift: Remove all instances of an item from array.
	///
	///		[1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
	///		["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
	///
	/// - Parameter item: item to remove.
	/// - Returns: self after removing all instances of item.
	@discardableResult
	public mutating func removeAll(_ item: Element) -> [Element] {
		self = filter { $0 != item }
		return self
	}

	/// SwifterSwift: Remove all instances contained in items parameter from array.
	///
	///		[1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
	///		["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
	///
	/// - Parameter items: items to remove.
	/// - Returns: self after removing all instances of all items in given array.
	@discardableResult
	public mutating func removeAll(_ items: [Element]) -> [Element] {
		guard !items.isEmpty else { return self }
		self = filter { !items.contains($0) }
		return self
	}

	/// SwifterSwift: Remove all duplicate elements from Array.
	///
	///		[1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
	///		["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
	///
	public mutating func removeDuplicates() {
		// Thanks to https://github.com/sairamkotha for improving the method
		self = reduce(into: [Element]()) {
			if !$0.contains($1) {
				$0.append($1)
			}
		}
	}

	/// SwifterSwift: Return array with all duplicate elements removed.
	///
	///     [1, 1, 2, 2, 3, 3, 3, 4, 5].duplicatesRemoved() -> [1, 2, 3, 4, 5])
	///     ["h", "e", "l", "l", "o"].duplicatesRemoved() -> ["h", "e", "l", "o"])
	///
	/// - Returns: an array of unique elements.
	///
	public func withoutDuplicates() -> [Element] {
		// Thanks to https://github.com/sairamkotha for improving the method
		return reduce(into: [Element]()) {
			if !$0.contains($1) {
				$0.append($1)
			}
		}
	}

}
