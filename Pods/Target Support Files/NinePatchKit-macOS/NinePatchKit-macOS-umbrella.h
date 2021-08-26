#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NinePatchCompatibility.h"
#import "NinePatchKit.h"
#import "NinePatchUtils.h"
#import "NinePathImageView.h"

FOUNDATION_EXPORT double NinePatchKitVersionNumber;
FOUNDATION_EXPORT const unsigned char NinePatchKitVersionString[];

