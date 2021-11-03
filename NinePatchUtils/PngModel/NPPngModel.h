//
//  NPPngModel.h
//  Test
//
//  Created by Theo on 2021/7/9.
//

#import "NinePatchCompatibility.h"
#import "NPPngChunkModel.h"

static const NSInteger kPngSingnatureLen = 8;

NS_ASSUME_NONNULL_BEGIN

@interface NPPngModel : NSObject

@property (nonatomic, strong, readonly) NSDictionary<NSString *, NPPngChunkModel *> * chunkDict;
@property (nonatomic, strong, readonly) NSData * pngData;

+ (BOOL)isPngFile:(NSData *)data;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithData:(NSData *)data;

/// initial new object
/// @param data object data
/// @param registerClass specifical subclass of NPPngChunkModel for a type
- (instancetype)initWithData:(NSData *)data registerClass:(nullable NSDictionary<NSString *, Class> *)registerClass;

@end

NS_ASSUME_NONNULL_END
