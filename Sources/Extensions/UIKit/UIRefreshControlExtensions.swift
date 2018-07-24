//
//  UIRefreshControlExtensions.swift
//  SwifterSwift
//
//  Created by ratul sharker on 7/24/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Methods
public extension UIRefreshControl {

    /// SwifterSwift: Programatically begin refresh control inside of UITableView.
    ///
    /// - Parameter tableView: UITableView instance, inside which the refresh control is contained.
    public func beginRefreshProgramatically(in tableView: UITableView) {
        //https://stackoverflow.com/questions/14718850/uirefreshcontrol-beginrefreshing-not-working-when-uitableviewcontroller-is-ins/14719658#14719658
        beginRefreshing()
        let offsetPoint = CGPoint(x: 0, y: -frame.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }

}

#endif
#endif
