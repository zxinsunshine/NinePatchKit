//
//  NSData+BytesUtils.m
//  Test
//
//  Created by Theo on 2021/7/8.
//

#import "NSData+BytesUtils.h"

@implementation NSData (BytesUtils)

- (NSString *)hexStr {
    return [self hexStrWithRange:NSMakeRange(0, self.length)];
}

- (NSString *)hexStrWithRange:(NSRange)range {
    
    NSString * string = @"";
    NSInteger byteLen = self.length;
    if (!self || byteLen == 0 || range.location < 0 || range.length == 0 || (range.location + range.length > byteLen)) {
        return @"";
    }
    Byte * bytes = (Byte *)self.bytes;
    NSInteger beginIndex = MIN(byteLen - 1, range.location);
    NSInteger endIndex = NSMaxRange(range);
    NSMutableString *mString = [[NSMutableString alloc] initWithCapacity:(endIndex - beginIndex)];
    for (NSInteger i = beginIndex; i < endIndex; ++i) {
        NSString *hexStr = [NSString stringWithFormat:@"%x", (bytes[i]) & 0xff];
        if ([hexStr length] == 2) {
            [mString appendString:hexStr];
        } else {
            [mString appendFormat:@"0%@", hexStr];
        }
    }
    string = mString;
    return string;
}

- (NSArray<NSNumber *> *)intByteList {
    return [self intByteListWithRange:NSMakeRange(0, self.length)];
}

- (NSArray<NSNumber *> *)intByteListWithRange:(NSRange)range {
    
    NSMutableArray *byteList = nil;
    NSInteger byteLen = self.length;
    if (!self || byteLen == 0 || range.location < 0 || range.length == 0 || (range.location + range.length > byteLen)) {
        return nil;
    }
    
    byteList = [NSMutableArray array];
    Byte *bytes = (Byte *)[self bytes];
    NSInteger beginIndex = MIN(byteLen - 1, range.location);
    NSInteger endIndex = NSMaxRange(range);
    for (NSInteger i = beginIndex; i < endIndex; ++i) {
        [byteList addObject:@(bytes[i])];
    }
    return byteList;
}

- (NSArray<NSString *> *)strByteList {
    return [self strByteListWithRange:NSMakeRange(0, self.length)];
}

- (NSArray<NSString *> *)strByteListWithRange:(NSRange)range {
    NSMutableArray *byteList = nil;
    NSInteger byteLen = self.length;
    if (!self || byteLen == 0 || range.location < 0 || range.length == 0 || (range.location + range.length > byteLen)) {
        return nil;
    }
    Byte *bytes = (Byte *)[self bytes];
    byteList = [NSMutableArray array];
    for(int i = 0; i< byteLen; i++) {
        if (i == 0) {
            [byteList addObject:[NSString stringWithFormat:@"%hhu",bytes[i]]];
        }else {
            [byteList addObject:[NSString stringWithFormat:@"%hhu",bytes[i]]];
        }
    }
    return byteList;
}

+ (BOOL)isSmallEndian {
    union w
    {
        int a;// 4 Byte
        char b;// 1 Byte
    } c;
    c.a = 1;
    return(c.b ==1);
}

#pragma mark - Private Methods
- (NSString *)formatedByteStr:(Byte)byte {
    NSString *hexStr = [NSString stringWithFormat:@"%x", (byte) & 0xff];
    if (hexStr.length != 2) {
        hexStr = [NSString stringWithFormat:@"0%@", hexStr];
    }
    return hexStr;
}

@end
