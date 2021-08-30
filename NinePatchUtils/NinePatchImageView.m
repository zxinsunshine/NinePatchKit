//
//  NinePatchImageView.m
//  Test
//
//  Created by Theo on 2021/7/16.
//

#import "NinePatchImageView.h"
#import "NPMultiStretchImage.h"

@interface NinePatchImageView()

@property (nonatomic, assign, readwrite) EdgeStruct padding;
@property (nonatomic, strong, readwrite) ViewClass * contentView;

@end

@implementation NinePatchImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#if TARGET_ON_iOS
        self.opaque = NO;
#else
        self.wantsLayer = YES;
#endif
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setShowImage:(ImageClass *)showImage {

    _showImage = showImage;
    
    NPMultiStretchImage * stretchImage = nil;
    if ([self.showImage isKindOfClass:[NPMultiStretchImage class]]) {
        stretchImage = (NPMultiStretchImage *)self.showImage;
    }
    if (stretchImage) {
        self.padding = stretchImage.padding;
    } else {
        self.padding = EdgeStructZero;
    }
    
    [self refreshDrawing];
}

- (void)setReverseX:(BOOL)reverseX {
    if (_reverseX == reverseX) {
        return;
    }
    _reverseX = reverseX;
    
    if (reverseX) {
#if !TARGET_ON_iOS
        [self setAnchorPoint:CGPointMake(0.5, 0.5) foirView:self];
        [self setAnchorPoint:CGPointMake(0.5, 0.5) foirView:self.contentView];
#endif
        
        self.layer.affineTransform = CGAffineTransformMakeScale(-1, 1);
        self.contentView.layer.affineTransform = CGAffineTransformMakeScale(-1, 1);
    } else {
        self.layer.affineTransform = CGAffineTransformIdentity;
        self.contentView.layer.affineTransform = CGAffineTransformIdentity;
    }
}

- (void)setReverseY:(BOOL)reverseY {
    if (_reverseY == reverseY) {
        return;
    }
    
    if (reverseY) {
        self.layer.affineTransform = CGAffineTransformMakeScale(1, -1);
        self.contentView.layer.affineTransform = CGAffineTransformMakeScale(1, -1);
    } else {
        self.layer.affineTransform = CGAffineTransformIdentity;
        self.contentView.layer.affineTransform = CGAffineTransformIdentity;
    }
}

#if TARGET_ON_iOS

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self refreshDrawing];
}
#else

- (void)layout {
    [super layout];
    
    [self refreshDrawing];
}

#endif


#pragma mark - Private Methods

- (void)refreshDrawing {
    // update content view's layout
    [self updateContentView];
    
    // clear content
    self.layer.contents = nil;
    
    // redraw
#if TARGET_ON_iOS
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}

- (void)drawRect:(CGRect)rect {
  
    NPMultiStretchImage * stretchImage = nil;
    if ([self.showImage isKindOfClass:[NPMultiStretchImage class]]) {
        stretchImage = (NPMultiStretchImage *)self.showImage;
    }
    
    // if image object is not a NPMultiStretchImage object or  no slice images are drawed, just draw a raw image
    if (!stretchImage || stretchImage.sliceImages.count == 0) {
        [self drawShowImage:self.showImage inRect:rect];
    } else {
        [self drawStretchImage:stretchImage inRect:rect];
    }
    
}

