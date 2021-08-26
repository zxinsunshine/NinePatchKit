//
//  ViewController.m
//_Mac
//
//  Created by sunny on 2021/8/5.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ZXStretchView.h"
#import "ZXListView.h"

@interface ViewController ()

@property (nonatomic, strong) NSView *seperatorLine1;
@property (nonatomic, strong) ZXStretchView *stretchView;
@property (nonatomic, strong) ZXListView *listView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.stretchView];
    [self.view addSubview:self.seperatorLine1];
    [self.view addSubview:self.listView];
    
    [self.stretchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.equalTo(@(400));
    }];
    [self.seperatorLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(400);
        make.width.equalTo(@(1));
    }];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.seperatorLine1.mas_right);
        make.width.equalTo(@(400));
    }];
}

#pragma mark - Property
-(ZXStretchView *)stretchView
{
    if (!_stretchView)
    {
        _stretchView = [[ZXStretchView alloc] init];;
    }
    
    return _stretchView;
}

-(ZXListView *)listView
{
    if (!_listView)
    {
        _listView = [[ZXListView alloc] init];
    }
    
    return _listView;
}

-(NSView *)seperatorLine1
{
    if (!_seperatorLine1)
    {
        _seperatorLine1 = [[NSView alloc] init];
        _seperatorLine1.wantsLayer = YES;
        _seperatorLine1.layer.backgroundColor = [NSColor darkGrayColor].CGColor;
    }
    
    return _seperatorLine1;
}

@end
