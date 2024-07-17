# NinePatchKit

----------------

NinePatch image parser and render framework for iOS & macOS

#### Multilingual translation

[Chinese README](README.zh.md)

#### Main Features

* parse png's binary data to get its chunk data
* slice image according its npTc chunk, then draw them in rule
* NinePatchImageView has its contentView like UITableViewCell, where you can place any UI object
* support flip horizontally and vertically
* support muliple platform
* support auto layout

#### Requirements

* iOS 9.0+
* macOS 10.11+

#### Effects

![Demo](./Demo.gif)

![Demo_for_mac](./Demo_for_mac.gif)

#### Installation

##### CocoaPods

The preferred installation method is with [CocoaPods](https://cocoapods.org). Add the following to your `Podfile`:

```ruby
pod 'NinePatchKit'
```

##### Manual

Copy NinePatchUtils directory in your project


#### Getting Started

```objective-c
#import <NinePatchKit/NinePatchKit.h>
...
NSString * path = [[NSBundle mainBundle] pathForResource:@"YourNinePatchImageName" ofType:@"png"];
NinePatchImageView * imageView = [[NinePatchImageView alloc] init];
imageView.showImage = [NinePatchUtils imageWithContentsOfFile:path];

[imageView.contentView addSubview:CustomView]; // add subview to contentView
```

#### Tips
* Placement of nine-patch pictures
  * You can place nine-patch pictures in **bundle, Data Set and other places besides Image Set**. During the construction, all png pictures in Image Set will be optimized by **implanting a CgBI chunk, and some chunks will be removed**, so the format of nine-patch pictures will be damaged and cannot be parsed.

#### License

`NinePatchKit` is [MIT-licensed](https://github.com/zxinsunshine/NinePatchKit/blob/master/LICENSE).

