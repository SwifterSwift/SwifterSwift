// UIApplicationExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
final class UIApplicationExtensionsTests: XCTestCase {
    
    func testTopSafeAreaInsets() {
        let topInsets = UIApplication.shared.topSafeAreaInsets
        XCTAssertGreaterThanOrEqual(topInsets, 0)
        
        // Test that it returns a reasonable value (should be 0 or positive)
        // On devices with notch, this should be > 0
        // On devices without notch, this should be 0 or status bar height
        XCTAssertLessThanOrEqual(topInsets, 100) // Reasonable upper bound
    }
    
    func testBottomSafeAreaInsets() {
        let bottomInsets = UIApplication.shared.bottomSafeAreaInsets
        XCTAssertGreaterThanOrEqual(bottomInsets, 0)
        
        // Test that it returns a reasonable value
        // On devices with home indicator, this should be > 0
        // On devices without home indicator, this should be 0
        XCTAssertLessThanOrEqual(bottomInsets, 50) // Reasonable upper bound
    }
    
    func testLeftSafeAreaInsets() {
        let leftInsets = UIApplication.shared.leftSafeAreaInsets
        XCTAssertGreaterThanOrEqual(leftInsets, 0)
        
        // Test that it returns a reasonable value
        // Most devices should have 0 left safe area insets
        XCTAssertLessThanOrEqual(leftInsets, 50) // Reasonable upper bound
    }
    
    func testRightSafeAreaInsets() {
        let rightInsets = UIApplication.shared.rightSafeAreaInsets
        XCTAssertGreaterThanOrEqual(rightInsets, 0)
        
        // Test that it returns a reasonable value
        // Most devices should have 0 right safe area insets
        XCTAssertLessThanOrEqual(rightInsets, 50) // Reasonable upper bound
    }
    
    func testHorizontalSafeAreaInsets() {
        let horizontalInsets = UIApplication.shared.horizontalSafeAreaInsets
        XCTAssertGreaterThanOrEqual(horizontalInsets, 0)
        
        // Horizontal insets should be the sum of left and right
        let leftInsets = UIApplication.shared.leftSafeAreaInsets
        let rightInsets = UIApplication.shared.rightSafeAreaInsets
        XCTAssertEqual(horizontalInsets, leftInsets + rightInsets)
        
        // Test that it returns a reasonable value
        XCTAssertLessThanOrEqual(horizontalInsets, 100) // Reasonable upper bound
    }
    
    func testVerticalSafeAreaInsets() {
        let verticalInsets = UIApplication.shared.verticalSafeAreaInsets
        XCTAssertGreaterThanOrEqual(verticalInsets, 0)
        
        // Vertical insets should be the sum of top and bottom
        let topInsets = UIApplication.shared.topSafeAreaInsets
        let bottomInsets = UIApplication.shared.bottomSafeAreaInsets
        XCTAssertEqual(verticalInsets, topInsets + bottomInsets)
        
        // Test that it returns a reasonable value
        XCTAssertLessThanOrEqual(verticalInsets, 150) // Reasonable upper bound
    }
    
    func testSafeAreaInsetsConsistency() {
        // Test that all safe area insets are consistent with each other
        let topInsets = UIApplication.shared.topSafeAreaInsets
        let bottomInsets = UIApplication.shared.bottomSafeAreaInsets
        let leftInsets = UIApplication.shared.leftSafeAreaInsets
        let rightInsets = UIApplication.shared.rightSafeAreaInsets
        let horizontalInsets = UIApplication.shared.horizontalSafeAreaInsets
        let verticalInsets = UIApplication.shared.verticalSafeAreaInsets
        
        // Verify horizontal calculation
        XCTAssertEqual(horizontalInsets, leftInsets + rightInsets)
        
        // Verify vertical calculation
        XCTAssertEqual(verticalInsets, topInsets + bottomInsets)
        
        // All values should be non-negative
        XCTAssertGreaterThanOrEqual(topInsets, 0)
        XCTAssertGreaterThanOrEqual(bottomInsets, 0)
        XCTAssertGreaterThanOrEqual(leftInsets, 0)
        XCTAssertGreaterThanOrEqual(rightInsets, 0)
        XCTAssertGreaterThanOrEqual(horizontalInsets, 0)
        XCTAssertGreaterThanOrEqual(verticalInsets, 0)
    }
    
    func testSafeAreaInsetsWithKeyWindow() {
        // Test that the safe area insets match what we get from the key window
        guard let keyWindow = UIWindow.keyWindow else {
            XCTFail("Key window should be available during tests")
            return
        }
        
        let windowSafeAreaInsets = keyWindow.safeAreaInsets
        
        XCTAssertEqual(UIApplication.shared.topSafeAreaInsets, windowSafeAreaInsets.top)
        XCTAssertEqual(UIApplication.shared.bottomSafeAreaInsets, windowSafeAreaInsets.bottom)
        XCTAssertEqual(UIApplication.shared.leftSafeAreaInsets, windowSafeAreaInsets.left)
        XCTAssertEqual(UIApplication.shared.rightSafeAreaInsets, windowSafeAreaInsets.right)
        XCTAssertEqual(UIApplication.shared.horizontalSafeAreaInsets, windowSafeAreaInsets.horizontal)
        XCTAssertEqual(UIApplication.shared.verticalSafeAreaInsets, windowSafeAreaInsets.vertical)
    }
}

#endif
