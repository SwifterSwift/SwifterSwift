// UIImage+AverageColor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && canImport(CoreImage)
import CoreGraphics
import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

public extension UIImage {
    /// SwifterSwift: Returns the average color of all the image's pixels.
    ///
    /// The average is computed by Core Image's `CIAreaAverage` filter in the context's working color space. The default
    /// context works in linear light, which is how colors mix physically: an image that's half red and half green
    /// averages to a bright yellow, about `(0.735, 0.735, 0)` in sRGB. To average the stored sRGB values instead, which
    /// gives `(0.5, 0.5, 0)`, pass a context whose `.workingColorSpace` option is sRGB.
    ///
    /// Transparent pixels don't pull the color toward black: the color is the average of the visible pixels, weighted
    /// by their opacity, and its alpha is the average opacity. A fully transparent image returns a clear color. The
    /// returned color is in the extended sRGB color space, so colors outside sRGB are kept.
    ///
    /// Creating a `CIContext` is expensive, so pass the same context when you call this method many times.
    ///
    /// ```swift
    /// let context = CIContext()
    /// let photo = UIImage(named: "Photo")!
    /// photo.averageColor(using: context)  // The photo's overall color.
    /// UIImage().averageColor(using: context)  // nil
    ///
    /// let sRGB = CGColorSpace(name: CGColorSpace.sRGB)
    /// let gammaContext = CIContext(options: [.workingColorSpace: sRGB as Any])
    /// photo.averageColor(using: gammaContext)  // The average of the stored sRGB values.
    /// ```
    ///
    /// - Parameter context: The Core Image context to render with. The default is a new context.
    /// - Returns: The average color, or `nil` if the image has no pixels or Core Image can't read it.
    /// - Complexity: O(*n*), where *n* is the number of pixels in the image.
    func averageColor(using context: CIContext = CIContext()) -> UIColor? {
        guard let input = ciImage ?? CIImage(image: self), !input.extent.isEmpty, !input.extent.isInfinite else {
            return nil
        }
        let filter = CIFilter.areaAverage()
        filter.inputImage = input
        filter.extent = input.extent
        guard let output = filter.outputImage, let colorSpace = CGColorSpace(name: CGColorSpace.extendedSRGB) else {
            return nil
        }

        // The filter's result is a single premultiplied pixel.
        var pixel: [Float] = [0, 0, 0, 0]
        context.render(
            output,
            toBitmap: &pixel,
            rowBytes: 4 * MemoryLayout<Float>.size,
            bounds: CGRect(origin: output.extent.origin, size: CGSize(width: 1, height: 1)),
            format: .RGBAf,
            colorSpace: colorSpace
        )
        let alpha = CGFloat(pixel[3])
        guard alpha > 0 else { return UIColor(red: 0, green: 0, blue: 0, alpha: 0) }
        return UIColor(
            red: CGFloat(pixel[0]) / alpha,
            green: CGFloat(pixel[1]) / alpha,
            blue: CGFloat(pixel[2]) / alpha,
            alpha: min(alpha, 1)
        )
    }
}
#endif
