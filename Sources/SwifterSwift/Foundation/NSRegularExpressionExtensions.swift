// NSRegularExpressionExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSRegularExpression {
    /// SwifterSwift: Enumerates the string allowing the Block to handle each regular expression match.
    ///
    /// - Parameters:
    ///   - string: The string.
    ///   - options: The matching options to report. See `NSRegularExpression.MatchingOptions` for the supported values.
    ///   - range: The range of the string to test.
    ///   - block: The Block enumerates the matches of the regular expression in the string.
    ///     The block takes three arguments and returns `Void`:
    ///   - result:
    ///     An `NSTextCheckingResult` specifying the match. This result gives the overall matched range via its `range` property, and the range of each individual capture group via its `range(at:)` method. The range {NSNotFound, 0} is returned if one of the capture groups did not participate in this particular match.
    ///   - flags:
    ///     The current state of the matching progress. See `NSRegularExpression.MatchingFlags` for the possible values.
    ///   - stop:
    ///     A reference to a Boolean value. The Block can set the value to true to stop further processing of the array. The stop argument is an out-only argument. You should only ever set this Boolean to true within the Block.
    #if os(Linux)
    func enumerateMatches(in string: String,
                          options: MatchingOptions = [],
                          range: Range<String.Index>,
                          using block: @escaping (
                              _ result: NSTextCheckingResult?,
                              _ flags: MatchingFlags,
                              _ stop: inout Bool) -> Void) {
        enumerateMatches(in: string,
                         options: options,
                         range: NSRange(range, in: string)) { result, flags, stop in
                var shouldStop = false
                block(result, flags, &shouldStop)
                if shouldStop {
                    stop.pointee = true
                }
        }
    }
    #else
    func enumerateMatches(in string: String,
                          options: MatchingOptions = [],
                          range: Range<String.Index>,
                          using block: (_ result: NSTextCheckingResult?, _ flags: MatchingFlags, _ stop: inout Bool)
                              -> Void) {
        enumerateMatches(in: string,
                         options: options,
                         range: NSRange(range, in: string)) { result, flags, stop in
                var shouldStop = false
                block(result, flags, &shouldStop)
                if shouldStop {
                    stop.pointee = true
                }
        }
    }
    #endif

    /// SwifterSwift: Returns an array containing all the matches of the regular expression in the string.
    ///
    /// - Parameters:
    ///   - string: The string to search.
    ///   - options: The matching options to use. See NSRegularExpression.MatchingOptions for possible values.
    ///   - range: The range of the string to search.
    /// - Returns: An array of `NSTextCheckingResult` objects. Each result gives the overall matched range via its `range` property, and the range of each individual capture group via its `range(at:)` method. The range {NSNotFound, 0} is returned if one of the capture groups did not participate in this particular match.
    func matches(in string: String,
                 options: MatchingOptions = [],
                 range: Range<String.Index>) -> [NSTextCheckingResult] {
        return matches(in: string,
                       options: options,
                       range: NSRange(range, in: string))
    }

    /// SwifterSwift: Returns the number of matches of the regular expression within the specified range of the string.
    ///
    /// - Parameters:
    ///   - string: The string to search.
    ///   - options: The matching options to use. See NSRegularExpression.MatchingOptions for possible values.
    ///   - range: The range of the string to search.
    /// - Returns: The number of matches of the regular expression.
    func numberOfMatches(in string: String,
                         options: MatchingOptions = [],
                         range: Range<String.Index>) -> Int {
        return numberOfMatches(in: string,
                               options: options,
                               range: NSRange(range, in: string))
    }

    /// SwifterSwift: Returns the first match of the regular expression within the specified range of the string.
    ///
    /// - Parameters:
    ///   - string: The string to search.
    ///   - options: The matching options to use. See `NSRegularExpression.MatchingOptions` for possible values.
    ///   - range: The range of the string to search.
    /// - Returns: An `NSTextCheckingResult` object. This result gives the overall matched range via its `range` property, and the range of each individual capture group via its `range(at:)` method. The range {NSNotFound, 0} is returned if one of the capture groups did not participate in this particular match.
    func firstMatch(in string: String,
                    options: MatchingOptions = [],
                    range: Range<String.Index>) -> NSTextCheckingResult? {
        return firstMatch(in: string,
                          options: options,
                          range: NSRange(range, in: string))
    }

    /// SwifterSwift: Returns the range of the first match of the regular expression within the specified range of the string.
    ///
    /// - Parameters:
    ///   - string: The string to search.
    ///   - options: The matching options to use. See `NSRegularExpression.MatchingOptions` for possible values.
    ///   - range: The range of the string to search.
    /// - Returns: The range of the first match. Returns `nil` if no match is found.
    func rangeOfFirstMatch(in string: String,
                           options: MatchingOptions = [],
                           range: Range<String.Index>) -> Range<String.Index>? {
        return Range(rangeOfFirstMatch(in: string,
                                       options: options,
                                       range: NSRange(range, in: string)),
                     in: string)
    }

    /// SwifterSwift: Returns a new string containing matching regular expressions replaced with the template string.
    ///
    /// - Parameters:
    ///   - string: The string to search for values within.
    ///   - options: The matching options to use. See `NSRegularExpression.MatchingOptions` for possible values.
    ///   - range: The range of the string to search.
    ///   - templ: The substitution template used when replacing matching instances.
    /// - Returns: A string with matching regular expressions replaced by the template string.
    func stringByReplacingMatches(in string: String,
                                  options: MatchingOptions = [],
                                  range: Range<String.Index>,
                                  withTemplate templ: String) -> String {
        return stringByReplacingMatches(in: string,
                                        options: options,
                                        range: NSRange(range, in: string),
                                        withTemplate: templ)
    }

    /// SwifterSwift: Replaces regular expression matches within the mutable string using the template string.
    ///
    /// - Parameters:
    ///   - string: The mutable string to search and replace values within.
    ///   - options: The matching options to use. See `NSRegularExpression.MatchingOptions` for possible values.
    ///   - range: The range of the string to search.
    ///   - templ: The substitution template used when replacing matching instances.
    /// - Returns: The number of matches.
    @discardableResult
    func replaceMatches(in string: inout String,
                        options: MatchingOptions = [],
                        range: Range<String.Index>,
                        withTemplate templ: String) -> Int {
        let mutableString = NSMutableString(string: string)
        let matches = replaceMatches(in: mutableString,
                                     options: options,
                                     range: NSRange(range, in: string),
                                     withTemplate: templ)
        string = mutableString.copy() as! String // swiftlint:disable:this force_cast
        return matches
    }
}

#endif
