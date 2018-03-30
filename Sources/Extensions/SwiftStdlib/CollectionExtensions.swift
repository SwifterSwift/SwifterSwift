//
//  CollectionExtensions.swift
//  SwifterSwift
//
//  Created by Sergey Fedortsov on 19.12.16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Methods
public extension Collection {
	
	private func indicesArray() -> [Self.Index] {
		var indices: [Self.Index] = []
		var anIndex = startIndex
		while anIndex != endIndex {
			indices.append(anIndex)
			anIndex = index(after: anIndex)
		}
		return indices
	}
	
	/// SwifterSwift: Performs `each` closure for each element of collection in parallel.
	///
	///		array.forEachInParallel { item in
	///			print(item)
	///		}
	///
	/// - Parameter each: closure to run for each element.
	public func forEachInParallel(_ each: (Self.Iterator.Element) -> Void) {
		let indices = indicesArray()
		
		DispatchQueue.concurrentPerform(iterations: indices.count) { (index) in
			let elementIndex = indices[index]
			each(self[elementIndex])
		}
	}
	
	/// SwifterSwift: Safe protects the array from out of bounds by use of optional.
	///
	///		let arr = [1, 2, 3, 4, 5]
	///		arr[safe: 1] -> 2
	///		arr[safe: 10] -> nil
	///
	/// - Parameter index: index of element to access element.
	public subscript(safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
	}
    
    /// SwifterSwift: Check if all elements in collection match a conditon.
    ///
    ///        [2, 2, 4].all(matching: {$0 % 2 == 0}) -> true
    ///        [1,2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    public func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }
    
    /// SwifterSwift: Check if no elements in collection match a conditon.
    ///
    ///        [2, 2, 4].none(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].none(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    public func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }
    
    /// SwifterSwift: Check if any element in collection match a conditon.
    ///
    ///        [2, 2, 4].any(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].any(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    public func any(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try contains { try condition($0) }
    }
}

// MARK: - Methods (Int)
public extension Collection where Index == Int, IndexDistance == Int {
	
	/// SwifterSwift: Random item from array.
	public var randomItem: Element? {
        guard !isEmpty else { return nil }
		let index = Int(arc4random_uniform(UInt32(count)))
		return self[index]
	}
	
}

// MARK: - Methods (Integer)
public extension Collection where Iterator.Element == Int, Index == Int {
	
	/// SwifterSwift: Average of all elements in array.
	///
	/// - Returns: the average of the array's elements.
	public func average() -> Double {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : Double(reduce(0, +)) / Double(endIndex-startIndex)
	}
	
}
