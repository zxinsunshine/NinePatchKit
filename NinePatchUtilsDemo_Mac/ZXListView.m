//
//  ZXListView.m
//_Mac
//
//  Created by sunny on 2021/8/6.
//

#import "ZXListView.h"
#import "ZXListViewCell.h"

@interface ZXListView () <NSTabViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSTableView *tableView;
@property (nonatomic, strong) NSMutableArray<ZXListViewCellModel *> * modelList;

@end

@implementation ZXListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.stringValue = @"List";
        
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
            make.left.equalTo(self).offset(10.0);
            make.right.equalTo(self).offset(-10.0);;
            make.height.equalTo(@(500));
        }];
        
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
        
        CGFloat maxWidth = 400.0 / 2;
        NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"5" ofType:@"png"];
        ImageClass * bubbleImage = [NinePatchUtils imageWithContentsOfFile:imagePath];
        for (int i = 0; i < 10; ++i)
        {
            [chatList enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZXListViewCellModel * model = [ZXListViewCell modelForText:obj sender:(idx % 2 == 0) withMaxWidth:maxWidth backImage:bubbleImage];
                [self.modelList addObject:model];
            }];
        }
        
        [self.tableView reloadData];
    }
    
    return self;
}

#pragma mark - NSTabViewDelegate, NSTableViewDataSource
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.modelList.count;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    ZXListViewCell *cell = [[ZXListViewCell alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    cell.identifier = @"ZXListViewCell";
    cell.model = self.modelList[row];
    [cell updateContents];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return self.modelList[row].totalSize.height;
}

#pragma mark - Property
-(NSScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[NSScrollView alloc] init];
        _scrollView.hasVerticalScroller = YES;
        _scrollView.contentView.documentView = self.tableView;
    }
    
    return _scrollView;
}
-(NSTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[NSTableView alloc] init];
        NSTableColumn * column = [[NSTableColumn alloc] initWithIdentifier:@"test"];
        [_tableView addTableColumn:column];
        [_tableView setHeaderView:nil];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (NSMutableArray *)modelList
{
    if (!_modelList)
    {
        _modelList = [NSMutableArray array];
    }
    return _modelList;
}

@end
