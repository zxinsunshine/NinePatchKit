//
//  NPPngModel.h
//  Test
//
//  Created by Theo on 2021/7/9.
//

#import "NinePatchCompatibility.h"
#import "NPPngChunkModel.h"
#import "NPPngNptcChunkModel.h"

static const NSInteger kPngSingnatureLen = 8;
#define npTcTypeCode @"npTc"
#define CgBITypeCode @"CgBI"

NS_ASSUME_NONNULL_BEGIN

@interface NPPngModel : NSObject

@property (nonatomic, strong, readonly) NSArray<NPPngChunkModel *> * chunkList;
@property (nonatomic, assign, readonly) BOOL isNinePatch;
@property (nonatomic, strong, readonly) NSData * pngData;

+ (BOOL)isPngFile:(NSData *)data;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
