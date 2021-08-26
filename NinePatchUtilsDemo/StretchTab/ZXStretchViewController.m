//
//  ZXStretchViewController.m
//
//
//  Created by Theo on 2021/7/19.
//

#import "ZXStretchViewController.h"
#import <Masonry/Masonry.h>
#import "NinePatchUtils.h"
#import "NinePathImageView.h"

@interface ZXStretchViewController ()<UITextViewDelegate>

@property (nonatomic, strong) NinePathImageView * backView;
@property (nonatomic, strong) UIButton * switchBtn;
@property (nonatomic, strong) UISlider * slideView1;
@property (nonatomic, strong) UISlider * slideView2;
@property (nonatomic, strong) UITextView * label1;
@property (nonatomic, strong) UITextView * label2;

@end

@implementation ZXStretchViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.backView.contentView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.slideView1];
    [self.view addSubview:self.slideView2];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.switchBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@(self.slideView1.value));
        make.height.equalTo(@(self.slideView2.value));
    }];
    [self.slideView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.left.equalTo(self.view);
        make.width.equalTo(@(310));
        make.height.equalTo(@(50));
    }];
    [self.slideView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slideView1.mas_bottom).offset(50);
        make.left.equalTo(self.view);
        make.width.equalTo(@(310));
        make.height.equalTo(@(50));
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.slideView1);
        make.left.equalTo(self.slideView1.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(self.slideView1.mas_height);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.slideView2);
        make.left.equalTo(self.slideView2.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(self.slideView2.mas_height);
    }];
    [self updateLabel];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    self.slideView1.value = 100;
    self.slideView2.value = 100;
    [self refreshUI];
}

- (void)clickSwitchBtn {
    
    static NSInteger count = 1;
    NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%zd", count] ofType:@"png"];
    self.backView.showImage = [NinePatchUtils imageWithContentsOfFile:path];

    ++count;
    if (count > 5) {
        count = 1;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.label1 resignFirstResponder];
    [self.label2 resignFirstResponder];
  
}

- (void)slider1Change:(UISlider *)sender {
    
    [self refreshUI];
}

- (void)slider2Change:(UISlider *)sender {
    
    [self refreshUI];
}

- (void)refreshUI {
    [self updateView];
    [self updateLabel];
}

- (void)updateLabel {
    self.label1.text = [NSString stringWithFormat:@"%.2lf", self.slideView1.value];
    self.label2.text = [NSString stringWithFormat:@"%.2lf", self.slideView2.value];
}

- (void)updateView {
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.slideView1.value));
    }];
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.slideView2.value));
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView isEqual:self.label1]) {
        self.slideView1.value = [self.label1.text floatValue];
    } else if ([textView isEqual:self.label2]) {
        self.slideView2.value = [self.label2.text floatValue];
    }
    [self refreshUI];
}

#pragma mark - Getter
- (NinePathImageView *)backView {
    if (!_backView) {
        _backView = ({
            NinePathImageView * view = [[NinePathImageView alloc] init];
            view;
        });
    }
    return _backView;
}

- (UISlider *)slideView1 {
    if (!_slideView1) {
        _slideView1 = [[UISlider alloc] init];
        _slideView1.value = 300;
        _slideView1.minimumValue = 10;
        _slideView1.maximumValue = self.view.bounds.size.width;
        [_slideView1 addTarget:self action:@selector(slider1Change:) forControlEvents:UIControlEventValueChanged];
    }
    return _slideView1;
}

- (UISlider *)slideView2 {
    if (!_slideView2) {
        _slideView2 = [[UISlider alloc] init];
        _slideView2.value = 300;
        _slideView2.minimumValue = 10;
        _slideView2.maximumValue = self.view.bounds.size.width;
        [_slideView2 addTarget:self action:@selector(slider2Change:) forControlEvents:UIControlEventValueChanged];
    }
    return _slideView2;
}

- (UITextView *)label1 {
    if (!_label1) {
        _label1 = ({
            UITextView * label = [[UITextView alloc] init];
            label.delegate = self;
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor clearColor];
            label;
        });
    }
    return _label1;
}

- (UITextView *)label2 {
    if (!_label2) {
        _label2 = ({
            UITextView * label = [[UITextView alloc] init];
            label.delegate = self;
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor clearColor];
            label;
        });
    }
    return _label2;
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

@end
