//
//  SwifterSwift.h
//  SwifterSwift
//
//  Created by Omar Albeik on 07/10/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//


#import "TargetConditionals.h"
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

//! Project version number for SwifterSwift.
FOUNDATION_EXPORT double SwifterSwiftVersionNumber;

//! Project version string for SwifterSwift.
FOUNDATION_EXPORT const unsigned char SwifterSwiftVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SwifterSwift/PublicHeader.h>
