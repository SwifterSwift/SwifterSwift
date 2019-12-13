//
//  TestHelpers.swift
//  SwifterSwift
//
//  Created by Ilya Glushchuk on 22/10/2019.
//  Copyright © 2019 SwifterSwift
//

/**
 These structs used to test ArrayExtensions and RangeReplaceableCollection.
 Feel free to use it for your needs.
 */
struct Person: Equatable {
    var name: String
    var age: Int?
    var location: Location?
    var isStudent: Bool

    init(name: String, age: Int?, location: Location? = nil, isStudent: Bool = false) {
        self.name = name
        self.age = age
        self.location = location
        self.isStudent = isStudent
    }
}

struct Location: Equatable {
    let city: String
}

struct TestStruct: ExpressibleByIntegerLiteral, Equatable {
    var testField: Int = 0
    typealias IntegerLiteralType = Int

    init(integerLiteral value: Int) {
        self.testField = value
    }
}
