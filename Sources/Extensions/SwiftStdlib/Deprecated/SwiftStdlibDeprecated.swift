//
//  SwiftStdlibDeprecated.swift
//  SwifterSwift
//
//  Copyright © 2016 SwifterSwift
//

public extension Bool {

    /// SwifterSwift: Return inversed value of bool.
    ///
    ///        false.toggled -> true
    ///        true.toggled -> false
    ///
    @available(*, deprecated: 4.3, message: "Use !self instead.")
    public var toggled: Bool {
        return !self
    }

}

public extension Bool {

    @discardableResult
    /// SwifterSwift: Toggle value for bool.
    ///
    ///        var bool = false
    ///        bool.toggle()
    ///        print(bool) -> true
    ///
    /// - Returns: inversed value of bool.
    @available(*, deprecated: 4.3, message: "Use !self instead.")
    public mutating func toggle() -> Bool {
        self = !self
        return self
    }

}

extension String {

	/// SwifterSwift: Number of characters in string.
	///
	///		"Hello world!".length -> 12
	///
	@available(*, deprecated: 4.1.0, message: "Use .count instead.")
	public var length: Int {
		return count
	}

	// swiftlint:disable identifier_name
	/// SwifterSwift: Sliced string from a start index.
	///
	///		"Hello World".slicing(at: 6) -> "World"
	///
	/// - Parameter i: string index the slicing should start from.
	/// - Returns: sliced substring starting from start index (if applicable) (example: "Hello world".slicing(at: 6) -> "world")
	@available(*, deprecated: 4.1.0, message: "Use string[safe: i] instead.")
	public func slicing(at i: Int) -> String? {
		guard i < count else {
			return nil
		}
		return self[safe: i..<count]
	}
	// swiftlint:enable identifier_name

	/// SwifterSwift: Sliced string from a start index to an end index.
	///
	///		"Hello World".slicing(from: 6, to: 11) -> "World"
	///
	/// - Parameters:
	///   - start: string index the slicing should start from.
	///   - end: string index the slicing should end at.
	/// - Returns: sliced substring starting from start index, and ends at end index (if applicable) (example: "Hello World".slicing(from: 6, to: 11) -> "World")
	@available(*, deprecated: 4.1.0, message: "Use string[safe: start..<end] instead.")
	public func slicing(from start: Int, to end: Int) -> String? {
		guard end >= start else {
			return nil
		}
		return self[safe: start..<end]
	}

	/// SwifterSwift: First index of substring in string.
	///
	///		"Hello World!".firstIndex(of: "l") -> 2
	///		"Hello World!".firstIndex(of: "s") -> nil
	///
	/// - Parameter string: substring to search for.
	/// - Returns: first index of substring in string (if applicable).
	@available(*, deprecated: 4.1.0, message: "Use string.index(of: Character) or string.range(of: StringProtocol) instead.")
	public func firstIndex(of string: String) -> Int? {
		return map({ String($0) }).index(of: string)
	}

	//

	/// SwifterSwift: Array of strings separated by given string.
	///
	///		"hello World".splited(by: " ") -> ["hello", "World"]
	///
	/// - Parameter separator: separator to split string by.
	/// - Returns: array of strings separated by given string.
	@available(*, deprecated: 4.1.0, message: "Use string.split(separator: Character) instead.")
	public func splitted(by separator: Character) -> [String] {
		return split { $0 == separator }.map(String.init)
	}

}

public extension Array {

	/// SwifterSwift: Element at the given index if it exists.
	///
	///		[1, 2, 3, 4, 5].item(at: 2) -> 3
	///		[1.2, 2.3, 4.5, 3.4, 4.5].item(at: 3) -> 3.4
	///		["h", "e", "l", "l", "o"].item(at: 10) -> nil
	///
	/// - Parameter index: index of element.
	/// - Returns: optional element (if exists).
	@available(*, deprecated: 4.3, message: "Use subscript(safe:) instead", renamed: "subscript(safe:)")
	public func item(at index: Int) -> Element? {
		guard startIndex..<endIndex ~= index else { return nil }
		return self[index]
	}

}

public extension Array where Element: Equatable {

	/// SwifterSwift: Return array with all duplicate elements removed.
	///
	///     [1, 1, 2, 2, 3, 3, 3, 4, 5].duplicatesRemoved() -> [1, 2, 3, 4, 5])
	///     ["h", "e", "l", "l", "o"].duplicatesRemoved() -> ["h", "e", "l", "o"])
	///
	/// - Returns: an array of unique elements.
	///
	@available(*, deprecated: 4.3, message: "Use withoutDuplicates() instead", renamed: "withoutDuplicates")
	public func duplicatesRemoved() -> [Element] {
		// Thanks to https://github.com/sairamkotha for improving the method
		return reduce(into: [Element]()) {
			if !$0.contains($1) {
				$0.append($1)
			}
		}
	}

	/// SwifterSwift: All indexes of specified item.
	///
	///		[1, 2, 2, 3, 4, 2, 5].indexes(of 2) -> [1, 2, 5]
	///		[1.2, 2.3, 4.5, 3.4, 4.5].indexes(of 2.3) -> [1]
	///		["h", "e", "l", "l", "o"].indexes(of "l") -> [2, 3]
	///
	/// - Parameter item: item to check.
	/// - Returns: an array with all indexes of the given item.
	@available(*, deprecated: 4.1.1, message: "Use indices(of:) instead", renamed: "indices(of:)")
	public func indexes(of item: Element) -> [Int] {
		var indexes: [Int] = []
		for index in startIndex..<endIndex where self[index] == item {
			indexes.append(index)
		}
		return indexes
	}

	/// SwifterSwift: Remove last element from array and return it.
	///
	///		[1, 2, 3, 4, 5].pop() // returns 5 and remove it from the array.
	///		[].pop() // returns nil since the array is empty.
	///
	/// - Returns: last element in array (if applicable).
	@available(*, deprecated: 4.3, message: "Use popLast() instead")
	@discardableResult public mutating func pop() -> Element? {
		return popLast()
	}

	/// SwifterSwift: Insert an element to the end of array.
	///
	///		[1, 2, 3, 4].push(5) -> [1, 2, 3, 4, 5]
	///		["h", "e", "l", "l"].push("o") -> ["h", "e", "l", "l", "o"]
	///
	/// - Parameter newElement: element to insert.
	@available(*, deprecated: 4.3, message: "Use append() instead")
	public mutating func push(_ newElement: Element) {
		append(newElement)
	}

	/// SwifterSwift: Swap values at index positions.
	///
	///		[1, 2, 3, 4, 5].swap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
	///		["h", "e", "l", "l", "o"].swap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
	///
	/// - Parameters:
	///   - index: index of first element.
	///   - otherIndex: index of other element.
	@available(*, deprecated: 4.3, message: "Use swapAt() instead")
	public mutating func swap(from index: Int, to otherIndex: Int) {
		swapAt(index, otherIndex)
	}

}
