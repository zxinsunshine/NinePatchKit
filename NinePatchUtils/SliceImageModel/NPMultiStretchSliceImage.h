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
@property (nonatomic, strong) ImageClass * totalImage;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// 截取部分图像
/// @param image 原图
/// @param rect 截取区域
- (instancetype)initWithImage:(ImageClass *)image subRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
