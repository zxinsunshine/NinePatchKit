//
//  NSData+BytesUtils.h
//  Test
//
//  Created by Theo on 2021/7/8.
//

#import "NinePatchCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSData (BytesUtils)

/// Judge if is small endian
+ (BOOL)isSmallEndian;

/// The hex string of data
- (NSString *)hexStr;

/// The hex string of data in range
/// @param range range of data
- (NSString *)hexStrWithRange:(NSRange)range;

/// The decimal string list of data
- (NSString *)strByteList;

/// The decimal number list of data
- (NSArray<NSNumber *> *)intByteList;

@end

NS_ASSUME_NONNULL_END
