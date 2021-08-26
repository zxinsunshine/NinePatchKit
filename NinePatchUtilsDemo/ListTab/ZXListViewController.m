//
//  ZXListViewController.m
//
//
//  Created by Theo on 2021/7/19.
//

#import "ZXListViewController.h"
#import "ZXListTableViewCell.h"
#import <NinePatchKit/NinePatchKit.h>

@interface ZXListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * listView;
@property (nonatomic, strong) NSMutableArray<ZXListTableViewCellModel *> * modelList;

@end

@implementation ZXListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listView];
    self.listView.frame = self.view.bounds;
    
    NSArray * chatList = @[
        @"Hello! This is Sally",
        @"Hi! Sally, Can I help you?",
        @"Well, I need a shorts, so can you give me some suggestion?",
        @"Ok, what color do you want?",
        @"Purple",
        @"Luckily, we have many kinds of purple shorts for you, how about your size?",
        @"Just a small one. In addition, I want some cartoon patterns on my shorts, which makes me feel cool. I'm a fan of Japanese comics, Are there any shorts with One Piece comics's logo?",
        @"Sorry, we are out of stock. Can other cartoon shorts be ok?",
        @"Naruto?",
        @"Yes, yes, when do you want it? We'll send it to you in advance. If you have any questions, contact me and I can deal with it for you.",
        @"OK"
    ];
    CGFloat maxWidth = self.view.bounds.size.width / 2;
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"5" ofType:@"png"];
    ImageClass * bubbleImage = [NinePatchUtils imageWithContentsOfFile:imagePath];
    for (int i = 0; i < 10; ++i) {
        [chatList enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZXListTableViewCellModel * model = [ZXListTableViewCell modelForText:obj sender:(idx % 2 == 0) withMaxWidth:maxWidth backImage:bubbleImage];
            [self.modelList addObject:model];
        }];        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZXListTableViewCell class]) forIndexPath:indexPath];
    cell.model = self.modelList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.modelList[indexPath.row].totalSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Getter

- (UITableView *)listView {
    if (!_listView) {
        _listView = ({
            UITableView * tableView = [[UITableView alloc] init];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.dataSource = self;
            tableView.delegate = self;
            
            NSMutableArray<Class> * registerClassList = [NSMutableArray array];
            [registerClassList addObject:[ZXListTableViewCell class]];
            [registerClassList enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tableView registerClass:obj forCellReuseIdentifier:NSStringFromClass(obj)];
            }];
            
            tableView;
        });
    }
    return _listView;
}

- (NSMutableArray *)modelList {
    if (!_modelList) {
        _modelList = [NSMutableArray array];
    }
    return _modelList;
}

@end
