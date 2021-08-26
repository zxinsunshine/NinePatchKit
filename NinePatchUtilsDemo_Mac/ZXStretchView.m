//
//  ZXStretchView.m
//_Mac
//
//  Created by sunny on 2021/8/6.
//

#import "ZXStretchView.h"

@interface ZXStretchView ()

@property (nonatomic, strong) NSSlider *slideView1;
@property (nonatomic, strong) NSSlider *slideView2;
@property (nonatomic, strong) NSButton *switchButton;
@property (nonatomic, strong) NinePathImageView * backView;
@property (nonatomic, assign) NSInteger imageNumber;

@end

@implementation ZXStretchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.stringValue = @"Stretch";
        
        [self addSubview:self.slideView1];
        [self addSubview:self.slideView2];
        [self addSubview:self.switchButton];
        [self addSubview:self.backView];
        
        [self.slideView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
            make.centerX.equalTo(self);
            make.width.equalTo(@(310));
            make.height.equalTo(@(20));
        }];
        [self.slideView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.slideView1.mas_bottom).offset(20);
            make.centerX.equalTo(self);
            make.width.equalTo(@(310));
            make.height.equalTo(@(20));
        }];
        [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.slideView2.mas_bottom).offset(20.0);
            make.width.equalTo(@(80.0));
            make.height.equalTo(@(50.0));
        }];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.switchButton.mas_bottom).offset(20.0);
            make.width.equalTo(@(self.slideView1.doubleValue));
            make.height.equalTo(@(self.slideView2.doubleValue));
        }];
    }
    
    return self;
}

#pragma mark - User Action
- (void)slider1DidMove:(id)sender
{
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.slideView1.doubleValue));
    }];
}

- (void)slider2DidMove:(id)sender
{
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.slideView2.doubleValue));
    }];
}

- (void)switchButtonClicked:(id)sender
{
    ++self.imageNumber;
    if (self.imageNumber > 5) {
        self.imageNumber = 1;
    }
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%zd", self.imageNumber] ofType:@"png"];
    self.backView.showImage = [NinePatchUtils imageWithContentsOfFile:path];
}

#pragma mark - Property
-(NSSlider *)slideView1
{
    if (!_slideView1)
    {
        _slideView1 = [NSSlider sliderWithTarget:self action:@selector(slider1DidMove:)];
        _slideView1.minValue = 50;
        _slideView1.maxValue = 300;
        _slideView1.doubleValue = 100;
    }
    
    return _slideView1;
}

-(NSSlider *)slideView2
{
    if (!_slideView2)
    {
        _slideView2 = [NSSlider sliderWithTarget:self action:@selector(slider2DidMove:)];
        _slideView2.minValue = 50;
        _slideView2.maxValue = 300;
        _slideView2.doubleValue = 100;
    }
    
    return _slideView2;
}

-(NSButton *)switchButton
{
    if (!_switchButton)
    {
        _switchButton = [NSButton buttonWithTitle:NSLocalizedString(@"switch", nil) target:self action:@selector(switchButtonClicked:)];
    }
    
    return _switchButton;
}

- (NinePathImageView *)backView
{
    if (!_backView)
    {
        _backView = ({
            NinePathImageView * view = [[NinePathImageView alloc] init];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
            self.imageNumber = 6;
            view.showImage = [NinePatchUtils imageWithContentsOfFile:path];
            view.contentView.layer.backgroundColor = [NSColor redColor].CGColor;
            view;
        });
        
    }
    return _backView;
}

@end
