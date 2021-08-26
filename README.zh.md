# NinePatchKit

----------------

一个iOS & macOS端的点九图解析和渲染的框架

#### 多语言翻译

[英文README](README.md)

#### 主要特性

* 解析png文件的二进制数据中chunk段数据
* 根据npTc chunk数据切分点九图，重绘渲染
* NinePathImageView像UITableViewCell一样拥有自己的contentView，可以填充任意内容
* 支持横向和纵向翻转
* 支持多平台

#### 要求

* iOS 9.0+
* macOS 10.11+


#### 安装教程

##### CocoaPods

推荐使用[CocoaPods](https://cocoapods.org)来进行安装，只需添加如下语句到你的`Podfile`文件中:

```ruby
pod 'NinePatchKit', '~> 1.0'
```

##### 手动安装

将NinePatchUtils文件夹拖入工程中直接使用

#### 入门指南

```objective-c
#import <NinePatchKit/NinePatchKit.h>
...
NSString * path = [[NSBundle mainBundle] pathForResource:@"YourNinePatchImageName" ofType:@"png"];
NinePathImageView * imageView = [[NinePathImageView alloc] init];
imageView.showImage = [NinePatchUtils imageWithContentsOfFile:path];
```

#### License

`NinePatchKit` 遵循[MIT-licensed](https://github.com/zxinsunshine/NinePatchKit/blob/master/LICENSE)。