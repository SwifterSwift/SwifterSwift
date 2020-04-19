//
//  DataExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Data {

    /// SwifterSwift: Return data as an array of bytes.
    var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }

}

// MARK: - Methods
public extension Data {

    /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// SwifterSwift: Returns a Foundation object from given JSON data.
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }

}

// MARK: - HexString Methods

public extension Data {
    /// Swifter Swift: Formatter to configure output of toHexString()
    ///
    /// Allows for a high degree of configuration for the hex output.
    ///
    /// Each line of the output consists of 3 distinct sections in this order:
    ///     byte offset, hex value of bytes, ascii character of bytes
    /// Using these options, the offset and ascii sections may be disabled
    class HexStringFormatter {
        /// The number of data bytes to output per line
        var bytesPerLine: Int = 16

        // This separator to include in the "bytes" section at the half-way point
        var midRowSeparator: String = "- "

        /// The offset section will only be output when this is true
        var showOffset: Bool = true

        /// The offset value is always displayed in hex.  It will be capitalized if this is true
        var offsetIsCapitalized: Bool = false

        /// The number of hex digits to use when outputting the offset
        var offsetLength: Int = 4


        /// The byte value is always displayed as 2 character hex.  It will be capitalized if this is true
        var byteIsCapitalized: Bool = false

        /// When there is no more data, use the following string in place of the byte value
        var byteNoDataSubstitute: String = "  "


        /// The ascii section will only be output when this value is true
        var showAscii: Bool = true

        /// If an ascii character is not printable, output this string instead.
        var asciiNonPrintableCharacter: String = "."

        /// When there is no more data, output this string in place of the ascii value
        var asciiNoDataCharacter: String = " "

        /// After all lines are output, output the total number of bytes as a hex value on a newline
        var showTotalBytes: Bool = false

        /// The number of hex digits to use when outputting the total bytes
        var totalBytesLength: Int = 4

        /// The total bytes will be capitalized when this is true
        var totalBytesIsCapitalized: Bool = false

        enum LineOffsetPadding {
            case none
            case additional(Int)
            case roundTo(Int)
        }
        var lineOffsetPadding = LineOffsetPadding.none

        struct Wrap: Equatable {
            let begin: String
            let end: String
            
            init(begin: String = "", end: String = "") {
                self.begin = begin
                self.end = end
            }
        }
        
        struct WrapSettings: Equatable {
            var offsetWrap = Wrap(begin: "", end: ": ")
            var byteWrap = Wrap(begin: "", end: " ")
            var byteNoDataWrap = Wrap(begin: "", end: " ")
            var asciiSectionWrap = Wrap(begin: " ", end: "")
            var lineWrap = Wrap(begin: "", end: "\n")
        }
        var even = WrapSettings()
        var odd = WrapSettings()
        
        // Conveniences when even and odd lines are the same
        var offsetWrap: Wrap? {
            set {
                let newValue = newValue ?? Wrap()
                self.even.offsetWrap = newValue
                self.odd.offsetWrap = newValue
            }
            get {
                guard self.even == self.odd else { return nil }
                return self.even.offsetWrap
            }
        }
        var byteWrap: Wrap? {
            set {
                let newValue = newValue ?? Wrap()
                self.even.byteWrap = newValue
                self.odd.byteWrap = newValue
            }
            get {
                guard self.even == self.odd else { return nil }
                return self.even.byteWrap
            }
        }
        var byteNoDataWrap: Wrap? {
            set {
                let newValue = newValue ?? Wrap()
                self.even.byteNoDataWrap = newValue
                self.odd.byteNoDataWrap = newValue
            }
            get {
                guard self.even == self.odd else { return nil }
                return self.even.byteNoDataWrap
            }
        }
        var asciiSectionWrap: Wrap? {
            set {
                let newValue = newValue ?? Wrap()
                self.even.asciiSectionWrap = newValue
                self.odd.asciiSectionWrap = newValue
            }
            get {
                guard self.even == self.odd else { return nil }
                return self.even.asciiSectionWrap
            }
        }
        var lineWrap: Wrap? {
            set {
                let newValue = newValue ?? Wrap()
                self.even.lineWrap = newValue
                self.odd.lineWrap = newValue
            }
            get {
                guard self.even == self.odd else { return nil }
                return self.even.lineWrap
            }
        }


        // Some default formatters
        /// A simple hexdump containing the offset, byte value, and ascii sections
        public static let defaultFormatter: HexStringFormatter = {
            let fmt = HexStringFormatter()
                return fmt
        }()
        /// A canonical output that is intended to be identical to "hexdump -C"
        public static let canonicalFormatter: HexStringFormatter = {
            let fmt = HexStringFormatter()
            fmt.totalBytesLength = 8
            fmt.offsetLength = 8
            fmt.asciiNoDataCharacter = ""
            fmt.offsetWrap = .init(begin: "", end: "  ")
            fmt.asciiSectionWrap = .init(begin: " |", end: "|")
            fmt.midRowSeparator = " "
            fmt.byteIsCapitalized = false
            fmt.offsetIsCapitalized = false
            fmt.lineOffsetPadding = .none
            fmt.showTotalBytes = true
            return fmt
        }()

