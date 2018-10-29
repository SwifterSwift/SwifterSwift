//
//  EncodableExtensions.swift
//  SwifterSwift
//
//  Created by Alexei Kozachenko on 10/29/2018.
//  Copyright © 2018 SwifterSwift
//

import Foundation

public extension Encodable {
    /// SwifterSwift: Save Encodable object to a given URL.
    ///
    /// - Parameters:
    ///   - url: URL to save object to.
    /// - Throws: Throws any errors thrown by JSONEncoder or FileManager.
    public func encode(to url: URL) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            throw error
        }
    }
}

