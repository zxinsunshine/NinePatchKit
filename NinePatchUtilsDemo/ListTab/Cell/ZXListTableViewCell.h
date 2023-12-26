//
//  ZXListTableViewCell.h
//
//
//  Created by Theo on 2021/7/19.
//

#import <UIKit/UIKit.h>
#import <NinePatchKit/NinePatchKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ZXListTableViewCellModel : NSObject

@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) BOOL isSender;
@property (nonatomic, strong) ImageClass * backImage;

@end

@interface ZXListTableViewCell : UITableViewCell

@property (nonatomic, strong) ZXListTableViewCellModel * model;

+ (ZXListTableViewCellModel *)modelForText:(NSString *)text sender:(BOOL)isSender withMaxWidth:(CGFloat)maxWidth backImage:(ImageClass *)image;

@end

NS_ASSUME_NONNULL_END
