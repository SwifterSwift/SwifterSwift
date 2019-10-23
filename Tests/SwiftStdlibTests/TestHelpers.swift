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

    init(name: String, age: Int?, location: Location? = nil) {
        self.name = name
        self.age = age
        self.location = location
    }
}

struct Location: Equatable {
    let city: String
}
