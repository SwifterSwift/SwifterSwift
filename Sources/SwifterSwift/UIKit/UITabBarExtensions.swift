// UITabBarExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UITabBar {
    // swiftlint:disable cyclomatic_complexity function_body_length

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
                if #available(tvOS 10.0, *) {
                    return UIGraphicsImageRenderer(size: size).image { context in
                        color.setFill()
                        context.fill(context.format.bounds)
                    }
                }

                UIGraphicsBeginImageContextWithOptions(size, false, 1)
                defer { UIGraphicsEndImageContext() }
                color.setFill()
                UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
                guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
                guard let aCgImage = image.cgImage else { return UIImage() }
                return UIImage(cgImage: aCgImage)
            }(selectedbg, rect)
        }

        if let itemColor = item {
            for barItem in barItems as [UITabBarItem] {
                // item
                guard let image = barItem.image else { continue }

                barItem.image = { (image: UIImage, color: UIColor) -> UIImage in
                    guard let mask = image.cgImage else { return image }

                    let actions = { (context: CGContext) in
                        color.setFill()

                        context.translateBy(x: 0, y: image.size.height)
                        context.scaleBy(x: 1.0, y: -1.0)
                        context.setBlendMode(CGBlendMode.normal)

                        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                        context.clip(to: rect, mask: mask)
                        context.fill(rect)
                    }

                    if #available(tvOS 10.0, *) {
                        let format = UIGraphicsImageRendererFormat()
                        format.scale = image.scale
                        return UIGraphicsImageRenderer(size: image.size, format: format).image {
                            actions($0.cgContext)
                        }
                    }

                    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
                    defer { UIGraphicsEndImageContext() }
                    guard let context = UIGraphicsGetCurrentContext() else { return image }

                    actions(context)

                    return UIGraphicsGetImageFromCurrentImageContext() ?? image
                }(image, itemColor).withRenderingMode(.alwaysOriginal)

                barItem.setTitleTextAttributes([.foregroundColor: itemColor], for: .normal)
                if let selected = selectedItem {
                    barItem.setTitleTextAttributes([.foregroundColor: selected], for: .selected)
                }
            }
        }
    }

    // swiftlint:enable cyclomatic_complexity function_body_length
}

#endif