- (void)drawShowImage:(ImageClass *)image inRect:(CGRect)rect {
    if (!image) {
        return;
    }
    
    CGSize viewSize = rect.size;
    CGSize drawSize = viewSize;
    CGFloat top = 0;
    CGFloat left = 0;
    
#if TARGET_ON_iOS
    CGSize imageSize = image.size;
    UIViewContentMode curContentMode = self.contentMode;
    switch (curContentMode) {
        case UIViewContentModeScaleToFill: {
            break;
        }
        case UIViewContentModeScaleAspectFit: {
            if (imageSize.height > 0 && imageSize.width > 0 && viewSize.height > 0 && viewSize.width > 0) {
                CGFloat whRatio = imageSize.width / imageSize.height;
                if (viewSize.height * whRatio > viewSize.width) {
                    drawSize.width = viewSize.width;
                    drawSize.height = viewSize.width / whRatio;
                } else if (viewSize.width / whRatio > viewSize.height) {
                    drawSize.height = viewSize.height;
                    drawSize.width = viewSize.height * whRatio;
                }
                top = (viewSize.height - drawSize.height) / 2;
                left = (viewSize.width - drawSize.width) / 2;
            }
            break;
        }
        case UIViewContentModeScaleAspectFill: {
            if (imageSize.height > 0 && imageSize.width > 0 && viewSize.height > 0 && viewSize.width > 0) {
                CGFloat whRatio = imageSize.width / imageSize.height;
                if (viewSize.height * whRatio < viewSize.width) {
                    drawSize.width = viewSize.width;
                    drawSize.height = viewSize.width / whRatio;
                }
                if (viewSize.width / whRatio < viewSize.height) {
                    drawSize.height = viewSize.height;
                    drawSize.width = viewSize.height * whRatio;
                }
                top = (viewSize.height - drawSize.height) / 2;
                left = (viewSize.width - drawSize.width) / 2;
            }
            break;
        }
        case UIViewContentModeCenter: {
            drawSize = imageSize;
            top = (viewSize.height - drawSize.height) / 2;
            left = (viewSize.width - drawSize.width) / 2;
            break;
        }
        case UIViewContentModeTop: {
            drawSize = imageSize;
            top = 0;
            left = (viewSize.width - drawSize.width) / 2;
            break;
        }
        case UIViewContentModeBottom: {
            drawSize = imageSize;
            top = viewSize.height - drawSize.height;
            left = (viewSize.width - drawSize.width) / 2;
            break;
        }
        case UIViewContentModeLeft: {
            drawSize = imageSize;
            top = (viewSize.height - drawSize.height) / 2;
            left = 0;
            break;
        }
        case UIViewContentModeRight: {
            drawSize = imageSize;
            top = (viewSize.height - drawSize.height) / 2;
            left = viewSize.width - drawSize.width;
            break;
        }
        case UIViewContentModeTopLeft: {
            drawSize = imageSize;
            top = 0;
            left = 0;
            break;
        }
        case UIViewContentModeTopRight: {
            drawSize = imageSize;
            top = 0;
            left = viewSize.width - drawSize.width;
            break;
        }
        case UIViewContentModeBottomLeft: {
            drawSize = imageSize;
            top = viewSize.height - drawSize.height;
            left = 0;
            break;
        }
        case UIViewContentModeBottomRight: {
            drawSize = imageSize;
            top = viewSize.height - drawSize.height;
            left = viewSize.width - drawSize.width;
            break;
        }
        default:
            break;
    }
#endif
    
    [self.showImage drawInRect:CGRectMake(left, top, drawSize.width, drawSize.height)];
    
}

