// DecodableExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Foundation)
import Foundation
#endif

public extension Decodable {
    #if canImport(Foundation)
    /// SwifterSwift: Parsing the model in Decodable type.
    /// - Parameters:
    ///   - data: Data.
    ///   - decoder: JSONDecoder. Initialized by default.
    init?(from data: Data, using decoder: JSONDecoder = .init()) {
        guard let parsed = try? decoder.decode(Self.self, from: data) else { return nil }
        self = parsed
    }
    #endif
}
