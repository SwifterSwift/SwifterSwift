// UIImageExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(UIKit)
import UIKit

// MARK: - Properties

public extension UIImage {
    /// SwifterSwift: Size in bytes of UIImage.
    var bytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }

    /// SwifterSwift: Size in kilo bytes of UIImage.
    var kilobytesSize: Int {
        return (jpegData(compressionQuality: 1)?.count ?? 0) / 1024
    }

    /// SwifterSwift: UIImage with .alwaysOriginal rendering mode.
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    /// SwifterSwift: UIImage with .alwaysTemplate rendering mode.
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }

    #if canImport(CoreImage)
    /// SwifterSwift: Average color for this image.
    func averageColor() -> UIColor? {
        // https://stackoverflow.com/questions/26330924
        guard let ciImage = ciImage ?? CIImage(image: self) else { return nil }

        // CIAreaAverage returns a single-pixel image that contains the average color for a given region of an image.
        let parameters = [kCIInputImageKey: ciImage, kCIInputExtentKey: CIVector(cgRect: ciImage.extent)]
        guard let outputImage = CIFilter(name: "CIAreaAverage", parameters: parameters)?.outputImage else {
            return nil
        }

        // After getting the single-pixel image from the filter extract pixel's RGBA8 data
        var bitmap = [UInt8](repeating: 0, count: 4)
        let workingColorSpace: Any = cgImage?.colorSpace ?? NSNull()
        let context = CIContext(options: [.workingColorSpace: workingColorSpace])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        // Convert pixel data to UIColor
        return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                       green: CGFloat(bitmap[1]) / 255.0,
                       blue: CGFloat(bitmap[2]) / 255.0,
                       alpha: CGFloat(bitmap[3]) / 255.0)
    }
    #endif
}

// MARK: - Methods

public extension UIImage {
    /// SwifterSwift: Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value
    /// 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression
    /// (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// SwifterSwift: Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value
    /// 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression
    /// (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }

