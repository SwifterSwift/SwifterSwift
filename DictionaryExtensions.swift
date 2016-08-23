//
//  DictionaryExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    // FIXME:
    public func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    // FIXME:
    public func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            return jsonData
        } catch {
            return nil
        }
    }
}
