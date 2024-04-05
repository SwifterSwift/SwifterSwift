//
//  TextExtensions.swift
//  SwifterSwift
//
//  Created by SwifterSwift on 06/04/2024.
//  Copyright © 2024 SwifterSwift
//

import SwiftUI

extension Text {
    /// SwifterSwift: Auto scale down by use minimumScaleFactor.
    func autoSize(minimumScaleFactor: CGFloat = 0.01, lineLimit: Int = 1) -> some View {
        self.lineLimit(lineLimit)
            .minimumScaleFactor(minimumScaleFactor)
    }
}
