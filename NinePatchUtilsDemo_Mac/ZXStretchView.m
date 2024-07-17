//
//  ZXStretchView.m
//_Mac
//
//  Created by sunny on 2021/8/6.
//

#import "ZXStretchView.h"

@interface ZXStretchView ()

@property (nonatomic, strong) NSSwitch * openBtn;
@property (nonatomic, strong) NSTextField * openLabel;
@property (nonatomic, strong) NSSlider *slideView1;
@property (nonatomic, strong) NSTextField * label1;
@property (nonatomic, strong) NSTextField * contentLabel;
@property (nonatomic, strong) NSButton *switchButton;
@property (nonatomic, strong) NinePatchImageView * backView;
@property (nonatomic, assign) NSInteger imageNumber;

@end

@implementation ZXStretchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.stringValue = @"Stretch";
        
        [self addSubview:self.openBtn];
        [self addSubview:self.openLabel];
        [self addSubview:self.slideView1];
        [self addSubview:self.label1];
        [self addSubview:self.backView];
        [self.backView.contentView addSubview:self.contentLabel];
        [self addSubview:self.switchButton];
        
        [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
            make.left.equalTo(self).offset(20);
        }];
        [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.openBtn.mas_right).offset(0);
            make.centerY.equalTo(self.openBtn);
        }];
        [self.slideView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.openBtn.mas_bottom).offset(30);
            make.left.equalTo(self).offset(20);
            make.width.equalTo(@(290));
            make.height.equalTo(@(20));
        }];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.slideView1);
            make.left.equalTo(self.slideView1.mas_right).offset(20);
        }];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.slideView1.mas_bottom).offset(20.0);
            make.width.lessThanOrEqualTo(self).multipliedBy(0.8);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.backView.contentView);
        }];
        [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-20);
            make.centerX.equalTo(self);
        }];
        
    }
    
    return self;
}

#pragma mark - User Action
- (void)slider1DidMove:(NSSlider *)sender
{
    int value = round(sender.doubleValue);
    sender.doubleValue = value;
    self.label1.stringValue = [NSString stringWithFormat:@"%d个字", value];
    [self updateContent];
}

- (void)switchButtonClicked:(id)sender
{
    ++self.imageNumber;
    if (self.imageNumber > 4) {
        self.imageNumber = 1;
    }
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%zd", self.imageNumber] ofType:@"png"];
    self.backView.showImage = [NinePatchUtils imageWithContentsOfFile:path];
}

- (void)clickOpen:(NSSwitch *)btn {
    if (btn.state == NSControlStateValueOn) {
        self.backView.contentView.layer.backgroundColor = [NSColor colorWithRed:1 green:0 blue:0 alpha:.1].CGColor;
    } else {
        self.backView.contentView.layer.backgroundColor = nil;
    }
}

- (void)updateContent {
    NSMutableString * mStr = [[NSMutableString alloc] initWithString:@""];
    for (int i = 0; i < self.slideView1.doubleValue; ++i) {
        [mStr appendString:@"哈"];
    }
    self.contentLabel.stringValue = mStr;
}

#pragma mark - Property

- (NSSwitch *)openBtn {
    if (!_openBtn) {
        _openBtn = ({
            NSSwitch * btn = [[NSSwitch alloc] init];
            btn.state = NSControlStateValueOff;
            [btn setAction:@selector(clickOpen:)];
            [btn setTarget:self];
            btn;
        });
    }
    return _openBtn;
}

- (NSTextField *)openLabel {
    if (!_openLabel) {
        _openLabel = ({
            NSTextField * label = [[NSTextField alloc] init];
            [label setEditable:NO];
            [label setBordered:NO];
            label.stringValue = @"是否标记内容区域";
            label.backgroundColor = [NSColor clearColor];
            label.alignment = NSTextAlignmentCenter;
            label.textColor = [NSColor blackColor];
            label.alignment = NSTextAlignmentCenter;
            label.font = [NSFont systemFontOfSize:15];
            label;
        });
    }
    return _openLabel;
}

-(NSSlider *)slideView1
{
    if (!_slideView1)
    {
        _slideView1 = [NSSlider sliderWithTarget:self action:@selector(slider1DidMove:)];
        _slideView1.minValue = 0;
        _slideView1.maxValue = 300;
        _slideView1.doubleValue = 0;
    }
    
    return _slideView1;
}

- (NSTextField *)label1 {
    if (!_label1) {
        _label1 = ({
            NSTextField * label = [[NSTextField alloc] init];
            [label setEditable:NO];
            [label setBordered:NO];
            label.backgroundColor = [NSColor clearColor];
            label.alignment = NSTextAlignmentCenter;
            label.stringValue = @"0个字";
            label.textColor = [NSColor blackColor];
            label.alignment = NSTextAlignmentCenter;
            label.font = [NSFont systemFontOfSize:15];
            label;
        });
    }
    return _label1;
}

- (NSTextField *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = ({
            NSTextField * label = [[NSTextField alloc] init];
            [label setEditable:NO];
            [label setBordered:NO];
            label.backgroundColor = [NSColor clearColor];
            label.textColor = [NSColor blackColor];
            label.font = [NSFont systemFontOfSize:15];
            label;
        });
    }
    return _contentLabel;
}


-(NSButton *)switchButton
{
    if (!_switchButton)
    {
        _switchButton = [NSButton buttonWithTitle:NSLocalizedString(@"switch", nil) target:self action:@selector(switchButtonClicked:)];
    }
    return _switchButton;
}

- (NinePatchImageView *)backView
{
    if (!_backView)
    {
        _backView = ({
            NinePatchImageView * view = [[NinePatchImageView alloc] init];
            view;
        });
        
    }
    return _backView;
}

@end
