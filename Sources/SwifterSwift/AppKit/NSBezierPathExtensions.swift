// NSBezierPathExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

extension NSBezierPath {
    // Extending NSBezierPath with the missing cgPath property
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< elementCount {
            let type = element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            case .cubicCurveTo:
                continue
            case .quadraticCurveTo:
                continue
            @unknown default:
                continue
            }
        }
        return path
    }
    
}

#endif
