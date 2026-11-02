// UITextField+ConfigureInput.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UITextField {
    /// SwifterSwift: Sets the content type of the text field, along with the keyboard and typing behavior that suit it.
    ///
    /// `textContentType` is what lets the system offer AutoFill, such as saved passwords, one-time codes from Messages,
    /// and contact details. The keyboard and typing behavior are separate properties that are easy to forget, so this
    /// method sets `textContentType`, `keyboardType`, `autocapitalizationType`, `autocorrectionType` and
    /// `isSecureTextEntry` together:
    ///
    /// | Content type | Keyboard | Capitalization | Autocorrection | Secure |
    /// |---|---|---|---|---|
    /// | `.emailAddress` | `.emailAddress` | `.none` | `.no` | no |
    /// | `.username` | `.default` | `.none` | `.no` | no |
    /// | `.password`, `.newPassword` | `.asciiCapable` | `.none` | `.no` | yes |
    /// | `.oneTimeCode` | `.numberPad` | `.none` | `.no` | no |
    /// | `.telephoneNumber` | `.phonePad` | `.none` | `.no` | no |
    /// | `.URL` | `.URL` | `.none` | `.no` | no |
    /// | `.creditCardNumber`, `.creditCardSecurityCode` | `.numberPad` | `.none` | `.no` | no |
    /// | `.postalCode` | `.default` | `.allCharacters` | `.no` | no |
    /// | Names, organizations and addresses | `.default` | `.words` | `.no` | no |
    /// | Any other type | `.default` | `.sentences` | `.default` | no |
    ///
    /// Names are `.name`, `.namePrefix`, `.givenName`, `.middleName`, `.familyName`, `.nameSuffix`, `.nickname` and
    /// `.creditCardName`; organizations are `.organizationName` and `.jobTitle`; addresses are `.fullStreetAddress`,
    /// `.streetAddressLine1`, `.streetAddressLine2`, `.addressCity`, `.addressState`, `.addressCityAndState`,
    /// `.sublocality` and `.countryName`.
    ///
    /// Every call sets all five properties, so switching a field from `.password` to another type also turns secure
    /// entry off. Passwords get the ASCII-capable keyboard because their characters are hidden as they're typed, so
    /// typing with the wrong keyboard layout would go unnoticed. The placeholder isn't changed.
    ///
    /// ```swift
    /// emailField.configureInput(for: .emailAddress)
    /// emailField.keyboardType  // .emailAddress
    /// passwordField.configureInput(for: .password)
    /// passwordField.isSecureTextEntry  // true
    /// ```
    ///
    /// - Parameter contentType: The kind of content the text field is for.
    func configureInput(for contentType: UITextContentType) {
        let input: (UIKeyboardType, UITextAutocapitalizationType, UITextAutocorrectionType, Bool) =
            switch contentType {
            case .emailAddress:
                (.emailAddress, .none, .no, false)
            case .username:
                (.default, .none, .no, false)
            case .password, .newPassword:
                (.asciiCapable, .none, .no, true)
            case .oneTimeCode, .creditCardNumber, .creditCardSecurityCode:
                (.numberPad, .none, .no, false)
            case .telephoneNumber:
                (.phonePad, .none, .no, false)
            case .URL:
                (.URL, .none, .no, false)
            case .postalCode:
                (.default, .allCharacters, .no, false)
            case .name, .namePrefix, .givenName, .middleName, .familyName, .nameSuffix, .nickname, .creditCardName,
                .organizationName, .jobTitle, .fullStreetAddress, .streetAddressLine1, .streetAddressLine2,
                .addressCity, .addressState, .addressCityAndState, .sublocality, .countryName:
                (.default, .words, .no, false)
            default:
                (.default, .sentences, .default, false)
            }
        textContentType = contentType
        keyboardType = input.0
        autocapitalizationType = input.1
        autocorrectionType = input.2
        isSecureTextEntry = input.3
    }
}
#endif
