//
//  UITableViewExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UITableView {
    
    // cool
    // FIXME:
     public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    // cool
    // FIXME:
     public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    //FIXME:
     public func indexPathForLastRow(in section: Int) -> IndexPath? {
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    //FIXME:
    public var totalRows: Int {
        var section = 0
        var rowCount = 0
        while section < self.numberOfSections {
            rowCount += self.numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    //FIXME:
    var lastSection: Int {
        guard numberOfSections > 1 else {
            return 0
        }
        return numberOfSections - 1
    }
    
    //FIXME:
    public var indexPathForLastRow: IndexPath? {
        guard totalRows > 0 else {
            return nil
        }
        return IndexPath(row: totalRows - 1, section: lastSection)
    }
    
    //FIXME:
    public func removeTableHeaderView() {
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    //FIXME:
    public func removeTableFooterView() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
}
