// UIViewController+PresentPopover.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import CoreGraphics
import UIKit

public extension UIViewController {
    /// SwifterSwift: Presents a view controller as a popover that points at a location in this view controller's view.
    ///
    /// The popover's `modalPresentationStyle` is set to `.popover`, and it's anchored to `sourcePoint`, in the
    /// coordinates of this view controller's `view`. When `size` is `nil`, the popover uses the content's own
    /// `preferredContentSize`.
    ///
    /// In a compact width, such as on iPhone, UIKit adapts popovers to sheets. To keep a popover, pass a delegate that
    /// returns `.none` from `adaptivePresentationStyle(for:traitCollection:)`. As with any presentation, UIKit doesn't
    /// present it when this view controller isn't in a window or is already presenting another view controller.
    ///
    /// Popovers aren't available on tvOS, so this method isn't either.
    ///
    /// ```swift
    /// let picker = ColorPickerViewController()
    /// presentPopover(picker, sourcePoint: button.center, size: CGSize(width: 300, height: 200))
    /// picker.modalPresentationStyle  // .popover
    /// ```
    ///
    /// - Parameters:
    ///   - popoverContent: The view controller to show in the popover.
    ///   - sourcePoint: The point the popover's arrow points at, in this view controller's view.
    ///   - size: The size of the popover's content, or `nil` to keep the content's `preferredContentSize`.
    ///   - delegate: The delegate of the popover presentation controller, or `nil`.
    ///   - animated: Whether to animate the presentation. The default is `true`.
    ///   - completion: The closure to call after the presentation finishes, or `nil`.
    func presentPopover(
        _ popoverContent: UIViewController,
        sourcePoint: CGPoint,
        size: CGSize? = nil,
        delegate: (any UIPopoverPresentationControllerDelegate)? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        popoverContent.modalPresentationStyle = .popover
        if let size {
            popoverContent.preferredContentSize = size
        }
        if let popoverPresentationController = popoverContent.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationController.delegate = delegate
        }
        present(popoverContent, animated: animated, completion: completion)
    }
}
#endif
