//
//  QyUtils.m
//  ShScience
//
//  Created by qiya on 16/1/4第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "QyUtils.h"
#import "CRToast.h"
#import "Constant.h"
#import "KeychainItemWrapper.h"

@implementation QyUtils

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
  return [UIColor colorWithRed:red / 255.0f
                         green:green / 255.0f
                          blue:blue / 255.0f
                         alpha:1.0f];
}

#pragma mark - 本地保存信息
//将信息写入本地
+(void)setDefaultValue:(NSString *)value WithKey:(NSString *)keyName{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:keyName];
    [defaults synchronize];
}
//从本地获取信息
+(NSString *)getDefaultValue:(NSString *)keyName{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:keyName];
}
//删除对应关键字内容
+(void)delDefaultValue:(NSString *)keyName{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"删除前的内容：%@",[defaults objectForKey:keyName]);
    [defaults removeObjectForKey:keyName];
    [defaults synchronize];
    
    NSLog(@"删除后：%@",[defaults objectForKey:keyName]);
}

//将信息写入本地
+(void)setDefaultValueObject:(NSObject *)value WithKey:(NSString *)keyName{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:keyName];
    [defaults synchronize];
}
//从本地获取信息
+(NSObject *)getDefaultValueObject:(NSString *)keyName{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:keyName];
}
//删除对应关键字内容
+(void)delDefaultValueObject:(NSString *)keyName{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"删除前的内容：%@",[defaults objectForKey:keyName]);
    [defaults removeObjectForKey:keyName];
    [defaults synchronize];
    
    NSLog(@"删除后：%@",[defaults objectForKey:keyName]);
}

#pragma mark 信号栏信息提示
//信号栏提示信息
+(void) navbarInfoToast:(NSString*) text{
    NSDictionary *options = @{
                              kCRToastTextKey : @"手机号码不能为空",
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : NAV_BAR_COLOR,
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight)
                              };
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    NSLog(@"Completed");
                                }];

}


//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date foramtStr:(NSString *)formatStr
{
    //获取系统当前时间
    NSDate *currentDate = date;
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:formatStr];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//今天的日期-字符串形式
+ (NSString *)TodayStrFromDate{
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}


+ (NSDate *)dateFromString:(NSString *)string foramtStr:(NSString *)formatStr
{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    //[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:formatStr];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}


+ (NSString *)getGenerateMAC
{

    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
    NSString *uuidString = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
    
    //没有uuid, 第一次生成
    if ([uuidString isEqualToString:@""] || uuidString == nil) {
        [wrapper setObject:[[NSUUID UUID] UUIDString] forKey:(__bridge id)kSecAttrAccount];
        uuidString = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
    }
    //
    return  uuidString;
    
}

//根据一个中心节点计算一个正方形的4个点的坐标
+(NSString *) getRectAllPointStrFormat:(NSValue *) point width:(CGFloat)width {
    
    CGFloat xSize = 0.5*width;
    CGFloat ySize = 0.5*width;
    CGPoint centerPoint = [point CGPointValue];
    NSString *strList = [NSString stringWithFormat:@"%f,%f",centerPoint.x-xSize,centerPoint.y-ySize];
    strList = [strList stringByAppendingFormat:@",%f,%f",centerPoint.x+xSize,centerPoint.y-ySize];
    strList = [strList stringByAppendingFormat:@",%f,%f",centerPoint.x+xSize,centerPoint.y+ySize];
   strList = [strList stringByAppendingFormat:@",%f,%f",centerPoint.x-xSize,centerPoint.y+ySize];
    
    return strList;
}



+ (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    return html;
    
}
@end
