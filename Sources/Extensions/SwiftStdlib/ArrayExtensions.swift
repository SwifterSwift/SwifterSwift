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
}

// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {

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
	///     [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
	///     ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"])
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
