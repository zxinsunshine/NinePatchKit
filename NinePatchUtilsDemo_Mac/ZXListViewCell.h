//
//  ZXListViewCell.h
//  NinePatchUtilsDemo_Mac
//
//  Created by sunny on 2021/8/18.
//

#import <Cocoa/Cocoa.h>
#import "Masonry.h"
#import "NinePatchUtils.h"
#import "NinePatchImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXListViewCellModel : NSObject

@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) BOOL isSender;
@property (nonatomic, assign) CGSize bubbleSize;
@property (nonatomic, assign) CGSize totalSize;
@property (nonatomic, strong) ImageClass * backImage;

@end


@interface ZXListViewCell : NSTableCellView

@property (nonatomic, strong) ZXListViewCellModel * model;

+ (ZXListViewCellModel *)modelForText:(NSString *)text sender:(BOOL)isSender withMaxWidth:(CGFloat)maxWidth backImage:(ImageClass *)image;
- (void)updateContents;

@end

NS_ASSUME_NONNULL_END
