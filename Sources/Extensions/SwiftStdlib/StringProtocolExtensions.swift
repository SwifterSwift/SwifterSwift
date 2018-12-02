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
    public func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        guard !isEmpty && !aString.isEmpty else { return "" }

        var idx = endIndex
        var strIdx = aString.endIndex
        var result = ""

        let caseInsensitive = options.contains(.caseInsensitive)
        let literal = options.contains(.literal)

        repeat {
            formIndex(before: &idx)
            aString.formIndex(before: &strIdx)

            let char = self[idx]
            let other = aString[strIdx]

            if char != other {
                guard caseInsensitive && String(char).lowercased() == String(other).lowercased() else { break }
            }

            if literal && other.unicodeScalars.count != char.unicodeScalars.count { break }

            result.insert(char, at: result.startIndex)

        } while idx > startIndex && strIdx > aString.startIndex
        return result

    }

}