- (void)drawStretchImage:(NPMultiStretchImage *)stretchImage inRect:(CGRect)rect {
    CGSize size = rect.size;

    // draw slice images
    NSArray<NSArray<NPMultiStretchSliceImage *> *> * slice2DImages = stretchImage.sliceImages;
    
    CGFloat maxSolidWidth = stretchImage.maxSolidWidth;
    CGFloat maxSolidHeight = stretchImage.maxSolidHeight;
    
    // if real size is less than raw image size, then draw solid images in ratio
    CGFloat solidWidthRatio = 1;
    CGFloat solidHeightRatio = 1;
    if (size.width < maxSolidWidth) {
        solidWidthRatio = size.width / maxSolidWidth;
    }
    if (size.height < maxSolidHeight) {
        solidHeightRatio = size.height / maxSolidHeight;
    }
    
    // the total part of stretch size
    CGSize stretchSize = CGSizeMake(MAX(0, size.width - stretchImage.maxSolidWidth), MAX(0, size.height - stretchImage.maxSolidHeight));
    
    NSMutableArray <NSNumber *> * beginYList = [NSMutableArray array];
    for (int i = 0; i < slice2DImages.firstObject.count; ++i) {
        [beginYList addObject:@(0)];
    }
    for (int j = 0; j < slice2DImages.count; ++j) {
        CGFloat beginX = 0;
        NSArray<NPMultiStretchSliceImage *> * line = slice2DImages[j];
        for (int i = 0; i < line.count; ++i) {
            CGFloat beginY = [self fixedNumber:[beginYList[i] floatValue] maxNum:size.height];
            
            CGSize drawSize = line[i].rect.size;
            
            // 若不用纵向拉伸，不绘制需要纵向拉伸的区域
            if (stretchSize.height == 0 && line[i].verticalStretchRatio > 0) {
                continue;
            }
            // 若不用横向拉伸，不绘制需要横向拉伸的区域
            if (stretchSize.width == 0 && line[i].horizontalStretchRatio > 0) {
                continue;
            }
            
            if (line[i].verticalStretchRatio > 0) { // 纵向拉伸区域
                CGFloat stretchHei = stretchSize.height * line[i].verticalStretchRatio;
                drawSize.height = [self fixedNumber:stretchHei maxNum:(size.height - beginY)];
            } else { // 纵向固定区域
                CGFloat stretchHei = drawSize.height * solidHeightRatio;
                drawSize.height = [self fixedNumber:stretchHei maxNum:(size.height - beginY)];
            }
            if (line[i].horizontalStretchRatio) { // 横向拉伸区域
                CGFloat stretchWid = stretchSize.width * line[i].horizontalStretchRatio;
                drawSize.width = [self fixedNumber:stretchWid maxNum:(size.width - beginX)];
            } else { // 横向固定区域
                CGFloat stretchWid = drawSize.width * solidWidthRatio;
                drawSize.width = [self fixedNumber:stretchWid maxNum:(size.width - beginX)];
            }
            CGFloat finalBeginY = beginY;
#if !TARGET_ON_iOS
            // macOS's Y axis is reverse to iOS's
            finalBeginY = size.height - (beginY + drawSize.height);
#endif
            [line[i].totalImage drawInRect:CGRectMake(beginX, finalBeginY, drawSize.width, drawSize.height)];
            
            beginX += drawSize.width;
            beginYList[i] = @(beginY + drawSize.height);
        }
    }
}

- (void)updateContentView {
    CGSize size = self.bounds.size;
    EdgeStruct padding = self.padding;
    CGFloat contentWid = MAX(0, size.width - (padding.left + padding.right));
    CGFloat contentHei = MAX(0, size.height - (padding.top + padding.bottom));
   
    CGFloat contentLeft = padding.left;
    if (contentWid == 0) {
        contentLeft = (size.width - contentWid) / 2;
    }
    CGFloat contentTop = padding.top;
    if (contentHei == 0) {
        contentTop = (size.height - contentHei) / 2;
    }
    self.contentView.frame = CGRectMake(contentLeft, contentTop, contentWid, contentHei);
}


- (CGFloat)fixedNumber:(CGFloat)num maxNum:(CGFloat)maxNum {
    CGFloat fiexdNum = round(num);
    return MIN(fiexdNum, maxNum);
}

-(void)setAnchorPoint:(CGPoint)anchorPoint foirView:(ViewClass*)view
{
    view.layer.anchorPoint = anchorPoint;
 
    CGRect frame = view.layer.frame;
    float xCoord = frame.origin.x + frame.size.width;
    float yCoord = frame.origin.y + frame.size.height;
    
    CGPoint point = CGPointMake(xCoord, yCoord);
    
    view.layer.position = point;
}

#pragma mark - Getter

- (ViewClass *)contentView {
    if (!_contentView) {
        _contentView = ({
            ViewClass * view = [[ViewClass alloc] init];
#if !TARGET_ON_iOS
            view.wantsLayer = YES;
#endif
            view;
        });
    }
    return _contentView;
}

@end
