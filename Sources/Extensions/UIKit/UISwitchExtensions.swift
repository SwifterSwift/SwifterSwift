//
//  UISwitchExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 08/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit)
import UIKit

#if os(iOS)
// MARK: - Methods
public extension UISwitch {

	/// SwifterSwift: Toggle a UISwitch
	///
	/// - Parameter animated: set true to animate the change (default is true)
	public func toggle(animated: Bool = true) {
		setOn(!isOn, animated: animated)
	}

}
#endif

#endif
