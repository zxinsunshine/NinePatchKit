//
//  NinePathImageView.h
//  Test
//
//  Created by Theo on 2021/7/16.
//

#import "NinePatchCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface NinePathImageView : ViewClass

@property (nonatomic, strong) ImageClass * showImage;
@property (nonatomic, assign, readonly) EdgeStruct padding;
@property (nonatomic, strong, readonly) ViewClass * contentView;
@property (nonatomic, assign) BOOL reverseX;
@property (nonatomic, assign) BOOL reverseY;

@end

NS_ASSUME_NONNULL_END
