//
//  StringProtocolExtensions.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 11/26/17.
//  Copyright © 2017 SwifterSwift
//

import Foundation

public extension StringProtocol {

    /// SwifterSwift: The longest common suffix.
    ///
    ///        "Hello world!".commonSuffix(with: "It's cold!") = "ld!"
    ///
    /// - Parameters:
    ///     - Parameter aString: The string with which to compare the receiver.
    ///     - Parameter options: Options for the comparison.
    /// - Returns: The longest common suffix of the receiver and the given String
    func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        return String(zip(reversed(), aString.reversed())
            .lazy
            .prefix(while: { (lhs: Character, rhs: Character) in String(lhs).compare(String(rhs), options: options) == .orderedSame })
            .map { (lhs: Character, _: Character) in lhs }
            .reversed())
    }

}
