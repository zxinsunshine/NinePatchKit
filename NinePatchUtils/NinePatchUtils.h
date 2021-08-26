//
//  NinePatchUtils.h
//  Test
//
//  Created by Theo on 2021/7/12.
//

#import "NinePatchCompatibility.h"

NS_ASSUME_NONNULL_BEGIN

@interface NinePatchUtils : NSObject

/// Read NinePatchImage from Assets Data
/// @param name  name of image data in Assets Data
+ (ImageClass *)imageNamed:(NSString *)name;

/// Read NinePatchImage from local path
/// @param path local path
+ (ImageClass *)imageWithContentsOfFile:(NSString *)path;

/// Get Inner Padding of Image
/// @param image Image object
+ (EdgeStruct)paddingForImage:(ImageClass *)image;

/// Clear Cache
+ (void)clearCache;

@end

NS_ASSUME_NONNULL_END
