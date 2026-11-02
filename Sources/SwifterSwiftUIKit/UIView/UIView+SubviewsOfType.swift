// UIView+SubviewsOfType.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Returns every descendant of the view that is of the given type.
    ///
    /// The type can be a class, such as `UILabel.self`, or a protocol, such as `(any UITextInput).self`, which finds
    /// every descendant that conforms to it. Instances of subclasses match, and so do views whose class adopts the
    /// protocol. A type that no view can be, such as `Int.self`, gives an empty array.
    ///
    /// The whole hierarchy below the view is searched depth-first, and the matches are returned in that order, each
    /// one before its own descendants. The search keeps going inside a match, so a label nested in another matching
    /// view is found too. The view itself isn't included.
    ///
    /// The result includes the subviews UIKit creates inside its own views, such as the title label of a `UIButton`
    /// once it has a title.
    ///
    /// ```swift
    /// // form contains a header label, an email field, a password field and a notes text view.
    /// form.subviews(ofType: UITextField.self)  // [emailField, passwordField]
    /// form.subviews(ofType: (any UITextInput).self)  // [emailField, passwordField, notesView]
    /// form.subviews(ofType: UITableView.self)  // []
    /// ```
    ///
    /// - Parameter type: The class or protocol of the views to find.
    /// - Returns: The descendants of type `T`, in depth-first order.
    /// - Complexity: O(*n*), where *n* is the number of views in the hierarchy.
    func subviews<T>(ofType type: T.Type) -> [T] {
        var matches: [T] = []
        for subview in subviews {
            if let match = subview as? T {
                matches.append(match)
            }
            matches.append(contentsOf: subview.subviews(ofType: type))
        }
        return matches
    }
}
#endif
