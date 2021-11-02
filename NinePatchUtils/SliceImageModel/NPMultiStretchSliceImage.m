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
#if TARGET_ON_iOS
    CGImageRef cgImage = [image CGImage];
    if (!cgImage) {
        return nil;
    }
#else
    CGRect fullRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGImageRef cgImage = [image CGImageForProposedRect:&fullRect context:NULL hints:NULL];
    
#endif
    CGImageRef subCGImage = CGImageCreateWithImageInRect(cgImage, rect);
    if (!subCGImage) {
        return nil;
    }
#if TARGET_ON_iOS
    self = [super initWithCGImage:subCGImage];
#else
    self = [super initWithCGImage:subCGImage size:rect.size];
#endif
    CGImageRelease(subCGImage);
    
    if (self) {
        self.rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    }
    return self;
}

@end
