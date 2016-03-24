//
//  Help.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/27.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicMethod.h"

#pragma mark - App Config
//官网
#define kOfficeWebUrl @"http://www.snhm.org.cn/"

//#define kNavSubTitleAttribute  @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:50], NSForegroundColorAttributeName:[UIColor colorWithRed:201.0f/255.0f green:85.0f/255.0f blue:56.0f/255.0f alpha:1.0]}

//工具
#define Color(r,g,b,a) [UIColor colorWithRed:(CGFloat)r/255.0f green:(CGFloat)g/255.0f blue:(CGFloat)b/255.0f alpha:(CGFloat)a]
#define viewCenter(bounds) CGPointMake(bounds.size.width*0.5f, bounds.size.height*0.5f)


#define kScreenWidth 1024

#pragma mark - NavigationBar 
#define kNavButtonItemWidth 25
#define kNavButtonItemHeight 25

//UI
#define kNavBarHeight 64
#define kRightMenuWidth 270


//字体
#define kFontHeitiLight @"STHeitiSC-Light"
#define kFontDidotItalic @"Didot-Italic"

//颜色
///NavgationBar

///淡黑色
#define kColorBlack1 Color(102, 102, 102, 1)
#define kColorGary1 Color(178, 178, 178, 1)
#define kColorGary2 Color(153, 153, 153, 1)
///淡绿色
#define kColorGreen1 Color(142, 227, 220, 1)

///远亲
#define kColorDistant Color(255, 196, 38, 1)
///近邻
#define kColorNeighbour Color(255, 68, 2, 1)

///楼层色
#define kColorL1 Color(141, 107, 47, 1)
#define kColorL2 Color(133, 168, 194, 1)
#define kColorB1 Color(220, 163, 109, 1)
#define kColorB2 Color(101, 173, 58, 1)
#define kColorB2M Color(144, 190, 188, 1)

//Michael
#define Book_Debug

#ifdef DEBUG
#define RequestShowError YES
#else
#define RequestShowError NO
#endif

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define DeviceWidth  ([[UIScreen mainScreen] bounds].size.width)
#define DeviceHeight ([[UIScreen mainScreen] bounds].size.height)

#define iPhone5 (DeviceHeight>480)

#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#ifdef DEBUG
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]

#else

#define DLog(...) do { } while (0)

#ifndef NS_BLOCK_ASSERTIONS
#define NS_BLOCK_ASSERTIONS
#endif
#define ALog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#endif

#define ZAssert(condition, ...) do { if (!(condition)) { ALog(__VA_ARGS__); }} while(0)

#define     VIDEO_PATH  [NSString stringWithFormat:@"%@/Library/Caches/video",NSHomeDirectory()] //video路径
#define ORDERVIEW_THEME_GREEN_COLOR [UIColor colorWithRed:90/255.0 green:125/255.0 blue:62/255.0 alpha:1.0f]
#define LanTingHei @"STHeitiSC-Light"
#define SHOWED_PATH @"SHOWED_PATH"
#define VISITROUTE_THEME_ORANGE_COLOR [UIColor colorWithRed:255/255.0 green:132/255.0 blue:20/255.0 alpha:1.0f]
#define DURATION 0.25f

//错误
#define kBriscErrorDomain @"cn.net.brisc.error"

@interface Help : NSObject

//当前设备方向下的size
+ (CGSize)viewSize:(UIView *)view;
+ (NSDictionary *)navSubTitleAttribute1;
+ (NSDictionary *)navSubTitleAttribute2;
+ (NSDictionary *)floorTitleAttribute1;
+ (NSDictionary *)floorTitleAttribute2;


#pragma mark - iPhone5
#define isIphone5 ([UIScreen mainScreen].bounds.size.height == 568)

#pragma mark - 加密 MD5
+ (NSString *)md5:(NSString*)input;

#pragma mark - Gif
+ (UIImageView *)initWithGifData:(NSData *)gifData;

#pragma mark - 学习单，拼图用
+(UIImage *)questionImageNamed:(NSString *)name;

@end
