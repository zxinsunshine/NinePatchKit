//
//  NPPngNptcChunkModel.h
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NinePatchCompatibility.h"
#import "NPPngChunkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NPPngNptcChunkModel : NPPngChunkModel

@property (nonatomic, assign, readonly) EdgeStruct padding;
@property (nonatomic, strong, readonly) NSArray<NSNumber *> * divX;
@property (nonatomic, strong, readonly) NSArray<NSNumber *> * divY;
@property (nonatomic, strong, readonly) NSArray<NSNumber *> * colors;



@end

NS_ASSUME_NONNULL_END
