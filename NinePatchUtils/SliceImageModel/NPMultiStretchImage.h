//
//  NPMultiStretchImage.h
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NinePatchCompatibility.h"
#import "NPMultiStretchSliceImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface NPMultiStretchImage : ImageClass

@property (nonatomic, strong, readonly) NSArray<NSArray<NPMultiStretchSliceImage *> *> * sliceImages;
@property (nonatomic, assign, readonly) CGFloat maxSolidHeight;
@property (nonatomic, assign, readonly) CGFloat maxSolidWidth;
@property (nonatomic, assign, readonly) EdgeStruct padding;
@property (nonatomic, assign, readonly) BOOL isNinePatch;

/// Generate stretchImage
/// @param data image data
/// @param fromScale the image scale you design for
/// @param toScale the image object you want to generate
+ (instancetype)generateImageWithData:(NSData *)data fromScale:(CGFloat)fromScale toScale:(CGFloat)toScale;

@end

NS_ASSUME_NONNULL_END
