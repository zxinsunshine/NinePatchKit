//
//  NSData+BytesUtils.h
//  Test
//
//  Created by Theo on 2021/7/8.
//

#import "NinePatchCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSData (BytesUtils)


/// 是否是小端
+ (BOOL)isSmallEndian;

/// 16进制字符串表示
- (NSString *)hexStr;

/// 局部16进制字符串表示
/// @param range 局部范围
- (NSString *)hexStrWithRange:(NSRange)range;

/// 10进制字节字符串数组
- (NSString *)strByteList;

/// 10进制字节数字数组
- (NSArray<NSNumber *> *)intByteList;

@end

NS_ASSUME_NONNULL_END
