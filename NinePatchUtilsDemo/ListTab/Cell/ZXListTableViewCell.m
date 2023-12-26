//
//  ZXListTableViewCell.m
//
//
//  Created by Theo on 2021/7/19.
//

#import "ZXListTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation ZXListTableViewCellModel

@end

static const CGFloat kAvatarWH = 50;
static const CGFloat space = 10;
static const CGFloat kLabelFontSize = 13;

@interface ZXListTableViewCell()

@property (nonatomic, strong) UIView * avatarView;
@property (nonatomic, strong) NinePatchImageView * showView;
@property (nonatomic, strong) UILabel * label;

@end

@implementation ZXListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setModel:(ZXListTableViewCellModel *)model {
    _model = model;
    
    self.showView.showImage = model.backImage;
    self.showView.reverseX = !model.isSender;
    self.label.text = model.text;
    
    if (!model.isSender) {
        [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kAvatarWH, kAvatarWH));
            make.left.equalTo(self.contentView).offset(space);
            make.top.equalTo(self.contentView).offset(space);
            make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-space);
        }];
        [self.showView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(space);
            make.centerY.equalTo(self.contentView);
            make.top.greaterThanOrEqualTo(self.contentView.mas_top).offset(space);
            make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-space);
        }];
        self.avatarView.backgroundColor = [ColorClass blueColor];
    } else {
        [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kAvatarWH, kAvatarWH));
            make.right.equalTo(self.contentView).offset(-space);
            make.top.equalTo(self.contentView).offset(space);
            make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-space);
        }];
        [self.showView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.avatarView.mas_left).offset(-space);
            make.centerY.equalTo(self.contentView);
            make.top.greaterThanOrEqualTo(self.contentView.mas_top).offset(space);
            make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-space);
        }];
        self.avatarView.backgroundColor = [ColorClass redColor];
    }
}

+ (ZXListTableViewCellModel *)modelForText:(NSString *)text sender:(BOOL)isSender withMaxWidth:(CGFloat)maxWidth backImage:(ImageClass *)image {
    
    ZXListTableViewCellModel * model = [ZXListTableViewCellModel new];
    model.text = text;
    model.isSender = isSender;
    model.backImage = image;
    
    return model;
}

#pragma mark - Private Methods
- (void)setupUI {
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.showView];
    [self.showView.contentView addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.showView.contentView);
    }];
}

#pragma mark - Getter

- (UIView *)avatarView {
    if (!_avatarView) {
        _avatarView = ({
            UIView * view = [[UIView alloc] init];
            view.layer.cornerRadius = kAvatarWH / 2;
            view.clipsToBounds = YES;
            
            view;
        });
    }
    return _avatarView;
}

- (NinePatchImageView *)showView {
    if (!_showView) {
        _showView = [[NinePatchImageView alloc] init];
    }
    return _showView;
}

- (UILabel *)label {
    if (!_label) {
        _label = ({
            UILabel * label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:kLabelFontSize];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.preferredMaxLayoutWidth = 200;
            label;
        });
    }
    return _label;
}

@end
