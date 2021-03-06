//
//  NinePatchCompatibility.h
//
//
//  Created by Theo on 2021/8/4.
//

#import <TargetConditionals.h>

#if TARGET_OS_OSX

#import <Cocoa/Cocoa.h>
#define ImageClass NSImage
#define ViewClass NSView
#define EdgeStruct NSEdgeInsets
#define EdgeStructZero NSEdgeInsetsZero
#define EdgeStructMake NSEdgeInsetsMake
#define UnsignedInt UInt
#define ScreenScale [[NSScreen mainScreen] backingScaleFactor]
#define ColorClass NSColor
#define MaxScreenScale 2.0

#else

#import <UIKit/UIKit.h>
#define ImageClass UIImage
#define ViewClass UIView
#define EdgeStruct UIEdgeInsets
#define EdgeStructZero UIEdgeInsetsZero
#define EdgeStructMake UIEdgeInsetsMake
#define UnsignedInt uInt
#define ScreenScale [[UIScreen mainScreen] scale]
#define ColorClass UIColor
#define MaxScreenScale 3.0


#endif
