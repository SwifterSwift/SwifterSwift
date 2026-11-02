// String+IsValidEmail.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Whether the string is formatted like an email address.
    ///
    /// This checks the format only; it doesn't check that the domain exists or that the mailbox can receive mail. The
    /// whole string must be the address, so surrounding spaces, display names (`"Joe <joe@example.com>"`) and comments
    /// are rejected.
    ///
    /// The local part (before the `@`) is either dot-separated atoms of letters, digits, the backtick and
    /// `!#$%&'*+/=?^_{|}~-`, or a quoted string. The domain is either two or more dot-separated labels of letters, digits and inner hyphens, or
    /// an address literal in square brackets, such as `[192.168.0.1]`. Letters may be any Unicode letters in either
    /// case, so internationalized addresses such as `josé@exämple.com` pass. A domain without a dot, such as
    /// `localhost`, doesn't.
    ///
    /// ```swift
    /// "john.doe@example.com".isValidEmail  // true
    /// "JOHN@EXAMPLE.COM".isValidEmail  // true
    /// "john@example".isValidEmail  // false
    /// "john..doe@example.com".isValidEmail  // false
    /// " john@example.com".isValidEmail  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isValidEmail: Bool {
        let email =
            #/
            (?:
                [\p{L}0-9!\#$%&'*+\/=?^_`{|}~-]+ (?: \. [\p{L}0-9!\#$%&'*+\/=?^_`{|}~-]+ )*
              | " (?: [\x01-\x08\x0B\x0C\x0E-\x1F\x21\x23-\x5B\x5D-\x7F] | \\ [\x01-\x09\x0B\x0C\x0E-\x7F] )* "
            )
            @
            (?:
                (?: [\p{L}0-9] (?: [\p{L}0-9-]* [\p{L}0-9] )? \. )+ [\p{L}0-9] (?: [\p{L}0-9-]* [\p{L}0-9] )?
              | \[
                (?:
                    (?: (?: 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? ) \. ){3}
                    (?: 25[0-5] | 2[0-4][0-9] | [01]?[0-9][0-9]? )
                  | [\p{L}0-9-]* [\p{L}0-9] :
                    (?: [\x01-\x08\x0B\x0C\x0E-\x1F\x21-\x5A\x5E-\x7F] | \\ [\x01-\x09\x0B\x0C\x0E-\x7F] )+
                )
                \]
            )
            /#
        return wholeMatch(of: email) != nil
    }
}
