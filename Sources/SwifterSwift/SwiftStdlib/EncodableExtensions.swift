//
//  EncodableExtensions.swift
//  SwifterSwift
//
//  Created by zeero on 26/05/2019.
//  Copyright © 2019 SwifterSwift
//

// MARK: - Methods
public extension Encodable {

    /// SwifterSwift: Encode to String with specified encoding (default: utf8)
    ///
    ///     struct Foo: Encodable { let foo: String }
    ///     let foo = Foo(foo: "bar")
    ///     foo.encode() -> "{\"foo\": \"bar\"}"
    ///     foo.encode(encoding: .utf8) -> "{\"foo\": \"bar\"}"     // encoding obviously specified
    ///
    /// - Parameters:
    ///   - encoding: String encoding. (default: utf8)
    /// - Returns: Optional string.
    /// - Throws: Throws any errors thrown by Data creation.
    func encode(encoding: String.Encoding = .utf8) throws -> String? {
        let data = try JSONEncoder().encode(self)
        return String(data: data, encoding: encoding)
    }

}
