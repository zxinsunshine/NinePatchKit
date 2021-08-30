//
//  NPPngChunkModel.m
//  Test
//
//  Created by Theo on 2021/7/9.
//

#import "NPPngChunkModel.h"
#import "NSData+BytesUtils.h"
#import <zlib.h>

static const NSInteger kChunkDataLengthBytesLen = 4; // Length header length
static const NSInteger kChunkTypeBytesLen = 4; // Type header length
static const NSInteger kChunkCrcBytesLen = 4; // CRC header length

@interface NPPngChunkModel()

@property (nonatomic, assign, readwrite) NSInteger totalLength;
@property (nonatomic, strong, readwrite) NSData * totalData;

@property (nonatomic, assign, readwrite) NSInteger chunkDataLength;
@property (nonatomic, copy, readwrite) NSString * chunkTypeCode;
@property (nonatomic, strong, readwrite) NSData * chunkData;
@property (nonatomic, assign, readwrite) NSInteger crcCode;

@end

@implementation NPPngChunkModel

- (instancetype)initWithData:(NSData *)data beginIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        NSInteger dataLen = data.length;
        
        NSRange lenRange = NSMakeRange(index, kChunkDataLengthBytesLen);
        NSString * lenHexStr = [data np_hexStrWithRange:lenRange];
        // length of chunk data
        self.chunkDataLength = strtoul([lenHexStr UTF8String], 0, 16);
        // type code
        self.chunkTypeCode = [NPPngChunkModel codeTypeWithData:data beginIndex:index];
        // chunk data
        NSInteger dataBeginIndex = index + kChunkDataLengthBytesLen + kChunkTypeBytesLen;
        if (self.chunkDataLength > 0 && dataBeginIndex + self.chunkDataLength <= dataLen) {
            self.chunkData = [data subdataWithRange:NSMakeRange(dataBeginIndex, self.chunkDataLength)];
        }
        // CRC
        dataBeginIndex += self.chunkDataLength;
        NSData * crcData = [data subdataWithRange:NSMakeRange(dataBeginIndex, kChunkCrcBytesLen)];
        self.crcCode = strtoul([[crcData np_hexStr] UTF8String], 0, 16);
        
        // total length of chunk
        self.totalLength = kChunkDataLengthBytesLen + kChunkTypeBytesLen + self.chunkDataLength + kChunkCrcBytesLen;
        // total data
        self.totalData = [data subdataWithRange:NSMakeRange(index, self.totalLength)];
    }
    return self;
}

+ (NSInteger)calculateCrcCodeWithTypeAndChunkData:(NSData *)data {
    uLong crc = crc32(0L, Z_NULL, 0);
    crc = crc32(crc, data.bytes, (UnsignedInt)data.length);
    return crc;
}

+ (NSString *)codeTypeWithData:(NSData *)data beginIndex:(NSInteger)index {
    NSRange typeRange = NSMakeRange(index + kChunkDataLengthBytesLen, kChunkTypeBytesLen);
    NSString *asciiString = [[NSString alloc] initWithData:[data subdataWithRange:typeRange] encoding:NSASCIIStringEncoding];
    return asciiString;
}


@end