    /// SwifterSwift: UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= size.width, rect.size.height <= size.height else { return self }
        let scaledRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        guard let image = cgImage?.cropping(to: scaledRect) else { return self }
        return UIImage(cgImage: image, scale: scale, orientation: imageOrientation)
    }

    /// SwifterSwift: UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        let size = CGSize(width: newWidth, height: toHeight)
        let rect = CGRect(origin: .zero, size: size)

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, opaque, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: rect)
        }
        #endif
    }

    /// SwifterSwift: UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        let size = CGSize(width: toWidth, height: newHeight)
        let rect = CGRect(origin: .zero, size: size)

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, opaque, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: rect)
        }
        #endif
    }

    /// SwifterSwift: Creates a copy of the receiver rotated by the given angle.
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: Measurement(value: 180, unit: .degrees))
    ///
    /// - Parameter angle: The angle measurement by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)

        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        let actions = { (contextRef: CGContext) in
            contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
            contextRef.rotate(by: radians)

            self.draw(in: CGRect(origin: CGPoint(x: -self.size.width / 2,
                                                 y: -self.size.height / 2),
                                 size: self.size))
        }

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(roundedDestRect.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        actions(contextRef)
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: roundedDestRect.size, format: format).image {
            actions($0.cgContext)
        }
        #endif
    }

    /// SwifterSwift: Creates a copy of the receiver rotated by the given angle (in radians).
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: .pi)
    ///
    /// - Parameter radians: The angle, in radians, by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        let actions = { (contextRef: CGContext) in
            contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
            contextRef.rotate(by: radians)

            self.draw(in: CGRect(origin: CGPoint(x: -self.size.width / 2,
                                                 y: -self.size.height / 2),
                                 size: self.size))
        }

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(roundedDestRect.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        actions(contextRef)
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: roundedDestRect.size, format: format).image {
            actions($0.cgContext)
        }
        #endif
    }

    /// SwifterSwift: UIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    func filled(withColor color: UIColor) -> UIImage {
        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()!
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        #endif
    }

    /// SwifterSwift: UIImage tinted with color.
    ///
    /// - Parameters:
    ///   - color: color to tint image with.
    ///   - blendMode: how to blend the tint.
    ///   - alpha: alpha value used to draw.
    /// - Returns: UIImage tinted with given color.
    func tint(_ color: UIColor, blendMode: CGBlendMode, alpha: CGFloat = 1.0) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: size)

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()!
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            color.setFill()
            context.fill(drawRect)
            draw(in: drawRect, blendMode: blendMode, alpha: alpha)
        }
        #endif
    }

    /// SwifterSwift: UImage with background color.
    ///
    /// - Parameters:
    ///   - backgroundColor: Color to use as background color.
    /// - Returns: UIImage with a background color that is visible where alpha < 1.
    func withBackgroundColor(_ backgroundColor: UIColor) -> UIImage {
        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }

        backgroundColor.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        draw(at: .zero)

        return UIGraphicsGetImageFromCurrentImageContext()!
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            backgroundColor.setFill()
            context.fill(context.format.bounds)
            draw(at: .zero)
        }
        #endif
    }

    /// SwifterSwift: UIImage with rounded corners.
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified.
    /// - Returns: UIImage with all corners rounded.
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0, radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        let actions = {
            let rect = CGRect(origin: .zero, size: self.size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            self.draw(in: rect)
        }

        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        actions()
        return UIGraphicsGetImageFromCurrentImageContext()
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            actions()
        }
        #endif
    }

    /// SwifterSwift: Base 64 encoded PNG data of the image.
    ///
    /// - Returns: Base 64 encoded PNG data of the image as a String.
    func pngBase64String() -> String? {
        return pngData()?.base64EncodedString()
    }

    /// SwifterSwift: Base 64 encoded JPEG data of the image.
    ///
    /// - Parameter: compressionQuality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0.
    /// The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least
    /// compression (or best quality).
    /// - Returns: Base 64 encoded JPEG data of the image as a String.
    func jpegBase64String(compressionQuality: CGFloat) -> String? {
        return jpegData(compressionQuality: compressionQuality)?.base64EncodedString()
    }

    /// SwifterSwift: UIImage with color uses .alwaysOriginal rendering mode.
    ///
    /// - Parameters:
    ///   - color: Color of image.
    /// - Returns: UIImage with color.
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func withAlwaysOriginalTintColor(_ color: UIColor) -> UIImage {
        return withTintColor(color, renderingMode: .alwaysOriginal)
    }
}

// MARK: - Initializers

public extension UIImage {
    /// SwifterSwift: Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        #if os(watchOS)
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer { UIGraphicsEndImageContext() }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }

        self.init(cgImage: aCgImage)
        #else
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        guard let image = UIGraphicsImageRenderer(size: size, format: format).image(actions: { context in
            color.setFill()
            context.fill(context.format.bounds)
        }).cgImage else {
            self.init()
            return
        }
        self.init(cgImage: image)
        #endif
    }

    /// SwifterSwift: Create a new image from a base 64 string.
    ///
    /// - Parameters:
    ///   - base64String: a base-64 `String`, representing the image
    ///   - scale: The scale factor to assume when interpreting the image data created from the base-64 string. Applying
    /// a scale factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a
    /// different scale factor changes the size of the image as reported by the `size` property.
    convenience init?(base64String: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }

    /// SwifterSwift: Create a new image from a URL
    ///
    /// - Important:
    ///   Use this method to convert data:// URLs to UIImage objects.
    ///   Don't use this synchronous initializer to request network-based URLs. For network-based URLs, this method can
    /// block the current thread for tens of seconds on a slow network, resulting in a poor user experience, and in iOS,
    /// may cause your app to be terminated.
    ///   Instead, for non-file URLs, consider using this in an asynchronous way, using
    /// `dataTask(with:completionHandler:)` method of the URLSession class or a library such as `AlamofireImage`,
    /// `Kingfisher`, `SDWebImage`, or others to perform asynchronous network image loading.
    /// - Parameters:
    ///   - url: a `URL`, representing the image location
    ///   - scale: The scale factor to assume when interpreting the image data created from the URL. Applying a scale
    /// factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a
    /// different scale factor changes the size of the image as reported by the `size` property.
    convenience init?(url: URL, scale: CGFloat = 1.0) throws {
        let data = try Data(contentsOf: url)
        self.init(data: data, scale: scale)
    }
}

#endif
