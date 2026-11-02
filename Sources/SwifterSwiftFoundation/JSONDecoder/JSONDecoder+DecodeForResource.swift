// JSONDecoder+DecodeForResource.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension JSONDecoder {
    /// SwifterSwift: Decodes a value of the given type from a JSON file in a bundle, such as a fixture or a config file.
    ///
    /// The file is found with `Bundle.url(forResource:withExtension:)`, so names are matched exactly and
    /// case-sensitively, and a name may contain dots (`"app.config"` finds `app.config.json`). Pass `nil` as `ext` to
    /// give the full file name in `name`. The decoder's own settings, such as `keyDecodingStrategy`, apply.
    ///
    /// A missing file throws `CocoaError.fileReadNoSuchFile`, whose `filePath` is where the file was expected. An empty
    /// name throws the same error, instead of decoding whichever file with the extension the bundle lists first. In a
    /// Swift package, pass `Bundle.module` to read the package's own resources.
    ///
    /// ```swift
    /// struct Config: Decodable { var apiURL: URL }
    ///
    /// // config.json in the app bundle: {"apiURL": "https://example.com"}
    /// let config = try JSONDecoder().decode(Config.self, forResource: "config")
    /// config.apiURL  // https://example.com
    /// try JSONDecoder().decode(Config.self, forResource: "missing")  // throws CocoaError.fileReadNoSuchFile
    /// ```
    ///
    /// - Parameters:
    ///   - type: The type of the value to decode.
    ///   - name: The name of the file, without its extension.
    ///   - ext: The extension of the file. The default is `"json"`.
    ///   - bundle: The bundle that contains the file. The default is the main bundle.
    /// - Returns: The value decoded from the file.
    /// - Throws: `CocoaError.fileReadNoSuchFile` if the bundle has no such file, the error from reading the file, or the
    ///   `DecodingError` if its contents don't decode as `type`.
    /// - Complexity: O(*n*), where *n* is the size of the file.
    func decode<T: Decodable>(
        _ type: T.Type,
        forResource name: String,
        withExtension ext: String? = "json",
        in bundle: Bundle = .main
    ) throws -> T {
        guard !name.isEmpty, let url = bundle.url(forResource: name, withExtension: ext) else {
            var fileName = name
            if let ext, !ext.isEmpty {
                fileName += ".\(ext)"
            }
            let expectedURL = (bundle.resourceURL ?? bundle.bundleURL).appending(path: fileName)
            throw CocoaError(
                .fileReadNoSuchFile,
                userInfo: [NSFilePathErrorKey: expectedURL.path(percentEncoded: false), NSURLErrorKey: expectedURL]
            )
        }
        let data = try Data(contentsOf: url)
        return try decode(type, from: data)
    }
}
#endif
