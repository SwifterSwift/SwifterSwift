//
//  UIControlExtensions.swift
//  SwiftDemo
//
//  Created by zeng on 2018/12/28.
//  Copyright © 2018 Ryze Zeng. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

/// SwifterSwift: the key of runtime, add Properties
private var closure_key: Void?

/// SwifterSwift: self Target
public class ControlClosureTarget {
    
    var _events: UIControl.Event
    var _closure: ((Any) -> Void)
    
    public init(closure: @escaping ((Any) -> Void), for evens: UIControl.Event) {
        _closure = closure
        _events = evens
    }
    
    @objc func invoke(sender: Any) {
        _closure(sender)
    }
}

// MARK: - Properties
public extension UIControl {
    
    /// SwifterSwift: all ControlClosureTarget  of UIControl.
    var allControlClosureTargets: [ControlClosureTarget] {
        get {
            var targets = objc_getAssociatedObject(self, &closure_key) as? [ControlClosureTarget]
            if targets == nil {
                
                targets = [ControlClosureTarget]()
            }
            return targets!
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, &closure_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: - Methods
public extension UIControl {
    /// SwifterSwift: remove all ControlClosureTarget
    public func removeAllTargets() {
        for object in self.allTargets.enumerated() {
            self.removeTarget(object, action: nil, for: .allEvents)
        }
        self.allControlClosureTargets.removeAll()
    }
    
    /// SwifterSwift: set target/action for particular event.
    ///
    /// remove old target/action , add new target/action
    ///
    /// - Parameters:
    ///   - target: target
    ///   - action: the action cannot be NULL.
    ///   - controlEvents: UIControl.Event
    public func setTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        guard let target = target, !controlEvents.isEmpty  else {return}
        let targets = allTargets
        for currentTarget in targets {
            guard let actions = self.actions(forTarget: currentTarget, forControlEvent: controlEvents)else {return}
            for currentAction in actions {
                self.removeTarget(currentTarget, action: NSSelectorFromString(currentAction), for: controlEvents)
            }
        }
        self.addTarget(target, action: action, for: controlEvents)
    }
    
    /// SwifterSwift: add a closure of target/action
    ///
    /// - Parameters:
    ///   - controlEvents: UIControl.Event
    ///   - closure: do something
    public func addclosure(for controlEvents: UIControl.Event, with closure: @escaping ((Any) -> Void)) {
        let target = ControlClosureTarget.init(closure: closure, for: controlEvents)
        self.addTarget(target, action: #selector(target.invoke(sender:)), for: controlEvents)
        self.allControlClosureTargets.append(target)
    }
    
    /// SwifterSwift: set a closure of target/action
    ///
    /// remove old closure, add new closure
    ///
    /// - Parameters:
    ///   - controlEvents: UIControl.Event
    ///   - closure: new closure
    public func setClosure(for controlEvents: UIControl.Event, with closure: @escaping ((Any) -> Void)) {
        self.removeAllClosures(for: controlEvents)
        self.addclosure(for: controlEvents, with: closure)
    }
    
    /// SwifterSwift: remove all closure of target/action
    ///
    /// - Parameter controlEvents: UIControl.Event
    public func removeAllClosures(for controlEvents: UIControl.Event) {
        var removes = [ControlClosureTarget]()
        if controlEvents.isEmpty {return}
        for target in self.allControlClosureTargets where !target._events.isEmpty {
            let newEvent = target._events.rawValue & (~controlEvents.rawValue)
            if newEvent != 0 {
                self.removeTarget(target, action: #selector(target.invoke(sender:)), for: target._events)
                target._events = UIControl.Event(rawValue: newEvent)
                self.addTarget(target, action: #selector(target.invoke(sender:)), for: target._events)
            } else {
                self.removeTarget(target, action: #selector(target.invoke(sender:)), for: target._events)
                removes.append(target)
            }
        }
        
        for remove in removes.enumerated() {
            
            if let index = self.allControlClosureTargets.index(where: { element in
                return element === remove.element
            }) {
                self.allControlClosureTargets.remove(at: index)
            }
        }
    }
}
