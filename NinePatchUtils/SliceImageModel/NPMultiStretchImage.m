//
//  NPMultiStretchImage.m
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NPMultiStretchImage.h"
#import "NPPngModel.h"

@interface NPMultiStretchImage()

@property (nonatomic, strong, readwrite) NSArray<NSArray<NPMultiStretchSliceImage *> *> * sliceImages;
@property (nonatomic, assign, readwrite) CGFloat maxSolidHeight;
@property (nonatomic, assign, readwrite) CGFloat maxSolidWidth;
@property (nonatomic, assign, readwrite) EdgeStruct padding;
@property (nonatomic, strong, readwrite) NPPngModel * pngModel;

@end

@implementation NPMultiStretchImage

+ (instancetype)generateImageWithData:(NSData *)data fromScale:(CGFloat)fromScale toScale:(CGFloat)toScale {
    
    NPMultiStretchImage * stretchImage = [[super alloc] initWithData:data]; // self is raw imagestretchImage
    // change physical pixels
    [stretchImage analyzeData:data fromScale:fromScale toScale:toScale];
    return stretchImage;
}

#pragma mark - Private Methods

- (void)analyzeData:(NSData *)imageData fromScale:(CGFloat)fromScale toScale:(CGFloat)toScale {
    
    if (fromScale <= 0) {
        fromScale = MaxScreenScale;
    }
    if (toScale < 0) {
        toScale = 1;
    }
    
    NPPngModel * pngModel = [[NPPngModel alloc] initWithData:imageData];
    self.pngModel = pngModel;
    if (!pngModel.isNinePatch) {
        return;
    }

    // find nptc chunk
    __block NPPngNptcChunkModel * nptcChunkModel = nil;
    [pngModel.chunkList enumerateObjectsUsingBlock:^(NPPngChunkModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NPPngNptcChunkModel class]]) {
            nptcChunkModel = (NPPngNptcChunkModel *)obj;
            *stop = YES;
        }
    }];
    // no nptc chunk
    if (!nptcChunkModel) {
        return;
    }
    
    // calculate
    self.padding = EdgeStructMake(nptcChunkModel.padding.top / fromScale, nptcChunkModel.padding.left / fromScale, nptcChunkModel.padding.bottom / fromScale, nptcChunkModel.padding.right / fromScale);
    
    // to ensure accuracy, slice by physical pixels, then change scale
    ImageClass * rawImage = [[ImageClass alloc] initWithData:imageData];

    CGSize imagePixelSize = rawImage.size;
    NSMutableArray * xPointList = [NSMutableArray array];
    [xPointList addObject:@(0)];
    for (int i = 0; i < nptcChunkModel.divX.count; ++i) {
        CGFloat scalePoint = [nptcChunkModel.divX[i] floatValue];
        [xPointList addObject:@(scalePoint)];
    }
    [xPointList addObject:@(imagePixelSize.width)];
    
    NSMutableArray * yPointList = [NSMutableArray array];
    [yPointList addObject:@(0)];
    for (int i = 0; i < nptcChunkModel.divY.count; ++i) {
        CGFloat scalePoint = [nptcChunkModel.divY[i] floatValue];
        [yPointList addObject:@(scalePoint)];
    }
    [yPointList addObject:@(imagePixelSize.height)];

    // build model
    NSMutableArray <NSMutableArray<NPMultiStretchSliceImage *> *> * slice2DList = [NSMutableArray array];
    
    CGFloat maxSolidWidth = 0;
    CGFloat maxSolidHeight = 0;
    for (int j = 0; j < yPointList.count - 1; ++j) {
        NSMutableArray<NPMultiStretchSliceImage *> * stretchLine = [NSMutableArray array];
        BOOL stretchY = ((j % 2) == 1); // judge whether to stretch the x-axis according to the starting point of the x-axis
        for (int i = 0; i < xPointList.count - 1; ++i) {
            CGFloat x = [xPointList[i] floatValue];
            CGFloat y = [yPointList[j] floatValue];
            CGFloat w = [xPointList[i+1] floatValue] - x;
            CGFloat h = [yPointList[j+1] floatValue] - y;
            if (w > 0 && h > 0) {
                CGRect pointRect = CGRectMake(x, y, w, h);
                NPMultiStretchSliceImage * sliceImage = [[NPMultiStretchSliceImage alloc] initWithImage:rawImage subRect:pointRect];
                if (sliceImage) {
                    BOOL stretchX = ((i % 2) == 1); // judge whether to stretch the x-axis according to the starting point of the x-axis
                    if (stretchX) {
                        sliceImage.horizontalStretchRatio = 1; // temporary marking
                    } else if (j == 0) {
                        maxSolidWidth += sliceImage.rect.size.width;
                    }
                    if (stretchY) {
                        sliceImage.verticalStretchRatio = 1; // temporary marking
                    } else if (i == 0) { // count the maximum fixed height of the first column
                        maxSolidHeight += sliceImage.rect.size.height;
                    }
                    [stretchLine addObject:sliceImage];
                }
            }
        }
        if (stretchLine.count) {
            [slice2DList addObject:stretchLine];            
        }
    }
    
    // corrects the ratio of the extruded area to the total extruded area
    /**
            i   i+1
            --- --- ---
           j
            --- --- ---
          j+1
            --- --- ---
     */
    for (int j = 0; j < slice2DList.count; ++j) {
        NSMutableArray<NPMultiStretchSliceImage *> *line = slice2DList[j];
        for (int i = 0; i < line.count; ++i) {
            NPMultiStretchSliceImage * sliceImage = line[i];
            if (maxSolidHeight > 0 && line[i].verticalStretchRatio > 0) {
                sliceImage.verticalStretchRatio = sliceImage.rect.size.height / (imagePixelSize.height - maxSolidHeight);
            }
            if (maxSolidWidth > 0 && line[i].horizontalStretchRatio > 0) {
                sliceImage.horizontalStretchRatio = sliceImage.rect.size.width / (imagePixelSize.width - maxSolidWidth);
            }
            // change the data of sliceImage to logic data according to scale
            // because rect is calculated by scale, sliceImage do not need to change scale, it can be scaled when it's drawed
            CGRect originRect = sliceImage.rect;
            CGRect scaledRect = CGRectMake(originRect.origin.x / fromScale, originRect.origin.y / fromScale, originRect.size.width / fromScale, originRect.size.height / fromScale);
            sliceImage.rect = scaledRect;
            line[i] = sliceImage;
        }
    }
    
    self.sliceImages = slice2DList;
    self.maxSolidHeight = maxSolidHeight / fromScale;
    self.maxSolidWidth = maxSolidWidth / fromScale;
}




@end
