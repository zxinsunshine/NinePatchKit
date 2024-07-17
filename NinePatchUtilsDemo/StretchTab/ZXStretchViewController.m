//
//  ZXStretchViewController.m
//
//
//  Created by Theo on 2021/7/19.
//

#import "ZXStretchViewController.h"
#import <Masonry/Masonry.h>
#import <NinePatchKit/NinePatchKit.h>

@interface ZXStretchViewController ()

@property (nonatomic, strong) NinePatchImageView * backView;
@property (nonatomic, strong) UIButton * switchBtn;
@property (nonatomic, strong) UISwitch * openBtn;
@property (nonatomic, strong) UILabel * openLabel;
@property (nonatomic, strong) UISlider * slideView1;
@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * contentLabel;

@end

@implementation ZXStretchViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backView];
    [self.backView.contentView addSubview:self.contentLabel];
    [self.view addSubview:self.openBtn];
    [self.view addSubview:self.openLabel];
    [self.view addSubview:self.slideView1];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.switchBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.lessThanOrEqualTo(self.view).multipliedBy(0.8);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backView.contentView);
    }];
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(150);
    }];
    [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.openBtn);
        make.left.equalTo(self.openBtn.mas_right).offset(10);
    }];
    [self.slideView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@(310));
        make.height.equalTo(@(50));
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.slideView1);
        make.left.equalTo(self.slideView1.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(self.slideView1.mas_height);
    }];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
}

- (void)clickSwitchBtn {
    
    static NSInteger count = 1;
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%zd", count] ofType:@"png"];
    self.backView.showImage = [NinePatchUtils imageWithContentsOfFile:path];

    ++count;
    if (count > 4) {
        count = 1;
    }
}

- (void)clickOpen:(UISwitch *)btn {
    if (btn.isOn) {
        self.backView.contentView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
    } else {
        self.backView.contentView.backgroundColor = nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.label1 resignFirstResponder];
}

- (void)slider1Change:(UISlider *)sender {
    int value = round(sender.value);
    sender.value = value;
    self.label1.text = [NSString stringWithFormat:@"%d个字", value];
    [self updateContent];
}


- (void)updateContent {
    NSMutableString * mStr = [[NSMutableString alloc] initWithString:@""];
    for (int i = 0; i < self.slideView1.value; ++i) {
        [mStr appendString:@"哈"];
    }
    self.contentLabel.text = mStr;
}

#pragma mark - Getter
- (NinePatchImageView *)backView {
    if (!_backView) {
        _backView = ({
            NinePatchImageView * view = [[NinePatchImageView alloc] init];
            view;
        });
    }
    return _backView;
}

- (UISlider *)slideView1 {
    if (!_slideView1) {
        _slideView1 = [[UISlider alloc] init];
        _slideView1.value = 0;
        _slideView1.minimumValue = 0;
        _slideView1.maximumValue = 300;
        [_slideView1 addTarget:self action:@selector(slider1Change:) forControlEvents:UIControlEventValueChanged];
    }
    return _slideView1;
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = ({
            UILabel * label = [[UILabel alloc] init];
            label.text = @"0个字";
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor clearColor];
            label;
        });
    }
    return _label1;
}

- (UIButton *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = ({
            UIButton * btn = [[UIButton alloc] init];
            [btn setTitle:@"Switch" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(clickSwitchBtn) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _switchBtn;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = ({
            UILabel * label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            label;
        });
    }
    return _contentLabel;
}

- (UILabel *)openLabel {
    if (!_openLabel) {
        _openLabel = ({
            UILabel * label = [[UILabel alloc] init];
            label.text = @"是否标记内容区域";
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            label;
        });
    }
    return _openLabel;
}

- (UISwitch *)openBtn {
    if (!_openBtn) {
        _openBtn = ({
            UISwitch * btn = [[UISwitch alloc] init];
            btn.on = NO;
            [btn addTarget:self action:@selector(clickOpen:) forControlEvents:UIControlEventValueChanged];
            btn;
        });
    }
    return _openBtn;
}

@end
