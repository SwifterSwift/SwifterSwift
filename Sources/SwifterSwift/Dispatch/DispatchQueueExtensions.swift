//
//  DispatchQueueExtensions.swift
//  SwifterSwift
//
//  Created by Quentin Jin on 2018/10/13.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Dispatch)
import Dispatch

// MARK: - Properties
public extension DispatchQueue {

    /// SwifterSwift: A Boolean value indicating whether the current dispatch queue is the main queue.
    static var isMainQueue: Bool {
        enum Static {
            static var key: DispatchSpecificKey<Void> = {
                let key = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: key, value: ())
                return key
            }()
        }
        return DispatchQueue.getSpecific(key: Static.key) != nil
    }

}

// MARK: - Methods
public extension DispatchQueue {

    /// SwifterSwift: Returns a Boolean value indicating whether the current dispatch queue is the specified queue.
    ///
    /// - Parameter queue: The queue to compare against.
    /// - Returns: `true` if the current queue is the specified queue, otherwise `false`.
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }
    
    /// SwifterSwift: Runs passed closure on main thread.
    ///
    /// - Parameter block: The closure to run on main thread
    static func asyncOnMain(code block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
    
    /// SwifterSwift: Runs passed closure on background thread.
    ///
    /// - Parameter block: The closure to run on background thread
    static func asyncOnBg(code block: @escaping () -> Void) {
        DispatchQueue.global().async {
            block()
        }
    }
    
    /// SwifterSwift: Runs passed closure asynchronous after certain time interval
    ///
    /// - Parameter time: The time inverval after which the closure will run.
    /// - Parameter block: The closure to run after certain time interval.
    static func asyncAfter(time: TimeInterval, code block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            block()
        }
    }

}

#endif
