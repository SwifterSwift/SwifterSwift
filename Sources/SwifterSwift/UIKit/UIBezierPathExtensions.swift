//
//  UIBezierPathExtensions.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 04.04.19.
//  Copyright © 2019 SwifterSwift
//

#if canImport(UIKit)
import UIKit

// MARK: - Initializers
public extension UIBezierPath {

    /// SwifterSwift: Initializes a UIBezierPath with a line from a CGPoint to another CGPoint.
    convenience init(from: CGPoint, to otherPoint: CGPoint) {
        self.init()
        move(to: from)
        addLine(to: otherPoint)
    }

    /// SwifterSwift: Initializes a UIBezierPath connecting the given CGPoints with straight lines.
    convenience init(points: [CGPoint]) {
        self.init()
        if !points.isEmpty {
            move(to: points[0])
            for point in points[1...] {
                addLine(to: point)
            }
        }
    }

    /// SwifterSwift: Initializes a polygonal UIBezierPath with the given CGPoints. At least 3 points must be given.
    convenience init?(polygonWithPoints points: [CGPoint]) {
        guard points.count > 2 else {return nil}
        self.init()
        move(to: points[0])
        for point in points[1...] {
            addLine(to: point)
        }
        close()
    }

    /// SwifterSwift: Initializes a UIBezierPath with an oval path of given size.
    convenience init(ovalOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(ovalIn: CGRect(origin: origin, size: size))
    }

    /// SwifterSwift: Initializes a UIBezierPath with a  rectangular path of given size.
    convenience init(rectOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(rect: CGRect(origin: origin, size: size))
    }

}

#endif
