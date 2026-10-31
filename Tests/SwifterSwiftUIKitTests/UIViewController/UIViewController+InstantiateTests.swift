// UIViewController+InstantiateTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewControllerInstantiateTests {
    @Test
    func returnsNilForMissingStoryboard() {
        #expect(UIViewController.instantiate(from: "DoesNotExist") == nil)
        #expect(UIViewController.instantiate(from: "", bundle: .main, identifier: "UIViewController") == nil)
    }

    @Test
    func returnsNilWithoutMainStoryboard() {
        // The test runner has no Main storyboard, so the defaults find nothing instead of raising an exception.
        #expect(UIViewController.instantiate() == nil)
    }

    #if os(iOS)
    /// The files of `Fixtures.storyboardc`, compiled for iOS with `ibtool --compile Fixtures.storyboardc
    /// Fixtures.storyboard --target-device iphone --minimum-deployment-target 17.0`.
    ///
    /// The storyboard has three scenes, each with a Storyboard ID and no custom class:
    /// - "UIViewController": a view controller.
    /// - "UINavigationController": a plain view controller, to test a class that doesn't match.
    /// - "UITableViewController": a table view controller.
    let fixtureFiles: [String: String] = [
        "Info.plist": """
        YnBsaXN0MDDSAQIDCl8QJVVJVmlld0NvbnRyb2xsZXJJZGVudGlmaWVyc1RvTmliTmFtZXNfEBNVSVN0b3J5Ym9hcmRWZXJz
        aW9u0wQFBgcICV8QFlVJTmF2aWdhdGlvbkNvbnRyb2xsZXJfEBBVSVZpZXdDb250cm9sbGVyXxAVVUlUYWJsZVZpZXdDb250
        cm9sbGVyXxAWVUlOYXZpZ2F0aW9uQ29udHJvbGxlcl8QEFVJVmlld0NvbnRyb2xsZXJfEBVVSVRhYmxlVmlld0NvbnRyb2xs
        ZXIQAQgNNUtSa36Wr8LaAAAAAAAAAQEAAAAAAAAACwAAAAAAAAAAAAAAAAAAANw=
        """,
        "UIViewController.nib": """
        TklCQXJjaGl2ZQEAAAAKAAAAEQAAADIAAAASAAAAZQAAACgAAAC+AQAABgAAAOkCAACAgIiBiIWCjYGDjoGCj4GDkIGCkYGD
        koGEk4ODloGBl4WBnIOFn4ODooGFo4ODpoGBp4GIVUlTb3VyY2WLVUlDbGFzc05hbWWHVUlMYWJlbI1VSURlc3RpbmF0aW9u
        l1VJTmliVG9wTGV2ZWxPYmplY3RzS2V5llVJTmliVmlzaWJsZVdpbmRvd3NLZXmOTlNJbmxpbmVkVmFsdWWWVUlTdG9yeWJv
        YXJkSWRlbnRpZmllcpNVSU9yaWdpbmFsQ2xhc3NOYW1llFVJTmliRW5jb2RlckVtcHR5S2V5o1VJTmliQWNjZXNzaWJpbGl0
        eUNvbmZpZ3VyYXRpb25zS2V5lVVJTmliS2V5VmFsdWVQYWlyc0tleYhOUy5ieXRlc5NVSU5pYkNvbm5lY3Rpb25zS2V5lElC
        VUlOaWJMTkVWZXJzaW9uS2V5mVVJTmliVHJhaXRTdG9yYWdlTGlzdHNLZXmZVUlQcm94aWVkT2JqZWN0SWRlbnRpZmllco9V
        SU5pYk9iamVjdHNLZXmECgEAAACRCgoAAACNCgsAAACFChAAAACKChAAAACPChAAAACLChAAAACOAAGGBYkKAgAAAIkKBAAA
        AIkKBgAAAIkKCAAAAJAKAwAAAIwIjElCRmlsZXNPd25lcpAKBQAAAIwIkElCRmlyc3RSZXNwb25kZXKQCgcAAACMCJdVSVN0
        b3J5Ym9hcmRQbGFjZWhvbGRlcocKCQAAAIEKCQAAAIgKCQAAAIwIkFVJVmlld0NvbnRyb2xsZXKGBYkKAgAAAIkKBAAAAIkK
        BgAAAIkKCAAAAIYFiQoMAAAAiQoOAAAAggoNAAAAgAoIAAAAgwoGAAAAjAiKc3Rvcnlib2FyZIIKDwAAAIAKAgAAAIMKCAAA
        AIwIk3NjZW5lVmlld0NvbnRyb2xsZXKGBYmATlNPYmplY3QAiIBOU0FycmF5AI6AVUlQcm94eU9iamVjdACJgE5TU3RyaW5n
        AI+AVUlDbGFzc1N3YXBwZXIAmoBVSVJ1bnRpbWVPdXRsZXRDb25uZWN0aW9uAExORQA=
        """,
        "UINavigationController.nib": """
        TklCQXJjaGl2ZQEAAAAKAAAAEgAAADIAAAASAAAAaAAAACkAAADBAQAABgAAAAUDAACAgIiBiIWCjYGDjoGCj4GDkIGCkYGD
        koGEk4ODloGDl4GBmIWBnYOFoIODo4GFpIODp4GBqIGIVUlTb3VyY2WLVUlDbGFzc05hbWWHVUlMYWJlbI1VSURlc3RpbmF0
        aW9ul1VJTmliVG9wTGV2ZWxPYmplY3RzS2V5llVJTmliVmlzaWJsZVdpbmRvd3NLZXmOTlNJbmxpbmVkVmFsdWWWVUlTdG9y
        eWJvYXJkSWRlbnRpZmllcpNVSU9yaWdpbmFsQ2xhc3NOYW1llFVJTmliRW5jb2RlckVtcHR5S2V5o1VJTmliQWNjZXNzaWJp
        bGl0eUNvbmZpZ3VyYXRpb25zS2V5lVVJTmliS2V5VmFsdWVQYWlyc0tleYhOUy5ieXRlc5NVSU5pYkNvbm5lY3Rpb25zS2V5
        lElCVUlOaWJMTkVWZXJzaW9uS2V5mVVJTmliVHJhaXRTdG9yYWdlTGlzdHNLZXmZVUlQcm94aWVkT2JqZWN0SWRlbnRpZmll
        co9VSU5pYk9iamVjdHNLZXmECgEAAACRCgsAAACNCgwAAACFChEAAACKChEAAACPChEAAACLChEAAACOAAGGBYkKAgAAAIkK
        BAAAAIkKBgAAAIkKCAAAAJAKAwAAAIwIjElCRmlsZXNPd25lcpAKBQAAAIwIkElCRmlyc3RSZXNwb25kZXKQCgcAAACMCJdV
        SVN0b3J5Ym9hcmRQbGFjZWhvbGRlcocKCQAAAIEKCgAAAIgKCgAAAIwIllVJTmF2aWdhdGlvbkNvbnRyb2xsZXKMCJBVSVZp
        ZXdDb250cm9sbGVyhgWJCgIAAACJCgQAAACJCgYAAACJCggAAACGBYkKDQAAAIkKDwAAAIIKDgAAAIAKCAAAAIMKBgAAAIwI
        inN0b3J5Ym9hcmSCChAAAACACgIAAACDCggAAACMCJNzY2VuZVZpZXdDb250cm9sbGVyhgWJgE5TT2JqZWN0AIiATlNBcnJh
        eQCOgFVJUHJveHlPYmplY3QAiYBOU1N0cmluZwCPgFVJQ2xhc3NTd2FwcGVyAJqAVUlSdW50aW1lT3V0bGV0Q29ubmVjdGlv
        bgBMTkUA
        """,
        "UITableViewController.nib": """
        TklCQXJjaGl2ZQEAAAAKAAAAEQAAADIAAAASAAAAZQAAACgAAAC+AQAABgAAAO4CAACAgIiBiIWCjYGDjoGCj4GDkIGCkYGD
        koGEk4ODloGBl4WBnIOFn4ODooGFo4ODpoGBp4GIVUlTb3VyY2WLVUlDbGFzc05hbWWHVUlMYWJlbI1VSURlc3RpbmF0aW9u
        l1VJTmliVG9wTGV2ZWxPYmplY3RzS2V5llVJTmliVmlzaWJsZVdpbmRvd3NLZXmOTlNJbmxpbmVkVmFsdWWWVUlTdG9yeWJv
        YXJkSWRlbnRpZmllcpNVSU9yaWdpbmFsQ2xhc3NOYW1llFVJTmliRW5jb2RlckVtcHR5S2V5o1VJTmliQWNjZXNzaWJpbGl0
        eUNvbmZpZ3VyYXRpb25zS2V5lVVJTmliS2V5VmFsdWVQYWlyc0tleYhOUy5ieXRlc5NVSU5pYkNvbm5lY3Rpb25zS2V5lElC
        VUlOaWJMTkVWZXJzaW9uS2V5mVVJTmliVHJhaXRTdG9yYWdlTGlzdHNLZXmZVUlQcm94aWVkT2JqZWN0SWRlbnRpZmllco9V
        SU5pYk9iamVjdHNLZXmECgEAAACRCgoAAACNCgsAAACFChAAAACKChAAAACPChAAAACLChAAAACOAAGGBYkKAgAAAIkKBAAA
        AIkKBgAAAIkKCAAAAJAKAwAAAIwIjElCRmlsZXNPd25lcpAKBQAAAIwIkElCRmlyc3RSZXNwb25kZXKQCgcAAACMCJdVSVN0
        b3J5Ym9hcmRQbGFjZWhvbGRlcocKCQAAAIEKCQAAAIgKCQAAAIwIlVVJVGFibGVWaWV3Q29udHJvbGxlcoYFiQoCAAAAiQoE
        AAAAiQoGAAAAiQoIAAAAhgWJCgwAAACJCg4AAACCCg0AAACACggAAACDCgYAAACMCIpzdG9yeWJvYXJkggoPAAAAgAoCAAAA
        gwoIAAAAjAiTc2NlbmVWaWV3Q29udHJvbGxlcoYFiYBOU09iamVjdACIgE5TQXJyYXkAjoBVSVByb3h5T2JqZWN0AImATlNT
        dHJpbmcAj4BVSUNsYXNzU3dhcHBlcgCagFVJUnVudGltZU91dGxldENvbm5lY3Rpb24ATE5FAA==
        """
    ]

    /// Writes the compiled fixture storyboard into a new temporary directory and returns it as a bundle.
    func makeFixtureBundle() throws -> (bundle: Bundle, directory: URL) {
        let directory = FileManager.default.temporaryDirectory.appending(path: "SwifterSwift-\(UUID().uuidString)")
        let storyboardDirectory = directory.appending(path: "Fixtures.storyboardc")
        try FileManager.default.createDirectory(at: storyboardDirectory, withIntermediateDirectories: true)
        for (name, base64) in fixtureFiles {
            let data = try #require(Data(base64Encoded: base64, options: .ignoreUnknownCharacters))
            try data.write(to: storyboardDirectory.appending(path: name))
        }
        return (try #require(Bundle(url: directory)), directory)
    }

    @Test
    func usesClassNameAsIdentifier() throws {
        let fixture = try makeFixtureBundle()
        defer { try? FileManager.default.removeItem(at: fixture.directory) }
        let viewController = try #require(UIViewController.instantiate(from: "Fixtures", bundle: fixture.bundle))
        #expect(type(of: viewController) == UIViewController.self)
    }

    @Test
    func instantiatesSubclassFromItsClassName() throws {
        let fixture = try makeFixtureBundle()
        defer { try? FileManager.default.removeItem(at: fixture.directory) }
        let tableViewController = UITableViewController.instantiate(from: "Fixtures", bundle: fixture.bundle)
        #expect(tableViewController != nil)
        #expect(tableViewController?.tableView != nil)
    }

    @Test
    func usesGivenIdentifier() throws {
        let fixture = try makeFixtureBundle()
        defer { try? FileManager.default.removeItem(at: fixture.directory) }
        let viewController = UIViewController.instantiate(
            from: "Fixtures",
            bundle: fixture.bundle,
            identifier: "UITableViewController"
        )
        #expect(viewController is UITableViewController)
    }

    @Test
    func returnsNilWhenSceneCreatesAnotherClass() throws {
        let fixture = try makeFixtureBundle()
        defer { try? FileManager.default.removeItem(at: fixture.directory) }
        #expect(UINavigationController.instantiate(from: "Fixtures", bundle: fixture.bundle) == nil)
        #expect(
            UITableViewController.instantiate(
                from: "Fixtures",
                bundle: fixture.bundle,
                identifier: "UIViewController"
            ) == nil
        )
    }

    @Test
    func returnsNilForMissingStoryboardInBundle() throws {
        let fixture = try makeFixtureBundle()
        defer { try? FileManager.default.removeItem(at: fixture.directory) }
        #expect(UIViewController.instantiate(from: "Other", bundle: fixture.bundle) == nil)
    }
    #endif
}
#endif
