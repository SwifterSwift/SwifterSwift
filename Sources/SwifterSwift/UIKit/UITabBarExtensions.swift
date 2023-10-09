// UITabBarExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UITabBar {
    /// SwifterSwift: Set tabBar colors.
    ///
    /// - Parameters:
    ///   - background: background color.
    ///   - selectedBackground: background color for selected tab.
    ///   - item: icon tint color for items.
    ///   - selectedItem: icon tint color for item.
    func setColors(
        background: UIColor? = nil,
        selectedBackground: UIColor? = nil,
        item: UIColor? = nil,
        selectedItem: UIColor? = nil) {
        // background
        barTintColor = background ?? barTintColor

        // selectedItem
        tintColor = selectedItem ?? tintColor
        // shadowImage = UIImage()
        backgroundImage = UIImage()
        #if !os(visionOS)
        isTranslucent = false
        #endif

        // selectedBackgroundColor
        guard let barItems = items else {
            return
        }

        if let selectedbg = selectedBackground {
            let rect = CGSize(width: frame.width / CGFloat(barItems.count), height: frame.height)
            selectionIndicatorImage = { (color: UIColor, size: CGSize) -> UIImage in
                return UIGraphicsImageRenderer(size: size).image { context in
                    color.setFill()
                    context.fill(context.format.bounds)
                }
            }(selectedbg, rect)
        }

        if let itemColor = item {
            for barItem in barItems as [UITabBarItem] {
                // item
                guard let image = barItem.image else { continue }

                barItem.image = { (image: UIImage, color: UIColor) -> UIImage in
                    guard let mask = image.cgImage else { return image }

                    let format = UIGraphicsImageRendererFormat()
                    format.scale = image.scale
                    return UIGraphicsImageRenderer(size: image.size, format: format).image {
                        let context = $0.cgContext

                        color.setFill()

                        context.translateBy(x: 0, y: image.size.height)
                        context.scaleBy(x: 1.0, y: -1.0)
                        context.setBlendMode(CGBlendMode.normal)

                        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                        context.clip(to: rect, mask: mask)
                        context.fill(rect)
                    }
                }(image, itemColor).withRenderingMode(.alwaysOriginal)

                barItem.setTitleTextAttributes([.foregroundColor: itemColor], for: .normal)
                if let selected = selectedItem {
                    barItem.setTitleTextAttributes([.foregroundColor: selected], for: .selected)
                }
            }
        }
    }
}

#endif
