//
//  NinePatchUtils.m
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NinePatchUtils.h"
#import "NPMultiStretchImage.h"

#define FormatCacheKeyFromPrefix(prefix, name, fromScale, toScale) [NSString stringWithFormat:@"%@-%@-%lf-%lf", prefix, name, fromScale, toScale]

@interface NinePatchUtils()

@property (nonatomic, strong) NSCache * cache;

@end


@implementation NinePatchUtils

+ (ImageClass *)imageNamed:(NSString *)name {
    
    NSData * imageData = [[NSDataAsset alloc] initWithName:name].data;
    NSString * cacheKey = FormatCacheKeyFromPrefix(@"Asset", name, MaxScreenScale, ScreenScale);
    ImageClass * stretchImage = [self getStretchImageWithRawImage:imageData forKey:cacheKey fromScale:MaxScreenScale toScale:ScreenScale];

    return stretchImage;
}

+ (ImageClass *)imageWithContentsOfFile:(NSString *)path {
    
    NSData * imageData = [NSData dataWithContentsOfFile:path];
    NSString * cacheKey = FormatCacheKeyFromPrefix(@"Bundle", path, MaxScreenScale, ScreenScale);
    ImageClass * stretchImage = [self getStretchImageWithRawImage:imageData forKey:cacheKey fromScale:MaxScreenScale toScale:ScreenScale];

    return stretchImage;
}

+ (ImageClass *)imageWithData:(NSData *)data {
    
    NSData * imageData = data;
    NSString * path = [NSString stringWithFormat:@"%p", imageData];
    NSString * cacheKey = FormatCacheKeyFromPrefix(@"Data", path, MaxScreenScale, ScreenScale);
    ImageClass * stretchImage = [self getStretchImageWithRawImage:imageData forKey:cacheKey fromScale:MaxScreenScale toScale:ScreenScale];

    return stretchImage;
}

+ (EdgeStruct)paddingForImage:(ImageClass *)image {
    EdgeStruct padding = EdgeStructZero;
    if ([image isKindOfClass:[NPMultiStretchImage class]]) {
        NPMultiStretchImage * stretchImage = (NPMultiStretchImage *)image;
        padding = stretchImage.padding;
    }
    
    return padding;
}

+ (BOOL)isNinePatchImage:(ImageClass *)image {
    BOOL isNinePatch = NO;
    if ([image isKindOfClass:[NPMultiStretchImage class]]) {
        NPMultiStretchImage * stretchImage = (NPMultiStretchImage *)image;
        return stretchImage.isNinePatch;
    }
    return isNinePatch;
}

#pragma mark - Private Methods
+ (instancetype)sharedInstance {
    static NinePatchUtils * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:nil] init];
    });
    return _sharedInstance;
}
+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}
- (id)copyWithZone:(NSZone *)zone{
    return [[self class] sharedInstance];
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] sharedInstance];
}
+ (void)clearCache {
    [[NinePatchUtils sharedInstance].cache removeAllObjects];
}

+ (ImageClass *)getStretchImageWithRawImage:(NSData *)imageData forKey:(NSString *)key fromScale:(CGFloat)fromScale toScale:(CGFloat)toScale {
    
    // priority cache
    ImageClass * cacheImage = [[NinePatchUtils sharedInstance].cache objectForKey:key];
    if (cacheImage) {
        return cacheImage;
    }

    ImageClass * stretchImage = [NPMultiStretchImage generateImageWithData:imageData fromScale:fromScale toScale:toScale];
    
    if (stretchImage) {
        [[NinePatchUtils sharedInstance].cache setObject:stretchImage forKey:key];
    }
    return stretchImage;
}

#pragma mark - Getter
- (NSCache *)cache {
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.totalCostLimit = 1024 * 1024 * 50; // 50M
    }
    return _cache;
}

@end
