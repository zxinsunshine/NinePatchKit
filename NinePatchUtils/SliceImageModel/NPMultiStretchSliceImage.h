//
//  NPMultiStretchSliceImage.h
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NinePatchCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface NPMultiStretchSliceImage : ImageClass

@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) CGFloat horizontalStretchRatio;
@property (nonatomic, assign) CGFloat verticalStretchRatio;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// Slice part of image
/// @param image raw image
/// @param rect slice area
- (instancetype)initWithImage:(ImageClass *)image subRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
