//
//  ZXBaseView.m
//_Mac
//
//  Created by sunny on 2021/8/6.
//

#import "ZXBaseView.h"

@interface ZXBaseView ()

@end

@implementation ZXBaseView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.centerX.equalTo(self);
        }];
    }
    
    return self;
}

#pragma mark - Property
-(NSTextField *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[NSTextField alloc] init];
        _titleLabel.backgroundColor = [NSColor clearColor];
        _titleLabel.font = [NSFont systemFontOfSize:30.0];
        _titleLabel.alignment = NSTextAlignmentCenter;
        _titleLabel.editable = NO;
        _titleLabel.bordered = NO;
    }
    
    return _titleLabel;
}

@end
