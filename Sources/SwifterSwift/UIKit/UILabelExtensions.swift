// UILabelExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UILabel {
    /// SwifterSwift: Initialize a UILabel with text.
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

    /// SwifterSwift: Required height for a label.
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
    
    
    /// SwifterSwift: Add attribute to UILabel
    /// - Parameters:
    ///   - range: The range of the string to apply attributes
    func attribute(textIn range: Range<String.Index>?, _ attributes: [NSAttributedString.Key : Any]) {
        guard let range = range else {
            NSLog("Could not get the text range")
            return
        }
        guard let text = text else {
            NSLog("Could not get the text property")
            return
        }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(attributes, range: NSRange(range, in: text))
        attributedText = attributedString
    }
    
    /// SwifterSwift: Add attribute to UILabel
    /// - Parameters:
    ///   - ranges: The ranges of the strings to apply attributes
    func attribute(textIn ranges: Array<Range<String.Index>?>, _ attributes: [NSAttributedString.Key : Any]) {
        guard let text = text else {
            NSLog("Could not get the text property")
            return
        }
        let finalRanges = ranges.compactMap { $0 }
        let attributedString = NSMutableAttributedString(string: text)
        for range in finalRanges {        
            attributedString.addAttributes(attributes, range: NSRange(range, in: text))
        }
        attributedText = attributedString
    }
}

#endif
