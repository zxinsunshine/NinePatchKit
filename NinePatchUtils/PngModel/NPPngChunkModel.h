//
//  NPPngChunkModel.h
//  Test
//
//  Created by Theo on 2021/7/9.
//

#import "NinePatchCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface NPPngChunkModel : NSObject

@property (nonatomic, assign, readonly) NSInteger totalLength; // 总长度
@property (nonatomic, strong, readonly) NSData * totalData; // 总Data
@property (nonatomic, assign, readonly) NSInteger chunkDataLength;
@property (nonatomic, copy, readonly) NSString * chunkTypeCode;
@property (nonatomic, strong, readonly) NSData * chunkData;
@property (nonatomic, assign, readonly) NSInteger crcCode;

// 通过原数据解析生成ChunkModel对象
- (instancetype)initWithData:(NSData *)data beginIndex:(NSInteger)index;

// chunk type
+ (NSString *)codeTypeWithData:(NSData *)data beginIndex:(NSInteger)index;

// 根据 chunk type 和 chunk data 计算crc值
+ (NSInteger)calculateCrcCodeWithTypeAndChunkData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
