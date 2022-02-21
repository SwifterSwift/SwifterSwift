// UIControlExtensions.swift - Copyright 2022 SwifterSwift

#if canImport(UIKit)
import UIKit

// MARK: - Methods

public extension UIControl {
    
    /// SwifterSwift: Perform action on specified event.
    ///
    /// - Parameters:
    ///   - event: Event to perform action for.
    ///   - action: Action to perform.
    func on(_ event: UIControl.Event, perform action: @escaping () -> Void) {
        // https://stackoverflow.com/a/41438789/9014720
        @objc final class ClosureSleeve: NSObject {
            private let closure: () -> Void
            init (_ closure: @escaping () -> Void) {
                self.closure = closure
            }
            @objc func invoke () {
                closure()
            }
        }
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: event)
        objc_setAssociatedObject(self, UUID().uuidString, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
#endif
