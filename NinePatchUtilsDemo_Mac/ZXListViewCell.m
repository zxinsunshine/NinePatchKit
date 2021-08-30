//
//  ZXListViewCell.m
//  NinePatchUtilsDemo_Mac
//
//  Created by sunny on 2021/8/18.
//

#import "ZXListViewCell.h"

@implementation ZXListViewCellModel

@end

static const CGFloat kAvatarWH = 50;
static const CGFloat space = 10;
static const CGFloat kLabelFontSize = 13;

@interface ZXListViewCell ()

@property (nonatomic, strong) NSView * avatarView;
@property (nonatomic, strong) NinePatchImageView *showView;
@property (nonatomic, strong) NSTextField *label;

@end

@implementation ZXListViewCell

+ (ZXListViewCellModel *)modelForText:(NSString *)text sender:(BOOL)isSender withMaxWidth:(CGFloat)maxWidth backImage:(ImageClass *)image
{
    EdgeStruct padding = [NinePatchUtils paddingForImage:image];
    CGSize bubbleSize = [self sizeForBubbleWithText:text maxWidth:maxWidth innerPadding:padding];
    CGSize cellSize = CGSizeZero;
    cellSize.width += space + kAvatarWH + space + bubbleSize.width;
    cellSize.height = space + MAX(kAvatarWH, bubbleSize.height) + space;
    
    ZXListViewCellModel *model = [ZXListViewCellModel new];
    model.text = text;
    model.bubbleSize = bubbleSize;
    model.totalSize = cellSize;
    model.isSender = isSender;
    model.backImage = image;
    
    return model;
}

+ (CGSize)sizeForBubbleWithText:(NSString *)text maxWidth:(CGFloat)maxWidth innerPadding:(EdgeStruct)padding
{
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    maxSize.width -= (ceil(padding.left) + ceil(padding.right));
    maxSize.width = MAX(0, maxSize.width);
    CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{
        NSFontAttributeName: [NSFont systemFontOfSize:kLabelFontSize]
    } context:nil];
    
    CGSize size = rect.size;
    // fix issue for NSTextField pading
    size.width = ceil(size.width) + 5;
    size.height = ceil(size.height);
    
    size.width += ceil(ceil(padding.left) + ceil(padding.right));
    size.height += ceil(ceil(padding.top) + ceil(padding.bottom));
    return size;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.avatarView];
        [self addSubview:self.showView];
        [self.showView.contentView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.showView.contentView);
        }];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateContents
{
    self.showView.showImage = self.model.backImage;
    self.label.stringValue = self.model.text;
    
    if (!self.model.isSender)
    {
        [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kAvatarWH, kAvatarWH));
            make.left.equalTo(self).offset(space);
            make.top.equalTo(self).offset(space);
        }];
        [self.showView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.model.bubbleSize);
            make.left.equalTo(self.avatarView.mas_right).offset(space);
            make.centerY.equalTo(self);
        }];
        self.avatarView.layer.backgroundColor = [ColorClass blueColor].CGColor;
    }
    else
    {
        [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kAvatarWH, kAvatarWH));
            make.right.equalTo(self).offset(-space);
            make.top.equalTo(self).offset(space);
        }];
        [self.showView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.model.bubbleSize);
            make.right.equalTo(self.avatarView.mas_left).offset(-space);
            make.centerY.equalTo(self);
        }];
        self.avatarView.layer.backgroundColor = [ColorClass redColor].CGColor;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.showView.reverseX = !self.model.isSender;
    });
}

#pragma mark - Property
-(NSView *)avatarView
{
    if (!_avatarView)
    {
        _avatarView = [[NSView alloc] init];
        _avatarView.wantsLayer = YES;
        _avatarView.layer.backgroundColor = [NSColor darkGrayColor].CGColor;
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = kAvatarWH*0.5;
    }
    
    return _avatarView;
}

-(NinePatchImageView *)showView
{
    if (!_showView)
    {
        _showView= [[NinePatchImageView alloc] init];
    }
    
    return _showView;
}

-(NSTextField *)label
{
    if (!_label)
    {
        _label = [[NSTextField alloc] init];
        _label.font = [NSFont systemFontOfSize:kLabelFontSize];
        _label.alignment = NSTextAlignmentLeft;
        _label.editable = NO;
        _label.bordered = NO;
        _label.backgroundColor = [ColorClass clearColor];
    }
    
    return _label;
}

@end
