// UIView+LoadFromNibWithClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewLoadFromNibWithClassTests {
    /// A nib compiled from a XIB whose top-level objects are, in order, a tap gesture recognizer, a `UILabel` with the
    /// text "Card", and a `UIView`.
    static let cardNibBase64 = [
        "TklCQXJjaGl2ZQEAAAAKAAAAGQAAADIAAAA1AAAAfQAAAFsAAACKBAAADwAAABsHAACAgIiBiIaCjoGDj4GCkIGDkYGEkoOFgICG",
        "lZKDp4GHqIqDsoGIs4KJtYWDuoGDu4GDvIGKvYGLvoaDxIGLxYaDy4GMzIiB1IaB2oGWVUlOaWJWaXNpYmxlV2luZG93c0tleaNV",
        "SU5pYkFjY2Vzc2liaWxpdHlDb25maWd1cmF0aW9uc0tleYhVSUJvdW5kc4hOUy5ieXRlc5RVSU5pYkVuY29kZXJFbXB0eUtleZlV",
        "SVVzZXJJbnRlcmFjdGlvbkRpc2FibGVkhk5TU2l6ZYpVSUZvbnROYW1lkFVJRm9udERlc2NyaXB0b3KZVUlGb250UG9pbnRTaXpl",
        "Rm9yU2NhbGluZ4ZVSUZvbnSOTlNJbmxpbmVkVmFsdWWNVUlDb250ZW50TW9kZYdOU1doaXRlr1VJRGlzYWJsZVVwZGF0ZVRleHRD",
        "b2xvck9uVHJhaXRDb2xsZWN0aW9uQ2hhbmdll1VJRm9udERlc2NyaXB0b3JPcHRpb25zolVJVmlld0xhcmdlQ29udGVudFN0b3Jl",
        "ZFByb3BlcnRpZXOMVUlTeXN0ZW1Gb250klVJSGlnaGxpZ2h0ZWRDb2xvcotVSVRleHRDb2xvcpRVSUF1dG9yZXNpemVTdWJ2aWV3",
        "c6VVSUdlc3R1cmVSZWNvZ25pemVyLmFsbG93ZWRUb3VjaFR5cGVzh1VJQWxwaGGIVUlPcGFxdWWHVUlXaGl0ZZVVSU5pYktleVZh",
        "bHVlUGFpcnNLZXmUSUJVSU5pYkxORVZlcnNpb25LZXmZVUlGb250VGV4dFN0eWxlRm9yU2NhbGluZ5dVSU5pYlRvcExldmVsT2Jq",
        "ZWN0c0tleY5VSVNoYWRvd09mZnNldJFVSVN5c3RlbUNvbG9yTmFtZYZOU05hbWWIVUlDZW50ZXKTVUlOaWJDb25uZWN0aW9uc0tl",
        "eZlVSU5pYlRyYWl0U3RvcmFnZUxpc3RzS2V5mlVJRm9udERlc2NyaXB0b3JBdHRyaWJ1dGVzmVVJUHJveGllZE9iamVjdElkZW50",
        "aWZpZXKUVUlCYXNlbGluZUFkanVzdG1lbnSWVUlBZGp1c3RzRm9udFNpemVUb0ZpdK5VSUdlc3R1cmVSZWNvZ25pemVyLnJlcXVp",
        "cmVzRXhjbHVzaXZlVG91Y2hUeXBlnlVJVmlld1NlbWFudGljQ29udGVudEF0dHJpYnV0ZY5VSURlZXBEcmF3UmVjdI9VSVRleHRB",
        "bGlnbm1lbnSMTlNDb2xvclNwYWNllVVJQ29sb3JDb21wb25lbnRDb3VudKJVSUZvbnRNYXhpbXVtUG9pbnRTaXplQWZ0ZXJTY2Fs",
        "aW5njFVJRm9udFRyYWl0c5tVSVRhcEdlc3R1cmVSZWNvZ25pemVyLl9pbXCSVUlBdXRvcmVzaXppbmdNYXNrj1VJTmliT2JqZWN0",
        "c0tleYZVSVRleHSJTlMuZGJsdmFsj1VJRm9udFBvaW50U2l6ZZwKAQAAALEKFwAAAKEKGAAAAIAKGAAAAIEKGAAAAKIKGAAAAJkK",
        "GAAAAJoAAYsFhAoCAAAAhAoEAAAAhAoGAAAAhAoIAAAAhAoWAAAApAoDAAAAgwiMSUJGaWxlc093bmVypAoFAAAAgwiQSUJGaXJz",
        "dFJlc3BvbmRlcpUAD6cFrwoHAAAAggihBwAAAAAAAAAAAAAAAAAAAAAAAAAAAABZQAAAAAAAADRAoAiRBwAAAAAAAElAAAAAAAAA",
        "JECpBYUFlAWwACSMAAeoAACQCbIKCQAAAIoKCgAAAJMKEgAAAJIKFAAAAJ0IkQcAAAAAAAAAAAAAAAAAAPC/pQABpgWqAACOBYMI",
        "hENhcmSHCgsAAACICgwAAAC0BwAAAAAAADFAmwmJBwAAAAAAAAAArQcAAAAAAAAAAK4AAJEFnwoLAAAAhgcAAAAAAAAxQIMIjS5T",
        "RlVJLVJlZ3VsYXKjCg0AAACPAwSEAIAAAAAAiwWECg4AAACECg8AAACEChAAAACEChEAAACDCJhOU0NURm9udFVJVXNhZ2VBdHRy",
        "aWJ1dGWDCJJDVEZvbnRSZWd1bGFyVXNhZ2WDCJNOU0ZvbnRTaXplQXR0cmlidXRlswcAAAAAAAAxQJ4KEwAAAKwAApgGAAAAAJYG",
        "AACAP40IgTCrAASDCIpsYWJlbENvbG9yngoVAAAArAACmAYAAAAAlgYAAIA/jQiBMKsABIMIimJsYWNrQ29sb3KCCKEHAAAAAAAA",
        "AAAAAAAAAAAAAAAAAAAAAFlAAAAAAAAASUCgCJEHAAAAAAAASUAAAAAAAAA5QKkFlwWUBbAAJKgAAJAJiwWECgIAAACECgQAAACE",
        "CgYAAACECggAAACEChYAAACLBYmATlNPYmplY3QAiIBOU0FycmF5AI6AVUlQcm94eU9iamVjdACJgE5TU3RyaW5nAJeAVUlUYXBH",
        "ZXN0dXJlUmVjb2duaXplcgCQgFVJVGFwUmVjb2duaXplcgCIgFVJTGFiZWwAh4EOAAAAVUlGb250AJGAVUlGb250RGVzY3JpcHRv",
        "cgCNgE5TRGljdGlvbmFyeQCJgE5TTnVtYmVyAIiBDQAAAFVJQ29sb3IAh4BVSVZpZXcAiIBOU0NvbG9yAIeATlNGb250AExORQA="
    ].joined()

    func makeBundle(nibNames: [String]) throws -> Bundle {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let data = try #require(Data(base64Encoded: Self.cardNibBase64))
        for name in nibNames {
            try data.write(to: directory.appendingPathComponent("\(name).nib"))
        }
        return try #require(Bundle(url: directory))
    }

    @Test
    func loadsNibNamedAfterClass() throws {
        let bundle = try makeBundle(nibNames: ["UILabel"])
        let label = try #require(UIView.loadFromNib(withClass: UILabel.self, bundle: bundle))
        #expect(label.text == "Card")
    }

    @Test
    func returnsFirstTopLevelInstanceOfClassOrSubclass() throws {
        let bundle = try makeBundle(nibNames: ["UIView"])
        let view = try #require(UIView.loadFromNib(withClass: UIView.self, bundle: bundle))
        #expect(view is UILabel)
    }

    @Test
    func returnsNilWhenNibHasNoViewOfClass() throws {
        let bundle = try makeBundle(nibNames: ["UIButton"])
        #expect(UIView.loadFromNib(withClass: UIButton.self, bundle: bundle) == nil)
    }

    @Test
    func returnsNilWhenNibIsMissing() throws {
        let bundle = try makeBundle(nibNames: ["UILabel"])
        #expect(UIView.loadFromNib(withClass: UIImageView.self, bundle: bundle) == nil)
        #expect(UIView.loadFromNib(withClass: UIImageView.self) == nil)
    }
}
#endif
