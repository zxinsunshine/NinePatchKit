//
//  NPPngModel.m
//  Test
//
//  Created by Theo on 2021/7/9.
//

#import "NPPngModel.h"
#import "NSData+BytesUtils.h"
#import <objc/runtime.h>

@interface NPPngModel()

@property (nonatomic, strong, readwrite) NSDictionary<NSString *, NPPngChunkModel *> * chunkDict;
@property (nonatomic, strong, readwrite) NSData * pngData;
@property (nonatomic, strong, readwrite) NSDictionary<NSString *, Class> *registerClass;

@end

@implementation NPPngModel

- (instancetype)initWithData:(NSData *)data
{
    return [self initWithData:data registerClass:nil];
}

- (instancetype)initWithData:(NSData *)data registerClass:(nullable NSDictionary<NSString *, Class> *)registerClass; {
    self = [super init];
    if (self) {
        self.pngData = data;
        self.registerClass = registerClass;
        [self analyzeWithData:data];
    }
    return self;
}

+ (BOOL)isPngFile:(NSData * )data {
    NSRange range = NSMakeRange(0, kPngSingnatureLen);
    NSString * headStr = [data np_hexStrWithRange:range];
    return [headStr isEqualToString:@"89504e470d0a1a0a"];
}


#pragma mark - Private Methods
- (void)analyzeWithData:(NSData *)data {
    
    if (![NPPngModel isPngFile:data]) {
        return;
    }
    
    // Png data is composed of file signature(8 bytes) and many chunk datas
    // each chunk is composed of Length(chunk data's length 4 bytes) + Chunk Type Code(4 bytes) + Chunk Data + CRC(Cyclic redundancy detection 4 bytes)
    NSMutableDictionary * chunkDict = [NSMutableDictionary dictionary];
    NSInteger beginIndex = kPngSingnatureLen;
    NSInteger dataLen = data.length;
    while (YES) {
        
        NPPngChunkModel * model = nil;
        NSString * typeCode = [NPPngChunkModel codeTypeWithData:data beginIndex:beginIndex];
        
        Class cls = self.registerClass[typeCode];
        if (cls && [cls isKindOfClass:object_getClass([NPPngChunkModel class])]) {
            model = [[cls alloc] initWithData:data beginIndex:beginIndex];
        } else {
            model = [[NPPngChunkModel alloc] initWithData:data beginIndex:beginIndex];
        }
        
        [chunkDict setObject:model forKey:typeCode];
        beginIndex += model.totalLength;
        if (beginIndex >= dataLen) {
            break;
        }
    }
       
    self.chunkDict = chunkDict;
}

@end
