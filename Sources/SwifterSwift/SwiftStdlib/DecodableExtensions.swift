//
//  DecodableExtensions.swift
//  SwifterSwift
//
//  Created by Mustafa GUNES on 16.01.2020.
//  Copyright © 2020 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

public extension Decodable {

    #if canImport(Foundation)
    /// SwifterSwift: Parsing the model in Codable type
    /// - Parameter data: Data.
    /// - Returns: Decoded self model value.
    /// - Throws: Decoding error.
    static func decode(_ data: Data) throws -> Self? {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        do {
            let parsed = try decoder.decode(self, from: data)
            return parsed
        } catch {
            return nil
        }
    }
    #endif
}