        /// A simple output that has only the byte values in hex.
        /// No additional sections, spacing, etc.
        public static var simpleFormatter: HexStringFormatter = {
            let fmt = HexStringFormatter()
            fmt.showAscii = false
            fmt.showOffset = false
            fmt.midRowSeparator = ""
            fmt.byteWrap = .none
            fmt.lineWrap = .none
            fmt.asciiNoDataCharacter = ""
            fmt.byteNoDataWrap = .none
            fmt.byteNoDataSubstitute = ""
            return fmt
        }()
        
        // Helper function to determine which WrapSettings to use
        fileprivate func wrapFor(line: Int) -> WrapSettings {
            if (line % 2) == 0 {
                return self.even
            } else {
                return self.odd
            }
        }
    }



    /// Swifter Swift: Convert data to a hex string
    /// Each line of the output consists of 3 distinct sections in this order:
    ///     byte offset, hex value of bytes, ascii value of bytes
    /// - Parameter formatter: Format description
    /// - Returns: String containing hex values of data conents
    func toHexString(formatter: HexStringFormatter = .defaultFormatter) -> String {
        var ndx = 0
        var output = ""
        let totalBytes = self.count
        let startOffset = self.startIndex
        var line = 0

        func outputOffset(offset: Int, formatter: HexStringFormatter, fmtWraps: HexStringFormatter.WrapSettings) -> String {
            var str = ""
            str += fmtWraps.offsetWrap.begin

            // The default formatter resolves to this: "%04X: "
            let formatSpecifier = formatter.offsetIsCapitalized ? "X" : "x"
            str += String(format: "%0\(formatter.offsetLength)\(formatSpecifier)", offset)

            str += fmtWraps.offsetWrap.end
            return str
        }

        func outputOffsetOnlyLine(from: Int, to: Int) -> String {
            var str = ""
            for line in from..<to {
                let offset = line * formatter.bytesPerLine
                let fmtWraps = formatter.wrapFor(line: line)
                str += outputOffset(offset: offset, formatter: formatter, fmtWraps: fmtWraps)
            }
            return str
        }


        for offset in stride(from: 0, to: totalBytes, by: formatter.bytesPerLine) {
            defer { line += 1 }
            
            let startNdx = ndx
            let fmtWraps = formatter.wrapFor(line: line)
            
            output += fmtWraps.lineWrap.begin
            
            // Generate offset
            if formatter.showOffset && formatter.offsetLength > 0 {
                output += outputOffset(offset: offset, formatter: formatter, fmtWraps: fmtWraps)
            }

            // Generate bytes
            for row in 0..<formatter.bytesPerLine {
                defer { ndx += 1 }

                if row != 0,
                        row % (formatter.bytesPerLine/2) == 0 {
                    output += formatter.midRowSeparator
                }
                
                if ndx < totalBytes {
                    output += fmtWraps.byteWrap.begin
                    let formatSpecifier = formatter.byteIsCapitalized ? "X" : "x"
                    output += String(format: "%02l\(formatSpecifier)", self[ndx+startOffset])
                    output += fmtWraps.byteWrap.end
                } else {
                    output += fmtWraps.byteNoDataWrap.begin
                    output += formatter.byteNoDataSubstitute
                    output += fmtWraps.byteNoDataWrap.end
                }
            }
            
            if formatter.showAscii {
                output += fmtWraps.asciiSectionWrap.begin
                
                ndx = startNdx
                
                for _ in 0..<formatter.bytesPerLine {
                    defer { ndx += 1 }
                    
                    guard ndx < totalBytes else {
                        output += "\(formatter.asciiNoDataCharacter)"
                        continue
                    }
                    let ch = self[ndx+startOffset]
                    if isprint(Int32(Int(ch))) == 1 {
                        output += String(format: "%c", ch)
                    } else {
                        output += "\(formatter.asciiNonPrintableCharacter)"
                    }
                }

                output += fmtWraps.asciiSectionWrap.end
            }
            
            output += fmtWraps.lineWrap.end
        }

        switch formatter.lineOffsetPadding {
        case .none:
            break
        case .additional(let numNewLines):
            output += outputOffsetOnlyLine(from: line, to: line+numNewLines)
        case .roundTo(let lineMultiple):
            let remainder = (line % lineMultiple)
            guard remainder > 0 else { break }
            let numNewLines = lineMultiple - remainder

            output += outputOffsetOnlyLine(from: line, to: numNewLines)
        }

        if formatter.showTotalBytes {
            let formatSpecifier = formatter.totalBytesIsCapitalized ? "X" : "x"
            output += String(format: "%0\(formatter.totalBytesLength)l\(formatSpecifier)", totalBytes)
        }

        return output
    }
}

#endif
