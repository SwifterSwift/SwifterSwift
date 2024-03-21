// UIViewExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

// swiftlint:disable:next type_body_length
final class UIViewExtensionsTests: XCTestCase {
    func testBorderColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layerBorderColor = nil
        XCTAssertNil(view.layerBorderColor)
        view.layerBorderColor = UIColor.red
        XCTAssertNotNil(view.layer.borderColor)
        XCTAssertEqual(view.layerBorderColor!, UIColor.red)
        XCTAssertEqual(view.layer.borderColor!.uiColor, UIColor.red)
    }

    func testBorderWidth() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layerBorderWidth = 0
        XCTAssertEqual(view.layer.borderWidth, 0)

        view.layerBorderWidth = 5
        XCTAssertEqual(view.layerBorderWidth, 5)
    }

    func testCornerRadius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.layer.cornerRadius, 0)

        view.layerCornerRadius = 50
        XCTAssertEqual(view.layerCornerRadius, 50)
    }

    func testFirstResponder() {
        // When there's no firstResponder
        XCTAssertNil(UIView().firstResponder())

        let window = UIWindow()

        // When self is firstResponder
        let txtView = UITextField(frame: CGRect.zero)
        window.addSubview(txtView)
        txtView.becomeFirstResponder()
        XCTAssert(txtView.firstResponder() === txtView)

        // When a subview is firstResponder
        let superView = UIView()
        window.addSubview(superView)
        let subView = UITextField(frame: CGRect.zero)
        superView.addSubview(subView)
        subView.becomeFirstResponder()
        XCTAssert(superView.firstResponder() === subView)

        // When you have to find recursively
        XCTAssert(window.firstResponder() === subView)
    }

    func testHeight() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.height, 100)
        view.height = 150
        XCTAssertEqual(view.frame.size.height, 150)
    }

    func testIsRightToLeft() {
        let view = UIView()
        XCTAssertFalse(view.isRightToLeft)
    }

    func testRoundCorners() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.roundCorners([.allCorners], radius: 5.0)

        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.allCorners],
                                    cornerRadii: CGSize(width: 5.0, height: 5.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        XCTAssertEqual(view.layer.mask?.bounds, shape.bounds)
        XCTAssertEqual(view.layer.mask?.cornerRadius, shape.cornerRadius)
    }

    func testMakeCircle() {
        let view = UIView()
        view.makeCircle(diameter: 100)
        XCTAssertEqual(view.frame.size.width, 100)
        XCTAssertEqual(view.frame.size.height, 100)
        XCTAssertEqual(view.layer.cornerRadius, 50)
    }

    func testShadowColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layer.shadowColor = nil
        XCTAssertNil(view.layerShadowColor)
        view.layerShadowColor = UIColor.orange
        XCTAssertNotNil(view.layer.shadowColor!)
        XCTAssertEqual(view.layerShadowColor, UIColor.orange)
    }

    func testScreenshot() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.backgroundColor = .black
        let screenshot = view.screenshot
        XCTAssertNotNil(screenshot)

        let view2 = UIView()
        XCTAssertNil(view2.screenshot)
    }

    func testShadowOffset() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layer.shadowOffset = CGSize.zero
        XCTAssertEqual(view.layerShadowOffset, CGSize.zero)
        let size = CGSize(width: 5, height: 5)
        view.layerShadowOffset = size
        XCTAssertEqual(view.layer.shadowOffset, size)
    }

    func testShadowOpacity() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layer.shadowOpacity = 0
        XCTAssertEqual(view.layerShadowOpacity, 0)
        view.layerShadowOpacity = 0.5
        XCTAssertEqual(view.layer.shadowOpacity, 0.5)
    }

    func testShadowRadius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layer.shadowRadius = 0
        XCTAssertEqual(view.layerShadowRadius, 0)
        view.layerShadowRadius = 0.5
        XCTAssertEqual(view.layer.shadowRadius, 0.5)
    }

    func testAddShadow() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.addShadow(ofColor: .red, radius: 5.0, offset: .zero, opacity: 0.5)
        XCTAssertEqual(view.layerShadowColor, UIColor.red)
        XCTAssertEqual(view.layerShadowRadius, 5.0)
        XCTAssertEqual(view.layerShadowOffset, CGSize.zero)
        XCTAssertEqual(view.layerShadowOpacity, 0.5)
    }

    func testMasksToBounds() {
        let view = UIView(frame: .zero)
        view.layer.masksToBounds = true
        XCTAssertTrue(view.masksToBounds)
        view.masksToBounds = false
        XCTAssertFalse(view.masksToBounds)
    }

    func testSize() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.size, view.frame.size)

        view.size = CGSize(width: 50, height: 50)
        XCTAssertEqual(view.frame.size.width, 50)
        XCTAssertEqual(view.frame.size.height, 50)
    }

    func testParentViewController() {
        let viewController = UIViewController()
        XCTAssertNotNil(viewController.view.parentViewController)
        XCTAssertEqual(viewController.view.parentViewController, viewController)

        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertNil(view.parentViewController)
    }

    func testX() {
        let frame = CGRect(x: 20, y: 20, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.x, 20)
        view.x = 10
        XCTAssertEqual(view.frame.origin.x, 10)
    }

    func testY() {
        let frame = CGRect(x: 20, y: 20, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.y, 20)
        view.y = 10
        XCTAssertEqual(view.frame.origin.y, 10)
    }

    func testWidth() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.width, 100)
        view.width = 150
        XCTAssertEqual(view.frame.size.width, 150)
    }

    func testAddSubviews() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = UIView(frame: frame)
        XCTAssertEqual(view.subviews.count, 0)

        view.addSubviews([UIView(), UIView()])
        XCTAssertEqual(view.subviews.count, 2)
    }

    func testBlur() {
        let imageView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        imageView.blur(withStyle: .dark)

        let blurView = imageView.subviews.first as? UIVisualEffectView
        XCTAssertNotNil(blurView)
        XCTAssertNotNil(blurView?.effect)
        XCTAssertEqual(blurView?.frame, imageView.bounds)
        XCTAssertEqual(blurView?.autoresizingMask, [.flexibleWidth, .flexibleHeight])
        XCTAssert(imageView.clipsToBounds)
    }

    func testFadeIn() {
        let view1 = UIView()
        view1.isHidden = true
        view1.alpha = 0

        view1.fadeIn(duration: 0, completion: nil)
        XCTAssertFalse(view1.isHidden)
        XCTAssertEqual(view1.alpha, 1)

        let fadeInExpectation = expectation(description: "Faded in")

        let view2 = UIView()
        view2.alpha = 0
        XCTAssertFalse(view1.isHidden)

        view2.fadeIn(duration: 0.5) { _ in
            fadeInExpectation.fulfill()
        }

        XCTAssertEqual(view2.alpha, 1)
        waitForExpectations(timeout: 0.5)
    }

    func testFadeOut() {
        let view1 = UIView()
        view1.isHidden = true

        view1.fadeOut(duration: 0, completion: nil)
        XCTAssertFalse(view1.isHidden)
        XCTAssertEqual(view1.alpha, 0)

        let fadeOutExpectation = expectation(description: "Faded out")

        let view2 = UIView()
        XCTAssertFalse(view1.isHidden)

        view2.fadeOut(duration: 0.5) { _ in
            fadeOutExpectation.fulfill()
        }
        XCTAssertEqual(view2.alpha, 0)
        waitForExpectations(timeout: 0.5)
    }

    func testRotateByAngle() {
        let view1 = UIView()
        view1.rotate(byAngle: 1, ofType: .radians, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view1.transform, CGAffineTransform(rotationAngle: 1), accuracy: 0.00001)
        view1.rotate(byAngle: 1, ofType: .radians, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view1.transform, CGAffineTransform(rotationAngle: 2), accuracy: 0.00001)

        let view2 = UIView()
        view2.rotate(byAngle: 90, ofType: .degrees, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view2.transform, CGAffineTransform(rotationAngle: .pi / 2.0))

        let rotateExpectation = expectation(description: "view rotated")
        let view3 = UIView()
        view3.rotate(byAngle: 2, ofType: .radians, animated: true, duration: 0.5) { _ in
            rotateExpectation.fulfill()
        }
        XCTAssertEqual(view3.transform, CGAffineTransform(rotationAngle: 2))
        waitForExpectations(timeout: 0.5)
    }

    func testRotateToAngle() {
        let view1 = UIView()
        view1.rotate(toAngle: 1, ofType: .radians, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view1.transform, CGAffineTransform(rotationAngle: 1))
        view1.rotate(toAngle: 0, ofType: .radians, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view1.transform, CGAffineTransform(rotationAngle: 0), accuracy: 0.00001)

        let view2 = UIView()
        view2.rotate(toAngle: 90, ofType: .degrees, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view2.transform, CGAffineTransform(rotationAngle: .pi / 2.0))
        view2.rotate(toAngle: 30, ofType: .degrees, animated: false, duration: 0, completion: nil)
        XCTAssertEqual(view2.transform, CGAffineTransform(rotationAngle: .pi / 6.0), accuracy: 0.00001)

        let rotateExpectation = expectation(description: "view rotated")
        let view3 = UIView()
        view3.rotate(toAngle: 2, ofType: .radians, animated: true, duration: 0.5) { _ in
            rotateExpectation.fulfill()
        }
        XCTAssertEqual(view3.transform, CGAffineTransform(rotationAngle: 2))
        waitForExpectations(timeout: 0.5)
    }

    func testScale() {
        let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let view1 = UIView(frame: frame)
        let view2 = UIView(frame: frame)
        let view3 = UIView(frame: frame)
        let scale = CGPoint(x: 0.5, y: 2.0)

        view1.transform = view2.transform.scaledBy(x: scale.x, y: scale.y)

        view2.scale(by: scale)
        view3.scale(by: scale, animated: true, duration: 0)

        XCTAssertEqual(view1.transform, view2.transform)
        XCTAssertEqual(view1.transform, view3.transform)
    }

    #if os(tvOS)
    func testLoadFromNib() {
        let bundle = Bundle(for: UIViewExtensionsTests.self)
        XCTAssertNotNil(UIView.loadFromNib(named: "UIImageViewTvOS", bundle: bundle))
    }
    #else
    func testLoadFromNib() {
        let bundle = Bundle(for: UIViewExtensionsTests.self)
        XCTAssertNotNil(UIView.loadFromNib(named: "UIImageView", bundle: bundle))
        XCTAssertNotNil(UIView.loadFromNib(withClass: UIImageView.self, bundle: bundle))
    }
    #endif

    func testRemoveSubviews() {
        let view = UIView()
        view.addSubviews([UIView(), UIView()])
        view.removeSubviews()
        XCTAssertEqual(view.subviews.count, 0)
    }

    func testRemoveGestureRecognizers() {
        let view = UIView()
        XCTAssertNil(view.gestureRecognizers)
        view.removeGestureRecognizers()
        XCTAssertNil(view.gestureRecognizers)

        let tap = UIGestureRecognizer(target: nil, action: nil)
        view.addGestureRecognizer(tap)
        XCTAssertNotNil(view.gestureRecognizers)
        view.removeGestureRecognizers()
        XCTAssertEqual(view.gestureRecognizers!.count, 0)
    }

    func testAddGestureRecognizers() {
        let view = UIView()

        XCTAssertNil(view.gestureRecognizers)

        let tap = UITapGestureRecognizer(target: nil, action: nil)
        let pan = UIPanGestureRecognizer(target: nil, action: nil)
        let swipe = UISwipeGestureRecognizer(target: nil, action: nil)

        view.addGestureRecognizers([tap, pan, swipe])

        XCTAssertNotNil(view.gestureRecognizers)
        XCTAssertEqual(view.gestureRecognizers!.count, 3)
    }

    func testRemoveGestureRecognizersVariadic() {
        let view = UIView()

        XCTAssertNil(view.gestureRecognizers)

        let tap = UITapGestureRecognizer(target: nil, action: nil)
        let pan = UIPanGestureRecognizer(target: nil, action: nil)
        let swipe = UISwipeGestureRecognizer(target: nil, action: nil)

        view.addGestureRecognizers([tap, pan, swipe])

        XCTAssertNotNil(view.gestureRecognizers)
        XCTAssertEqual(view.gestureRecognizers!.count, 3)

        view.removeGestureRecognizers([tap, pan, swipe])

        XCTAssertNotNil(view.gestureRecognizers)
        XCTAssert(view.gestureRecognizers!.isEmpty)
    }

    // swiftlint:disable:next function_body_length
    func testAddGradient() {
        // topToBottom
        let view0 = UIView()
        XCTAssertNil(view0.layer.sublayers)
        view0.addGradient(
            colors: [.red, .orange, .green, .blue],
            locations: [0.0, 0.333, 0.667, 1.0],
            direction: .topToBottom)
        XCTAssertNotNil(view0.layer.sublayers)
        if let sublayers = view0.layer.sublayers as? [CAGradientLayer] {
            XCTAssertEqual(sublayers.count, 1)
            XCTAssertTrue(sublayers[0].startPoint.x.isEqual(to: 0.5))
            XCTAssertTrue(sublayers[0].startPoint.y.isEqual(to: 0.0))
            XCTAssertTrue(sublayers[0].endPoint.x.isEqual(to: 0.5))
            XCTAssertTrue(sublayers[0].endPoint.y.isEqual(to: 1.0))
            XCTAssertEqual(sublayers[0].colors?.count, 4)
            // swiftlint:disable force_cast
            XCTAssertEqual(sublayers[0].colors?[0] as! CGColor, UIColor.red.cgColor)
            XCTAssertEqual(sublayers[0].colors?[1] as! CGColor, UIColor.orange.cgColor)
            XCTAssertEqual(sublayers[0].colors?[2] as! CGColor, UIColor.green.cgColor)
            XCTAssertEqual(sublayers[0].colors?[3] as! CGColor, UIColor.blue.cgColor)
            // swiftlint:enable force_cast
            XCTAssertEqual(sublayers[0].locations?.count, 4)
            XCTAssertNotNil(sublayers[0].locations?[0].isEqual(to: 0.0))
            XCTAssertNotNil(sublayers[0].locations?[1].isEqual(to: 0.333))
            XCTAssertNotNil(sublayers[0].locations?[2].isEqual(to: 0.667))
            XCTAssertNotNil(sublayers[0].locations?[3].isEqual(to: 1.0))
        }

        // bottomToTop
        let view1 = UIView()
        XCTAssertNil(view1.layer.sublayers)
        view1.addGradient(
            colors: [.red, .orange, .green, .blue],
            locations: [0.0, 0.333, 0.667, 1.0],
            direction: .bottomToTop)
        XCTAssertNotNil(view1.layer.sublayers)
        if let sublayers = view1.layer.sublayers as? [CAGradientLayer] {
            XCTAssertEqual(sublayers.count, 1)
            XCTAssertTrue(sublayers[0].startPoint.x.isEqual(to: 0.5))
            XCTAssertTrue(sublayers[0].startPoint.y.isEqual(to: 1.0))
            XCTAssertTrue(sublayers[0].endPoint.x.isEqual(to: 0.5))
            XCTAssertTrue(sublayers[0].endPoint.y.isEqual(to: 0.0))
            XCTAssertEqual(sublayers[0].colors?.count, 4)
            // swiftlint:disable force_cast
            XCTAssertEqual(sublayers[0].colors?[0] as! CGColor, UIColor.red.cgColor)
            XCTAssertEqual(sublayers[0].colors?[1] as! CGColor, UIColor.orange.cgColor)
            XCTAssertEqual(sublayers[0].colors?[2] as! CGColor, UIColor.green.cgColor)
            XCTAssertEqual(sublayers[0].colors?[3] as! CGColor, UIColor.blue.cgColor)
            // swiftlint:enable force_cast
            XCTAssertEqual(sublayers[0].locations?.count, 4)
            XCTAssertNotNil(sublayers[0].locations?[0].isEqual(to: 0.0))
            XCTAssertNotNil(sublayers[0].locations?[1].isEqual(to: 0.333))
            XCTAssertNotNil(sublayers[0].locations?[2].isEqual(to: 0.667))
            XCTAssertNotNil(sublayers[0].locations?[3].isEqual(to: 1.0))
        }

        // leftToRight
        let view2 = UIView()
        XCTAssertNil(view2.layer.sublayers)
        view2.addGradient(
            colors: [.red, .orange, .green, .blue],
            locations: [0.0, 0.333, 0.667, 1.0],
            direction: .leftToRight)
        XCTAssertNotNil(view2.layer.sublayers)
        if let sublayers = view2.layer.sublayers as? [CAGradientLayer] {
            XCTAssertEqual(sublayers.count, 1)
            XCTAssertTrue(sublayers[0].startPoint.x.isEqual(to: 0.0))
            XCTAssertTrue(sublayers[0].startPoint.y.isEqual(to: 0.5))
            XCTAssertTrue(sublayers[0].endPoint.x.isEqual(to: 1.0))
            XCTAssertTrue(sublayers[0].endPoint.y.isEqual(to: 0.5))
            XCTAssertEqual(sublayers[0].colors?.count, 4)
            // swiftlint:disable force_cast
            XCTAssertEqual(sublayers[0].colors?[0] as! CGColor, UIColor.red.cgColor)
            XCTAssertEqual(sublayers[0].colors?[1] as! CGColor, UIColor.orange.cgColor)
            XCTAssertEqual(sublayers[0].colors?[2] as! CGColor, UIColor.green.cgColor)
            XCTAssertEqual(sublayers[0].colors?[3] as! CGColor, UIColor.blue.cgColor)
            // swiftlint:enable force_cast
            XCTAssertEqual(sublayers[0].locations?.count, 4)
            XCTAssertNotNil(sublayers[0].locations?[0].isEqual(to: 0.0))
            XCTAssertNotNil(sublayers[0].locations?[1].isEqual(to: 0.333))
            XCTAssertNotNil(sublayers[0].locations?[2].isEqual(to: 0.667))
            XCTAssertNotNil(sublayers[0].locations?[3].isEqual(to: 1.0))
        }

        // rightToLeft
        let view3 = UIView()
        XCTAssertNil(view3.layer.sublayers)
        view3.addGradient(
            colors: [.red, .orange, .green, .blue],
            locations: [0.0, 0.333, 0.667, 1.0],
            direction: .rightToLeft)
        XCTAssertNotNil(view3.layer.sublayers)
        if let sublayers = view3.layer.sublayers as? [CAGradientLayer] {
            XCTAssertEqual(sublayers.count, 1)
            XCTAssertTrue(sublayers[0].startPoint.x.isEqual(to: 1.0))
            XCTAssertTrue(sublayers[0].startPoint.y.isEqual(to: 0.5))
            XCTAssertTrue(sublayers[0].endPoint.x.isEqual(to: 0.0))
            XCTAssertTrue(sublayers[0].endPoint.y.isEqual(to: 0.5))
            XCTAssertEqual(sublayers[0].colors?.count, 4)
            // swiftlint:disable force_cast
            XCTAssertEqual(sublayers[0].colors?[0] as! CGColor, UIColor.red.cgColor)
            XCTAssertEqual(sublayers[0].colors?[1] as! CGColor, UIColor.orange.cgColor)
            XCTAssertEqual(sublayers[0].colors?[2] as! CGColor, UIColor.green.cgColor)
            XCTAssertEqual(sublayers[0].colors?[3] as! CGColor, UIColor.blue.cgColor)
            // swiftlint:enable force_cast
            XCTAssertEqual(sublayers[0].locations?.count, 4)
            XCTAssertNotNil(sublayers[0].locations?[0].isEqual(to: 0.0))
            XCTAssertNotNil(sublayers[0].locations?[1].isEqual(to: 0.333))
            XCTAssertNotNil(sublayers[0].locations?[2].isEqual(to: 0.667))
            XCTAssertNotNil(sublayers[0].locations?[3].isEqual(to: 1.0))
        }
    }

    func testAnchor() {
        let view = UIView()
        let subview = UIView()
        view.addSubview(subview)
        subview.anchor(top: nil, left: nil, bottom: nil, right: nil)
        XCTAssert(subview.constraints.isEmpty)

        subview.anchor(top: view.topAnchor)
        XCTAssertNotNil(subview.topAnchor)

        subview.anchor(left: view.leftAnchor)
        XCTAssertNotNil(subview.leftAnchor)

        subview.anchor(bottom: view.bottomAnchor)
        XCTAssertNotNil(subview.bottomAnchor)

        subview.anchor(right: view.rightAnchor)
        XCTAssertNotNil(subview.rightAnchor)

        subview.anchor(widthConstant: 10.0, heightConstant: 10.0)
        XCTAssertNotNil(subview.widthAnchor)
        XCTAssertNotNil(subview.heightAnchor)
    }

    func testAnchorCenterXToSuperview() {
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        view.anchorCenterXToSuperview()
        let subview = UIView()
        view.addSubview(subview)
        view.anchorCenterXToSuperview(constant: 10.0)
        XCTAssertNotNil(subview.centerXAnchor)
    }

    func testAnchorCenterYToSuperview() {
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        view.anchorCenterXToSuperview()
        let subview = UIView()
        view.addSubview(subview)
        view.anchorCenterYToSuperview(constant: 10.0)
        XCTAssertNotNil(subview.centerYAnchor)
    }

    func testAnchorCenterToSuperview() {
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        view.anchorCenterSuperview()
        let subview = UIView()
        view.addSubview(subview)
        view.anchorCenterSuperview()
        XCTAssertNotNil(subview.centerXAnchor)
        XCTAssertNotNil(subview.centerYAnchor)
    }

    func testAncestorViewWhere() {
        let tableView = UITableView(frame: .zero)
        let tableViewCell = UITableViewCell(frame: .zero)
        tableView.addSubview(tableViewCell)
        tableView.tag = 2
        let button = UIButton(frame: .zero)
        tableViewCell.addSubview(button)
        button.tag = 1
        let buttonSubview = UIView(frame: .zero)
        button.addSubview(buttonSubview)

        XCTAssertEqual(buttonSubview.ancestorView(where: { $0?.tag == 1 }), button)
        XCTAssertEqual(buttonSubview.ancestorView(where: { $0?.tag == 2 }), tableView)
        XCTAssertNil(buttonSubview.ancestorView(where: { $0?.tag == 3 }))
        XCTAssertEqual(button.ancestorView(where: { $0 is UITableViewCell }), tableViewCell)
        XCTAssertEqual(button.ancestorView(where: { $0?.superview == nil }), tableView)
    }

    func testAncestorViewWithClass() {
        let tableView = UITableView(frame: .zero)
        let tableViewCell = UITableViewCell(frame: .zero)
        tableView.addSubview(tableViewCell)
        let button = UIButton(frame: .zero)
        tableViewCell.addSubview(button)
        let buttonSubview = UIView(frame: .zero)
        button.addSubview(buttonSubview)

        XCTAssertEqual(button.ancestorView(withClass: UITableViewCell.self), tableViewCell)
        XCTAssertEqual(button.ancestorView(withClass: UITableView.self), tableView)
        XCTAssertNil(button.ancestorView(withClass: UIButton.self))
        XCTAssertNil(tableView.ancestorView(withClass: UIButton.self))
        XCTAssertEqual(buttonSubview.ancestorView(withClass: UITableViewCell.self), tableViewCell)
        XCTAssertEqual(buttonSubview.ancestorView(withClass: UITableView.self), tableView)
    }

    func testSubviewsOfType() {
        // Test view with subviews with no subviews
        XCTAssertEqual(UIView().subviews(ofType: UILabel.self), [])

        // Test view with subviews that have subviews
        let parentView = UIView()

        let childView = UIView()
        let childViewSubViews = [UILabel(), UIButton(), UITextView(), UILabel(), UIImageView()]
        childView.addSubviews(childViewSubViews)

        let childView2 = UIView()
        let childView2SubViews = [UISegmentedControl(), UILabel(), UITextView(), UIImageView()]
        childView2.addSubviews(childView2SubViews)

        parentView.addSubviews([childView, childView2])

        let expected = [childViewSubViews[0], childViewSubViews[3], childView2SubViews[1]]
        XCTAssertEqual(parentView.subviews(ofType: UILabel.self), expected)
        XCTAssertEqual(parentView.subviews(ofType: UITableViewCell.self), [])
    }

    func testFindConstraint() {
        let view = UIView()
        let container = UIView()
        container.addSubview(view)
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 1),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3)
        ])
        XCTAssertNotNil(view.findConstraint(attribute: .width, for: view))
        XCTAssertNil(view.findConstraint(attribute: .height, for: view))

        // pathological case
        XCTAssertNil(view.findConstraint(attribute: .height, for: UIView()))
    }

    func testConstraintProperties() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)

        // setup constraints, some in container and some in view
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 1),
            view.heightAnchor.constraint(equalToConstant: 2),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 4),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 6)
        ])

        // find them
        XCTAssertEqual(view.widthConstraint!.constant, 1)
        XCTAssertEqual(view.heightConstraint!.constant, 2)
        XCTAssertEqual(view.leadingConstraint!.constant, 3)
        XCTAssertEqual(view.trailingConstraint!.constant, 4)
        XCTAssertEqual(view.topConstraint!.constant, 5)
        XCTAssertEqual(view.bottomConstraint!.constant, 6)

        // simple empty case test
        XCTAssertNil(container.widthConstraint)
    }

    func testRemoveBlur() {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        XCTAssert(view.subviews.first is UIVisualEffectView)
        view.removeBlur()
        XCTAssertFalse(view.subviews.first is UIVisualEffectView)
    }
}

#endif
