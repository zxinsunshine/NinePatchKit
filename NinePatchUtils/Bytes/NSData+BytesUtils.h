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
+ (BOOL)np_isSmallEndian;

/// The hex string of data
- (NSString *)np_hexStr;

/// The hex string of data in range
/// @param range range of data
- (NSString *)np_hexStrWithRange:(NSRange)range;

/// The decimal string list of data
- (NSString *)np_strByteList;

/// The decimal number list of data
- (NSArray<NSNumber *> *)np_intByteList;

@end

NS_ASSUME_NONNULL_END
