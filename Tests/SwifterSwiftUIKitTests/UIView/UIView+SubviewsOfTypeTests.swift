// UIView+SubviewsOfTypeTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewSubviewsOfTypeTests {
    /// A protocol that no UIKit view adopts.
    protocol Badge {}

    final class BadgeView: UIView, Badge {}

    final class BadgeLabel: UILabel, Badge {}

    @Test
    func returnsEmptyArrayWithoutSubviews() {
        #expect(UIView().subviews(ofType: UILabel.self).isEmpty)
        #expect(UIView().subviews(ofType: (any Badge).self).isEmpty)
    }

    @Test
    func findsMatchesAtEveryDepth() {
        let root = UIView()
        let child = UIView()
        let child2 = UIView()
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        root.addSubview(child)
        root.addSubview(child2)
        child.addSubview(label1)
        child.addSubview(UIImageView())
        child.addSubview(label2)
        child2.addSubview(UITextView())
        child2.addSubview(label3)
        #expect(root.subviews(ofType: UILabel.self) == [label1, label2, label3])
        #expect(root.subviews(ofType: UITableViewCell.self).isEmpty)
    }

    @Test
    func keepsSearchingInsideMatches() {
        let root = UIView()
        let outer = UIStackView()
        let inner = UIStackView()
        let deepest = UIStackView()
        root.addSubview(outer)
        outer.addSubview(inner)
        inner.addSubview(deepest)
        #expect(root.subviews(ofType: UIStackView.self) == [outer, inner, deepest])
    }

    @Test
    func returnsMatchesInDepthFirstOrder() {
        let root = UIView()
        let first = UIView()
        let firstChild = UIView()
        let second = UIView()
        root.addSubview(first)
        first.addSubview(firstChild)
        root.addSubview(second)
        #expect(root.subviews(ofType: UIView.self) == [first, firstChild, second])
    }

    @Test
    func excludesTheViewItself() {
        let label = UILabel()
        #expect(label.subviews(ofType: UILabel.self).isEmpty)
        let badge = BadgeView()
        #expect(badge.subviews(ofType: (any Badge).self).isEmpty)
    }

    @Test
    func matchesSubclasses() {
        let root = UIView()
        let button = UIButton()
        let textField = UITextField()
        root.addSubview(button)
        root.addSubview(textField)
        #expect(root.subviews(ofType: UIControl.self) == [button, textField])
    }

    @Test
    func findsViewsByProtocol() {
        let root = UIView()
        let badgeView = BadgeView()
        let badgeLabel = BadgeLabel()
        let plainLabel = UILabel()
        let nestedBadge = BadgeView()
        root.addSubview(badgeView)
        root.addSubview(plainLabel)
        badgeView.addSubview(badgeLabel)
        plainLabel.addSubview(nestedBadge)
        let badges = root.subviews(ofType: (any Badge).self)
        #expect(badges.map { $0 as? UIView } == [badgeView, badgeLabel, nestedBadge])
    }

    @Test
    func findsViewsBySDKProtocol() {
        let root = UIView()
        let container = UIView()
        let title = UILabel()
        let subtitle = UILabel()
        root.addSubview(title)
        root.addSubview(UIImageView())
        root.addSubview(container)
        container.addSubview(subtitle)
        let adjusting = root.subviews(ofType: (any UIContentSizeCategoryAdjusting).self)
        #expect(adjusting.map { $0 as? UIView } == [title, subtitle])
    }

    @Test
    func returnsEmptyArrayForTypesNoViewCanBe() {
        let root = UIView()
        root.addSubview(UILabel())
        root.addSubview(BadgeView())
        #expect(root.subviews(ofType: Int.self).isEmpty)
        #expect(root.subviews(ofType: String.self).isEmpty)
        #expect(root.subviews(ofType: (any Sequence).self).isEmpty)
    }
}
#endif
