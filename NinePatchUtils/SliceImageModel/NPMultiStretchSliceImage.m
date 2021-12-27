//
//  NPMultiStretchSliceImage.m
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NPMultiStretchSliceImage.h"

@implementation NPMultiStretchSliceImage

- (instancetype)initWithImage:(ImageClass *)image subRect:(CGRect)rect
{
#if TARGET_OS_OSX
    CGRect fullRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGImageRef cgImage = [image CGImageForProposedRect:&fullRect context:NULL hints:NULL];
#else
    CGImageRef cgImage = [image CGImage];
    if (!cgImage) {
        return nil;
    }
#endif
    CGImageRef subCGImage = CGImageCreateWithImageInRect(cgImage, rect);
    if (!subCGImage) {
        return nil;
    }
#if TARGET_OS_OSX
    self = [super initWithCGImage:subCGImage size:rect.size];
#else
    self = [super initWithCGImage:subCGImage];
#endif
    CGImageRelease(subCGImage);
    
    if (self) {
        self.rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    }
    return self;
}

@end
