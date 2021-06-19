//
//  ViewExtensions.swift
//  SwifterSwift
//
//  Created by Jevon Mao on 6/18/21.
//  Copyright © 2021 SwifterSwift. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
    /**
     Modifier to erase a SwiftUI `View` type into `AnyView`
     
     An `AnyView` allows changing the type of view used in a given view hierarchy. Whenever the type of view used with an AnyView changes, the old hierarchy is destroyed and a new hierarchy is created for the new type.
     */
    @usableFromInline func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
