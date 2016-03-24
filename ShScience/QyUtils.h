//
//  QyUtils.h
//  ShScience
//
//  Created by qiya on 16/1/4第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWitdh [UIScreen mainScreen].applicationFrame.size.width
#define ScreenHeight [UIScreen mainScreen].applicationFrame.size.height
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

@interface QyUtils : UIViewController

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;



+(void)setDefaultValue:(NSString *)value WithKey:(NSString *)keyName;

+(NSString *)getDefaultValue:(NSString *)keyName;

+(void)delDefaultValue:(NSString *)keyName;

+(void)setDefaultValueObject:(NSObject *)value WithKey:(NSString *)keyName;

+(NSObject *)getDefaultValueObject:(NSString *)keyName;

+(void)delDefaultValueObject:(NSString *)keyName;

+(void) navbarInfoToast:(NSString*) text;


+ (NSString *)TodayStrFromDate;

+ (NSString *)stringFromDate:(NSDate *)date foramtStr:(NSString *)formatStr;

+ (NSDate *)dateFromString:(NSString *)string;

+ (NSDate *)dateFromString:(NSString *)string foramtStr:(NSString *)formatStr;



+ (NSString *)getGenerateMAC;

+(NSString *) getRectAllPointStrFormat:(NSValue *) point width:(CGFloat)width;


+ (NSString *)flattenHTML:(NSString *)html;


@end
