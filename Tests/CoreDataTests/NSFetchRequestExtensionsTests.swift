//
//  NSFetchRequestExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 04.10.17.
//

import XCTest
import CoreData

class NSFetchRequestExtensionsTests: XCTestCase {
    
    func testWithPredicate() {
        let predicate = NSPredicate(format: "age < 23")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "entity").withPredicate(predicate)
        XCTAssertEqual(fetchRequest.predicate, predicate)
    }
}
