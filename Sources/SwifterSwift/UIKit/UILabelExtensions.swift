//
//  UILabelExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/23/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit


// MARK: - Properties
public extension UILabel {
    
    /// SwifterSwift: Required height for a label
    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}

// MARK: - Methods
public extension UILabel {
    
    /// SwifterSwift: Initialize a UILabel with text
    convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    /// SwifterSwift: Initialize a UILabel with a text and font style.
    ///
    /// - Parameters:
    ///   - text: the label's text.
    ///   - style: the text style of the label, used to determine which font should be used.
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init()
        font = UIFont.preferredFont(forTextStyle: style)
        self.text = text
    }
    
    /// SwifterSwift:  Calculate and return the size that best fits an attributed string, given the specified constraints on size and number of lines.
    ///
    ///   let yourAttributedString = ...
    ///   let yourConstraintSize = ...
    ///   let size = UILabel.size(thatFitsAttributedString: yourAttributedString, withConstraints: yourConstraintSize)
    ///
    /// - Parameters:
    ///   - attributedString The attributed string.
    ///   - size The maximum dimensions used to calculate size.
    /// - Returns: The size that fits the attributed string within the specified constraints.
    
    static func size(thatFitsAttributedString attributedString: NSAttributedString,
                     withConstraints size: CGSize) -> CGSize {
        
        guard attributedString.length > 0 else { return CGSize.zero}
        
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
              
        let calculatedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,
                                                                          CFRange(location: 0,length: attributedString.length),
                                                                          nil,
                                                                          size,
                                                                          nil)
        
        return calculatedSize
        
        
        
    }
}

#endif
