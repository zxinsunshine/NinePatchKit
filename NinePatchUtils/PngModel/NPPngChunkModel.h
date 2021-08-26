//
//  NPPngChunkModel.h
//  Test
//
//  Created by Theo on 2021/7/9.
//

#import "NinePatchCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface NPPngChunkModel : NSObject

@property (nonatomic, assign, readonly) NSInteger totalLength;
@property (nonatomic, strong, readonly) NSData * totalData;
@property (nonatomic, assign, readonly) NSInteger chunkDataLength;
@property (nonatomic, copy, readonly) NSString * chunkTypeCode;
@property (nonatomic, strong, readonly) NSData * chunkData;
@property (nonatomic, assign, readonly) NSInteger crcCode;

// the chunk part of data
- (instancetype)initWithData:(NSData *)data beginIndex:(NSInteger)index;

// chunk type
+ (NSString *)codeTypeWithData:(NSData *)data beginIndex:(NSInteger)index;

// calculate arc number of chunk data
+ (NSInteger)calculateCrcCodeWithTypeAndChunkData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
