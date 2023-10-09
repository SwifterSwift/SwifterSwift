// NotificationCenterExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NotificationCenter {
    /// SwifterSwift: Adds a one-time entry to the notification center's dispatch table that includes a notification
    /// queue and a block to add to the queue, and an optional notification name and sender.
    /// - Parameters:
    ///   - name: The name of the notification for which to register the observer; that is, only notifications with this
    /// name are used to add the block to the operation queue.
    ///
    ///     If you pass `nil`, the notification center doesn’t use a notification’s name to decide whether to add the
    /// block to the operation queue.
    ///   - obj: The object whose notifications the observer wants to receive; that is, only notifications sent by this
    /// sender are delivered to the observer.
    ///
    ///     If you pass `nil`, the notification center doesn’t use a notification’s sender to decide whether to deliver
    /// it to the observer.
    ///   - queue: The operation queue to which block should be added.
    ///
    ///     If you pass `nil`, the block is run synchronously on the posting thread.
    ///   - block: The block to be executed when the notification is received.
    ///
    ///     The block is copied by the notification center and (the copy) held until the observer registration is
    /// removed.
    ///
    ///     The block takes one argument:
    ///   - notification: The notification.
    func observeOnce(forName name: NSNotification.Name?,
                     object obj: Any? = nil,
                     queue: OperationQueue? = nil,
                     using block: @escaping (_ notification: Notification) -> Void) {
        var handler: NSObjectProtocol!
        let removeObserver = { [unowned self] in
            self.removeObserver(handler!)
        }
        handler = addObserver(forName: name, object: obj, queue: queue) {
            removeObserver()
            block($0)
        }
    }
}

#endif
