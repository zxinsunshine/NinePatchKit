//
//  NPPngNptcChunkModel.m
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NPPngNptcChunkModel.h"
#import "NSData+BytesUtils.h"

@interface NPPngNptcChunkModel()

@property (nonatomic, assign, readwrite) EdgeStruct padding;
@property (nonatomic, strong, readwrite) NSArray<NSNumber *> * divX;
@property (nonatomic, strong, readwrite) NSArray<NSNumber *> * divY;
@property (nonatomic, strong, readwrite) NSArray<NSNumber *> * colors;

@end

@implementation NPPngNptcChunkModel


- (instancetype)initWithData:(NSData *)data beginIndex:(NSInteger)index
{
    self = [super initWithData:data beginIndex:index];
    if (self) {
        [self analyzeChunk];
    }
    return self;
}


#pragma mark - Private Methods
- (void)analyzeChunk {
    
    if (!self.chunkData) {
        return;
    }
    
    NSData * data = self.chunkData;
    NSInteger byteLen = 0;
    NSInteger beginIndex = 0;
    NSRange lenRange = NSMakeRange(beginIndex, byteLen);
    
    // wasSerialized != 0
    // 1 byte
    // skip
    byteLen = 1;
//    lenRange = NSMakeRange(beginIndex, byteLen);
//    NSLog(@"%@",[data hexStrWithRange:lenRange]);
    
    // mDivX length
    // 1 byte
    beginIndex += byteLen;
    byteLen = 1;
    lenRange = NSMakeRange(beginIndex, byteLen);
    NSString * divXLenHexStr = [data np_hexStrWithRange:lenRange];
    NSInteger divXLen = strtoul([divXLenHexStr UTF8String], 0, 16);
    
    // mDivY length
    // 1 byte
    beginIndex += byteLen;
    byteLen = 1;
    lenRange = NSMakeRange(beginIndex, byteLen);
    NSString * divYLenHexStr = [data np_hexStrWithRange:lenRange];
    NSInteger divYLen = strtoul([divYLenHexStr UTF8String], 0, 16);
    
    // mColor length
    // 1 byte
    beginIndex += byteLen;
    byteLen = 1;
    lenRange = NSMakeRange(beginIndex, byteLen);
    NSString * colorLenHexStr = [data np_hexStrWithRange:lenRange];
    NSInteger colorLen = strtoul([colorLenHexStr UTF8String], 0, 16);
    
    // skip
    // 8 byte
    beginIndex += byteLen;
    byteLen = 8;
//    lenRange = NSMakeRange(beginIndex, byteLen);
//    NSLog(@"%@",[data hexStrWithRange:lenRange]);
    
    // padding left
    // 4 bytes
    beginIndex += byteLen;
    byteLen = 4;
    lenRange = NSMakeRange(beginIndex, byteLen);
    NSString * paddingLeftHexStr = [data np_hexStrWithRange:lenRange];
    NSInteger paddingLeft = strtoul([paddingLeftHexStr UTF8String], 0, 16);
    
    // padding right
    // 4 bytes
    beginIndex += byteLen;
    byteLen = 4;
    lenRange = NSMakeRange(beginIndex, byteLen);
    NSString * paddingRightHexStr = [data np_hexStrWithRange:lenRange];
    NSInteger paddingRight = strtoul([paddingRightHexStr UTF8String], 0, 16);
    
    // padding top
    // 4 bytes
    beginIndex += byteLen;
    byteLen = 4;
    lenRange = NSMakeRange(beginIndex, byteLen);
    NSString * paddingTopHexStr = [data np_hexStrWithRange:lenRange];
    NSInteger paddingTop = strtoul([paddingTopHexStr UTF8String], 0, 16);
    
    // padding bottom
    // 4 bytes
    beginIndex += byteLen;
    byteLen = 4;
    lenRange = NSMakeRange(beginIndex, byteLen);
    NSString * paddingBottomHexStr = [data np_hexStrWithRange:lenRange];
    NSInteger paddingBottom = strtoul([paddingBottomHexStr UTF8String], 0, 16);
    
    // skip
    // 4 byte
    beginIndex += byteLen;
    byteLen = 4;
//    lenRange = NSMakeRange(beginIndex, byteLen);
//    NSLog(@"%@",[data hexStrWithRange:lenRange]);
    
    // divX Array [ S0.start, S0.end, S1.start, S1.end]
    // 4 bytes * divXLen
    NSMutableArray * divXPointList = [NSMutableArray array];
    for (int i = 0; i < divXLen; ++i) {
        beginIndex += byteLen;
        byteLen = 4;
        lenRange = NSMakeRange(beginIndex, byteLen);
        NSString * divXPointHexStr = [data np_hexStrWithRange:lenRange];
        NSInteger divXPoint = strtoul([divXPointHexStr UTF8String], 0, 16);
        [divXPointList addObject:@(divXPoint)];
    }
    
    // divY Array [ S2.start, S2.end, S3.start, S3.end]
    // 4 bytes * divYLen
    NSMutableArray * divYPointList = [NSMutableArray array];
    for (int i = 0; i < divYLen; ++i) {
        beginIndex += byteLen;
        byteLen = 4;
        lenRange = NSMakeRange(beginIndex, byteLen);
        NSString * divYPointHexStr = [data np_hexStrWithRange:lenRange];
        NSInteger divYPoint = strtoul([divYPointHexStr UTF8String], 0, 16);
        [divYPointList addObject:@(divYPoint)];
    }
    
    // color Array
    // 4 bytes * colorLen
    NSMutableArray * colorList = [NSMutableArray array];
    for (int i = 0; i < colorLen; ++i) {
        beginIndex += byteLen;
        byteLen = 4;
        lenRange = NSMakeRange(beginIndex, byteLen);
        NSString * colorHexStr = [data np_hexStrWithRange:lenRange];
        NSInteger colorInt = strtoul([colorHexStr UTF8String], 0, 16);
        [colorList addObject:@(colorInt)];
    }
    
    // analyse finished
    beginIndex += byteLen;
    if (data.length - beginIndex == 0) {
        self.padding = EdgeStructMake(paddingTop, paddingLeft, paddingBottom, paddingRight);
        self.divX = divXPointList;
        self.divY = divYPointList;
        self.colors = colorList;
    }
    
}


@end
