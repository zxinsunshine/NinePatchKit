//
//  NinePatchUtils.m
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NinePatchUtils.h"
#import "NPMultiStretchImage.h"

#define FormatCacheKeyFromAsset(name, fromScale, toScale) [NSString stringWithFormat:@"Asset-%@-%lf-%lf", name, fromScale, toScale]
#define FormatCacheKeyFromBundle(path, fromScale, toScale) [NSString stringWithFormat:@"Path-%@-%lf-%lf", path, fromScale, toScale]

@interface NinePatchUtils()

@property (nonatomic, strong) NSCache * cache;

@end


@implementation NinePatchUtils

+ (ImageClass *)imageNamed:(NSString *)name {
    
    return [self imageNamed:name fromScale:MaxScreenScale toScale:ScreenScale];
}

+ (ImageClass *)imageWithContentsOfFile:(NSString *)path {
    
    return [self imageWithContentsOfFile:path fromScale:MaxScreenScale toScale:ScreenScale];
}

+ (EdgeStruct)paddingForImage:(ImageClass *)image {
    EdgeStruct padding = EdgeStructZero;
    if ([image isKindOfClass:[NPMultiStretchImage class]]) {
        NPMultiStretchImage * stretchImage = (NPMultiStretchImage *)image;
        padding = stretchImage.padding;
    }
    
    return padding;
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

+ (ImageClass *)imageNamed:(NSString *)name fromScale:(CGFloat)fromScale toScale:(CGFloat)toScale {
    NSData * imageData = [[NSDataAsset alloc] initWithName:name].data;
    NSString * cacheKey = FormatCacheKeyFromAsset(name, fromScale, toScale);
    ImageClass * stretchImage = [self getStretchImageWithRawImage:imageData forKey:cacheKey fromScale:fromScale toScale:toScale];
    
    return stretchImage;
}

+ (ImageClass *)imageWithContentsOfFile:(NSString *)path fromScale:(CGFloat)fromScale toScale:(CGFloat)toScale {
    NSData * imageData = [NSData dataWithContentsOfFile:path];
    NSString * cacheKey = FormatCacheKeyFromBundle(path, fromScale, toScale);
    ImageClass * stretchImage = [self getStretchImageWithRawImage:imageData forKey:cacheKey fromScale:fromScale toScale:toScale];

    return stretchImage;
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
        _cache.totalCostLimit = 1024 * 1024 * 5; // 5M
    }
    return _cache;
}

@end
