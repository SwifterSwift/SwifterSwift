// UITabBarExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UITabBarExtensionsTests: XCTestCase {
    func testSetColors() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        var tabBar = UITabBar(frame: frame)
        tabBar.setColors(background: .red, selectedBackground: .orange, item: .white, selectedItem: .black)

        XCTAssertEqual(tabBar.barTintColor, .red)

        tabBar = UITabBar(frame: frame)
        tabBar.setColors()
        XCTAssertNotEqual(tabBar.barTintColor, .red)

        let bundle = Bundle(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!

        let item1 = UITabBarItem(title: "First", image: image, selectedImage: image)
        let item2 = UITabBarItem(title: "Second", image: nil, selectedImage: nil)
        tabBar.items = [item1, item2]
        tabBar.selectedItem = item1
        XCTAssertNotNil(tabBar.selectedItem)

        tabBar.setColors(selectedBackground: .orange, item: .white, selectedItem: .black)
    }
}

#endif
