//
//  ArrayExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/26/16.
//  Copyright © 2016 SwifterSwift
//
import XCTest
@testable import SwifterSwift

final class ArrayExtensionsTests: XCTestCase {

	func testRandomItem() {
		XCTAssert([1, 2, 3].contains([1, 2, 3].randomItem))
	}
	
	func testAverage() {
		XCTAssertEqual([1, 2, 3, 4, 5].average(), 3)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].average(), 3.4)
		XCTAssertEqual([Int]().average(), 0)
		XCTAssertEqual([Double]().average(), 0)
	}
	
	func testFirstIndex() {
		XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2))
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 2), 2)
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].firstIndex(of: 7))
	}
	
	func testIndexes() {
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].indexes(of: 1), [0, 1, 5, 7])
	}
    
    func testIndices() {
        XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].indices(of: 1), [0, 1, 5, 7])
        XCTAssertEqual(["a", "b", "c", "b", "4", "1", "2", "1"].indices(of: "b"), [1, 3])
    }
	
	func testLastIndex() {
		XCTAssertNotNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2))
		XCTAssertEqual([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 2), 6)
		XCTAssertNil([1, 1, 2, 3, 4, 1, 2, 1].lastIndex(of: 7))
	}
	
	func testPop() {
		var arr = [1, 2, 3, 4, 5]
		let item = arr.pop()
		XCTAssertEqual(arr, [1, 2, 3, 4])
		XCTAssertNotNil(item)
		XCTAssertEqual(item, 5)
		arr.removeAll()
		XCTAssertNil(arr.pop())
	}
	
	func testPrepend() {
		var arr = [2, 3, 4, 5]
		arr.prepend(1)
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
	}
	
	func testPush() {
		var arr = [1, 2, 3, 4]
		arr.push(5)
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
	}
	
    func testSwap() {
        var array: [Int] = [1, 2, 3, 4, 5]
        array.swap(from: 3, to: 0)
        XCTAssertEqual(array[3], 1)
        XCTAssertEqual(array[0], 4)
    }
    
    func testSafeSwap() {
        var array: [Int] = [1, 2, 3, 4, 5]
        array.safeSwap(from: 3, to: 0)
        XCTAssertEqual(array[3], 1)
        XCTAssertEqual(array[0], 4)
		
		var newArray = array
		newArray.safeSwap(from: 1, to: 1)
		XCTAssertEqual(newArray, array)
		
		newArray = array
		newArray.safeSwap(from: 1, to: 12)
		XCTAssertEqual(newArray, array)
		
		let emptyArray: [Int] = []
		var swappedEmptyArray = emptyArray
		swappedEmptyArray.safeSwap(from: 1, to: 3)
		XCTAssertEqual(swappedEmptyArray, emptyArray)
		
    }
    
	func testRemoveAll() {
		var arr = [0, 1, 2, 0, 3, 4, 5, 0, 0]
		arr.removeAll(0)
		XCTAssertEqual(arr, [1, 2, 3, 4, 5])
		arr = []
		arr.removeAll(0)
		XCTAssertEqual(arr, [])
	}
    
    func testRemoveAllItems() {
        var arr = [0, 1, 2, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll([0, 2])
        XCTAssertEqual(arr, [1, 3, 4, 5])
		arr.removeAll([])
		XCTAssertEqual(arr, [1, 3, 4, 5])
		arr = []
		arr.removeAll([])
		XCTAssertEqual(arr, [])
    }

    func testShuffle() {
		var arr = ["a"]
		arr.shuffle()
		XCTAssertEqual(arr, arr)
		
        let original = [1, 2, 3, 4, 5]
        var array = original
        
        while original == array {
            array.shuffle()
        }
        XCTAssertEqual(array.count, 5)
        XCTAssertNotEqual(original, array)
    }
    
    func testShuffled() {
        let original = [1, 2, 3, 4, 5]
        var array = original
        
        while original == array {
            array = array.shuffled()
        }
        XCTAssertEqual(array.count, 5)
        XCTAssertNotEqual(original, array)
    }
	
	func testSum() {
		XCTAssertEqual([1, 2, 3, 4, 5].sum(), 15)
		XCTAssertEqual([1.2, 2.3, 3.4, 4.5, 5.6].sum(), 17)
	}
	
    func testRemoveDuplicates() {
        var array = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        array.removeDuplicates()
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
    }
    
    func testDuplicatesRemoved() {
        XCTAssertEqual([1, 1, 2, 2, 3, 3, 3, 4, 5].duplicatesRemoved(), [1, 2, 3, 4, 5])
        XCTAssertEqual(["h", "e", "l", "l", "o"].duplicatesRemoved(), ["h", "e", "l", "o"])
    }
	
	func testItemAtIndex() {
		XCTAssertEqual([1, 2, 3].item(at: 0), 1)
		XCTAssertEqual([1, 2, 3].item(at: 1), 2)
		XCTAssertEqual([1, 2, 3].item(at: 2), 3)
		XCTAssertNil([1, 2, 3].item(at: 5))
	}
	
	func testContains() {
		XCTAssert([Int]().contains([]))
		XCTAssertFalse([Int]().contains([1, 2]))
		XCTAssert([1, 2, 3].contains([1, 2]))
		XCTAssert([1, 2, 3].contains([2, 3]))
		XCTAssert([1, 2, 3].contains([1, 3]))
		XCTAssertFalse([1, 2, 3].contains([4, 5]))
	}
    
    func testFirstIndexWhere() {
        let array = [1, 7, 1, 2, 4, 1, 6]
        let index = array.firstIndex { $0 % 2 == 0 }
        XCTAssertEqual(index, 3)
        XCTAssertNil([Int]().firstIndex { $0 % 2 == 0 })
    }
    
    func testLastIndexWhere() {
        let array = [1, 1, 1, 2, 2, 1, 1, 2, 1]
        let index = array.lastIndex { $0 % 2 == 0 }
        XCTAssertEqual(index, 7)
        XCTAssertNil([Int]().lastIndex { $0 % 2 == 0 })
    }
    
    func testIndicesWhere() {
        let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let indices = array.indices { $0 % 2 == 0 }
        XCTAssertEqual(indices!, [0, 2, 4, 6, 8])
		let emptyArray: [Int] = []
		let emptyIndices = emptyArray.indices { $0 % 2 == 0 }
		XCTAssertNil(emptyIndices)
    }
    
    func testAllMatch() {
        let array = [2, 4, 6, 8, 10, 12]
        XCTAssert(array.all { $0 % 2 == 0 })
    }
    
    func testNoneMatch() {
        let array = [3, 5, 7, 9, 11, 13]
        XCTAssert(array.none { $0 % 2 == 0 })
    }
    
    func testLastWhere() {
        let array = [1, 1, 2, 1, 1, 1, 2, 1, 4, 1]
        let element = array.last { $0 % 2 == 0 }
        XCTAssertEqual(element, 4)
        XCTAssertNil([Int]().last { $0 % 2 == 0 })
    }
    
    func testReject() {
        let input = [1, 2, 3, 4, 5]
        let output = input.reject { $0 % 2 == 0 }
        XCTAssertEqual(output, [1, 3, 5])
    }
    
    func testCountWhere() {
        let array = [1, 1, 1, 1, 4, 4, 1, 1, 1]
        let count = array.count { $0 % 2 == 0 }
        XCTAssertEqual(count, 2)
    }
    
    func testForEachReversed() {
        let input = [1, 2, 3, 4, 5]
        var output: [Int] = []
        input.forEachReversed { output.append($0) }
        XCTAssertEqual(output.first, 5)
    }
    
    func testForEachWhere() {
        let input = [1, 2, 2, 2, 1, 4, 1]
        var output: [Int] = []
		input.forEach(where: {$0 % 2 == 0}, body: { output.append($0 * 2) })
        XCTAssertEqual(output, [4, 4, 4, 8])
    }
    
    func testAccumulate() {
        let input = [1, 2, 3]
        let result = input.accumulate(initial: 0, next: +)
        XCTAssertEqual([1, 3, 6], result)
    }
    
    func testFilteredMap() {
        let input = [1, 2, 3, 4, 5]
		let result = input.filtered({ $0 % 2 == 0 }, map: { $0.string })
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(["2", "4"], result)
    }
    
    func testKeepWhile() {
        var input = [2, 4, 6, 7, 8, 9, 10]
        input.keep(while: {$0 % 2 == 0 })
        XCTAssertEqual(input, [2, 4, 6])
        
        input = [7, 7, 8, 10]
        input.keep(while: {$0 % 2 == 0 })
        XCTAssertEqual(input, [Int]())
    }
    
    func testTakeWhile() {
        var input = [2, 4, 6, 7, 8, 9, 10]
        var output = input.take(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [2, 4, 6])
        
        input = [7, 7, 8, 10]
        output = input.take(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [Int]())
      
        XCTAssertEqual([].take(while: {$0 % 2 == 0 }), [])
    }
    
    func testSkipWhile() {
        var input = [2, 4, 6, 7, 8, 9, 10]
        var output = input.skip(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [7, 8, 9, 10])
        
        input = [7, 7, 8, 10]
        output = input.skip(while: {$0 % 2 == 0 })
        XCTAssertEqual(output, [7, 7, 8, 10])
      
        XCTAssertEqual([].skip(while: { $0 % 2 == 0}), [])
    }

    func testGroupBy() {
        let array: [String] = ["james", "irving", "jordan", "jonshon", "iverson"]
        let grouped = array.groupByKey { element -> String in
            return String(element.first!)
        }
        XCTAssertEqual(grouped["j"] ?? [], [ "james", "jordan", "jonshon" ])
        XCTAssertEqual(grouped["i"] ?? [], [ "irving", "iverson" ])
    }
    
	func testDivided() {
		let input = [0, 1, 2, 3, 4, 5]
		let (even, odd) = input.divided { $0 % 2 == 0 }
		XCTAssertEqual(even, [0, 2, 4])
		XCTAssertEqual(odd, [1, 3, 5])

		// Parameter names + indexes
		let tuple = input.divided { $0 % 2 == 0 }
		XCTAssertEqual(tuple.matching, [0, 2, 4])
		XCTAssertEqual(tuple.0, [0, 2, 4])
		XCTAssertEqual(tuple.nonMatching, [1, 3, 5])
		XCTAssertEqual(tuple.1, [1, 3, 5])
	}

    func testForEachSlice() {
        var iterations: Int = 0
        
        // A slice with value zero
        var array: [String] = ["james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        array.forEach(slice: 0) { _ in
            iterations += 1
        }
        XCTAssertEqual(iterations, 0)
        
        // A slice that divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        
        array.forEach(slice: 2) { (sliceArray) in
            switch iterations {
            case 0:
                XCTAssertEqual(sliceArray, [ "james", "irving" ])
            case 1:
                XCTAssertEqual(sliceArray, [ "jordan", "jonshon" ])
            case 2:
                XCTAssertEqual(sliceArray, [ "iverson", "shaq" ])
            default: break
            }
            iterations += 1
        }

        // A slice that does not divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq", "bird"]
        
        iterations = 0
        
        array.forEach(slice: 2) { (sliceArray) in
            switch iterations {
            case 0:
                XCTAssertEqual(sliceArray, [ "james", "irving" ])
            case 1:
                XCTAssertEqual(sliceArray, [ "jordan", "jonshon" ])
            case 2:
                XCTAssertEqual(sliceArray, [ "iverson", "shaq" ])
            case 3:
                XCTAssertEqual(sliceArray, [ "bird" ])
            default: break
            }
            iterations += 1

        }
        
        // A slice greater than the array count
        array = [ "james", "irving", "jordan", "jonshon" ]
        array.forEach(slice: 6) { (sliceArray) in
            XCTAssertEqual(sliceArray, [ "james", "irving", "jordan", "jonshon"])
        }
        
    }
    
    func testGroupBySize() {
        
        // A slice with value zero
        var array: [String] = ["james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        var slices = array.group(by: 0)
        XCTAssertNil(slices)
        
        // A slice that divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq"]
        slices = array.group(by: 2)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 3)
        
        // A slice that does not divide the total evenly
        array = [ "james", "irving", "jordan", "jonshon", "iverson", "shaq", "bird"]
        slices = array.group(by: 2)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 4)
        
        // A slice greater than the array count
        array = [ "james", "irving", "jordan", "jonshon" ]
        slices = array.group(by: 6)
        XCTAssertNotNil(slices)
        XCTAssertEqual(slices?.count, 1)

    }
    
    func testRotated() {
        let array: [Int] = [1, 2, 3, 4]
        XCTAssertEqual(array.rotated(by: 0), [1, 2, 3, 4])
        XCTAssertEqual(array.rotated(by: 4), [1, 2, 3, 4])
        XCTAssertEqual(array.rotated(by: 1), [4, 1, 2, 3])
        XCTAssertEqual(array.rotated(by: 3), [2, 3, 4, 1])
        XCTAssertEqual(array.rotated(by: -1), [2, 3, 4, 1])
        XCTAssertEqual(array.rotated(by: -3), [4, 1, 2, 3])
    }
    
    func testRotate() {
        var array: [Int] = [1, 2, 3, 4]
        array.rotate(by: 0)
        XCTAssertEqual(array, [1, 2, 3, 4])
        array.rotate(by: 2)
        XCTAssertEqual(array, [3, 4, 1, 2])
        array.rotate(by: -1)
        XCTAssertEqual(array, [4, 1, 2, 3])
        
    }

    struct Person: Equatable {
        var name: String
        var age: Int?
        
        static func == (lhs: Person, rhs: Person) -> Bool {
            return lhs.name == rhs.name && lhs.age == rhs.age
        }
    }
    
    func testKeyPathSorted() {
 
        let array = [Person(name: "James", age: 32),
                     Person(name: "Wade", age: 36),
                     Person(name: "Rose", age: 29)]
        
        XCTAssertEqual(array.sorted(by: \Person.name), [Person(name: "James", age: 32),
                                                        Person(name: "Rose", age: 29),
                                                        Person(name: "Wade", age: 36)])
        XCTAssertEqual(array.sorted(by: \Person.name, ascending: false), [Person(name: "Wade", age: 36),
                                                                          Person(name: "Rose", age: 29),
                                                                          Person(name: "James", age: 32)])
        // Testing Optional keyPath
        XCTAssertEqual(array.sorted(by: \Person.age), [Person(name: "Rose", age: 29),
                                                       Person(name: "James", age: 32),
                                                       Person(name: "Wade", age: 36)])
        XCTAssertEqual(array.sorted(by: \Person.age, ascending: false), [Person(name: "Wade", age: 36),
                                                                         Person(name: "James", age: 32),
                                                                         Person(name: "Rose", age: 29)])
        
        // Testing Mutating
        var mutableArray = [Person(name: "James", age: 32),
                            Person(name: "Wade", age: 36),
                            Person(name: "Rose", age: 29)]
        
        mutableArray.sort(by: \Person.name)
        XCTAssertEqual(mutableArray, [Person(name: "James", age: 32),
                                      Person(name: "Rose", age: 29),
                                      Person(name: "Wade", age: 36)])
        
        // Testing Mutating Optional keyPath
        mutableArray.sort(by: \Person.age)
        XCTAssertEqual(mutableArray, [Person(name: "Rose", age: 29),
                                      Person(name: "James", age: 32),
                                      Person(name: "Wade", age: 36)])
        
        // Testing nil path
        let nilArray = [Person(name: "James", age: nil), Person(name: "Wade", age: nil)]
        XCTAssertEqual(nilArray.sorted(by: \Person.age), [Person(name: "James", age: nil),
                                                        Person(name: "Wade", age: nil)])
    }
    
}
