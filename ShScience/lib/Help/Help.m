//
//  Help.m
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/27.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import "Help.h"
#import <CommonCrypto/CommonCrypto.h>
#import <ImageIO/ImageIO.h>

@implementation Help

+ (NSDictionary *)navSubTitleAttribute1
{
    return @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:20], NSForegroundColorAttributeName:Color(201.0f, 85.0f, 56.0f, 1.0f)};
}

+ (NSDictionary *)navSubTitleAttribute2
{
    return @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20], NSForegroundColorAttributeName:Color(201.0f, 85.0f, 56.0f, 1.0f)};
}


#pragma mark - 楼层切换按钮
+ (NSDictionary *)floorTitleAttribute1
{
    return @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:18], NSForegroundColorAttributeName:Color(201.0f, 85.0f, 56.0f, 1.0f)};
}

+ (NSDictionary *)floorTitleAttribute2
{
    return @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18], NSForegroundColorAttributeName:Color(201.0f, 85.0f, 56.0f, 1.0f)};
}


//
+ (CGSize)viewSize:(UIView *)view
{
    return CGSizeMake(view.bounds.size.width, view.bounds.size.height-20);
  
}

#pragma mark - 加密 MD5
+ (NSString *)md5:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (unsigned int)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    
    return  ret;
}

#pragma mark - Gif
+ (UIImageView *)initWithGifData:(NSData *)gifData
{
    NSMutableArray *frames = nil;
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)gifData, NULL);
    double total = 0;
    NSTimeInterval gifAnimationDuration;
    
    
    UIImageView *imageView = nil;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        if (l > 1){
            frames = [NSMutableArray arrayWithCapacity: l];
            for (size_t i = 0; i < l; i++) {
                CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
                NSDictionary *dict = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, 0, NULL));
                if (dict){
                    NSDictionary *tmpdict = [dict objectForKey: @"{GIF}"];
                    total += [[tmpdict objectForKey: @"DelayTime"] doubleValue] * 100;
                    
                }
                if (img) {
                    [frames addObject: [UIImage imageWithCGImage: img]];
                    CGImageRelease(img);
                }
            }
            gifAnimationDuration = total / 100;
            
            imageView = [[UIImageView alloc] init];
            imageView.animationImages = frames;
            imageView.animationDuration = gifAnimationDuration;
            [imageView startAnimating];
        }
    }
    
    CFRelease(src);
    return imageView;
    
}

+(UIImage *)questionImageNamed:(NSString *)name {
    if (iPhone5) {
        NSArray *array = [name componentsSeparatedByString:@"."];
        if (array.count==2) {
            return [UIImage imageNamed:[NSString stringWithFormat:@"%@-667h.%@",array[0],array[1]]];
        } else {
            return [UIImage imageNamed:[NSString stringWithFormat:@"%@-667h",name]];
        }
    } else {
        return [UIImage imageNamed:[NSString stringWithFormat:@"%@",name]];
    }
}

@end
