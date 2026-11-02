// UITextField+ConfigureInputTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextFieldConfigureInputTests {
    @Test(
        arguments: [
            (.emailAddress, .emailAddress, .none, .no, false),
            (.username, .default, .none, .no, false),
            (.password, .asciiCapable, .none, .no, true),
            (.newPassword, .asciiCapable, .none, .no, true),
            (.oneTimeCode, .numberPad, .none, .no, false),
            (.telephoneNumber, .phonePad, .none, .no, false),
            (.URL, .URL, .none, .no, false),
            (.creditCardNumber, .numberPad, .none, .no, false),
            (.creditCardSecurityCode, .numberPad, .none, .no, false),
            (.postalCode, .default, .allCharacters, .no, false),
            (.name, .default, .words, .no, false),
            (.givenName, .default, .words, .no, false),
            (.familyName, .default, .words, .no, false),
            (.nickname, .default, .words, .no, false),
            (.creditCardName, .default, .words, .no, false),
            (.organizationName, .default, .words, .no, false),
            (.jobTitle, .default, .words, .no, false),
            (.fullStreetAddress, .default, .words, .no, false),
            (.streetAddressLine2, .default, .words, .no, false),
            (.addressCity, .default, .words, .no, false),
            (.sublocality, .default, .words, .no, false),
            (.countryName, .default, .words, .no, false),
            (.location, .default, .sentences, .default, false),
            (.flightNumber, .default, .sentences, .default, false),
            (.dateTime, .default, .sentences, .default, false),
            (UITextContentType(rawValue: "com.example.custom"), .default, .sentences, .default, false)
        ] as [(UITextContentType, UIKeyboardType, UITextAutocapitalizationType, UITextAutocorrectionType, Bool)]
    )
    func configuresTheInputForTheContentType(
        _ contentType: UITextContentType,
        _ keyboardType: UIKeyboardType,
        _ autocapitalizationType: UITextAutocapitalizationType,
        _ autocorrectionType: UITextAutocorrectionType,
        _ isSecureTextEntry: Bool
    ) {
        let textField = UITextField()
        textField.configureInput(for: contentType)
        #expect(textField.textContentType == contentType)
        #expect(textField.keyboardType == keyboardType)
        #expect(textField.autocapitalizationType == autocapitalizationType)
        #expect(textField.autocorrectionType == autocorrectionType)
        #expect(textField.isSecureTextEntry == isSecureTextEntry)
    }

    @Test
    func resetsEveryPropertyWhenTheContentTypeChanges() {
        let textField = UITextField()
        textField.configureInput(for: .password)
        textField.configureInput(for: .givenName)
        #expect(textField.textContentType == .givenName)
        #expect(textField.keyboardType == .default)
        #expect(textField.autocapitalizationType == .words)
        #expect(!textField.isSecureTextEntry)
        textField.configureInput(for: .location)
        #expect(textField.autocapitalizationType == .sentences)
        #expect(textField.autocorrectionType == .default)
    }

    @Test
    func overridesEarlierSettings() {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.autocapitalizationType = .allCharacters
        textField.autocorrectionType = .yes
        textField.isSecureTextEntry = true
        textField.configureInput(for: .emailAddress)
        #expect(textField.keyboardType == .emailAddress)
        #expect(textField.autocapitalizationType == .none)
        #expect(textField.autocorrectionType == .no)
        #expect(!textField.isSecureTextEntry)
    }

    @Test
    func leavesTheTextAndPlaceholderAlone() {
        let textField = UITextField()
        textField.text = "name@example.com"
        textField.placeholder = "Correo electrónico 📧"
        textField.configureInput(for: .emailAddress)
        #expect(textField.text == "name@example.com")
        #expect(textField.placeholder == "Correo electrónico 📧")
    }
}
#endif
