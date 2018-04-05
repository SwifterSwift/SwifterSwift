//
//  CollectionExtensions.swift
//  SwifterSwift
//
//  Created by Sergey Fedortsov on 19.12.16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Methods
public extension Collection {

	/// SwifterSwift: Performs `each` closure for each element of collection in parallel.
	///
	///		array.forEachInParallel { item in
	///			print(item)
	///		}
	///
	/// - Parameter each: closure to run for each element.
	public func forEachInParallel(_ each: (Self.Iterator.Element) -> Void) {
		let indicesArray = Array(indices)

		DispatchQueue.concurrentPerform(iterations: indicesArray.count) { (index) in
			let elementIndex = indicesArray[index]
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

}

// MARK: - Methods (Int)
public extension Collection where Index == Int {

	/// SwifterSwift: Random item from array.
	public var randomItem: Element? {
        guard !isEmpty else { return nil }
		let index = Int(arc4random_uniform(UInt32(count)))
		return self[index]
	}

}

// MARK: - Methods (Integer)
public extension Collection where Iterator.Element == IntegerLiteralType, Index == Int {

	/// SwifterSwift: Average of all elements in array.
	///
	/// - Returns: the average of the array's elements.
	public func average() -> Double {
		// http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
		return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
	}

}
