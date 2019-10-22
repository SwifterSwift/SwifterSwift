//
//  TestHelpers.swift
//  SwifterSwift
//
//  Created by Ilya Glushchuk on 22/10/2019.
//  Copyright © 2019 SwifterSwift
//

import UIKit

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
