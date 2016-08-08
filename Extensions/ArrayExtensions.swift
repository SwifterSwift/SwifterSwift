//
//  ArrayExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Array where Element:Equatable {

    /// Return random item from array.
    public var randomItem: Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }

    /// Return first index of element in array.
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

    /// Remove element from array.
    public mutating func remove(object: Element) {
        for (index, element) in enumerated() {
            if object == element {
                self.remove(at: index)
            }
        }
    }

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

    /// Return unique values of array.
    public var uniqueValues: [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }

    /// Remove duplicates from array.
    public mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        self = result
    }


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
