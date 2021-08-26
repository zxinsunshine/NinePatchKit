# NinePathKit

----------------

NinePatch image parser and render framework for iOS & macOS

#### Multilingual translation

[Chinese README](README.zh.md)

#### Main Features

* parse png's binary data to get its chunk data
* slice image according its npTc chunk, then draw them in rule
* NinePathImageView has its contentView like UITableViewCell, where you can place any UI object
* support flip horizontally and vertically
* support muliple platform

#### Requirements

* iOS 9.0+

* macOS 10.11+

#### Installation

##### CocoaPods

The preferred installation method is with [CocoaPods](https://cocoapods.org). Add the following to your `Podfile`:

```ruby
pod 'NinePatchKit', '~> 1.0'
```

##### Manual

Copy NinePatchUtils directory in your project


#### Getting Started

```objective-c
#import <NinePatchKit/NinePatchKit.h>
...
NSString * path = [[NSBundle mainBundle] pathForResource:@"YourNinePatchImageName" ofType:@"png"];
NinePathImageView * imageView = [[NinePathImageView alloc] init];
imageView.showImage = [NinePatchUtils imageWithContentsOfFile:path];
```

#### License

`NinePatchKit` is [MIT-licensed](https://github.com/zxinsunshine/NinePatchKit/blob/master/LICENSE).

