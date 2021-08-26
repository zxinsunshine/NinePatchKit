//
//  MainViewController.m
//
//
//  Created by Theo on 2021/7/19.
//

#import "MainViewController.h"
#import "ZXStretchViewController.h"
#import "ZXListViewController.h"

@interface MainViewController()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTab];
}

- (void)setupTab {
    
    NSMutableArray * tabList = [NSMutableArray array];
    [tabList addObject:@[@"Stretch", [ZXStretchViewController class]]];
    [tabList addObject:@[@"List", [ZXListViewController class]]];
    
    for (int i = 0; i < tabList.count; ++i) {
        NSString * title = tabList[i][0];
        UIColor * color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        UIImage * image = [MainViewController imageFromColor:color size:CGSizeMake(20, 20)];
        UITabBarItem * tabItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:nil];
        Class cls = tabList[i][1];
        UIViewController *viewController = [[cls alloc] init];
        viewController.title = title;
   
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.tabBarItem = tabItem;
        [self addChildViewController:nav];
    }
}

+ (UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width,size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
