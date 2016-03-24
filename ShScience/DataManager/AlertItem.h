//
//  AlertItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 15/3/30.
//  Copyright (c) 2015年 Leon. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    AlertBooking,           //预约
    AlertPost,              //我的发帖
    AlertRelply,            //我的回帖
    AlertMessage,           //系统消息
} AlertType;

///用于首页点击提示按钮后出现的提醒菜单按钮项目
@interface AlertItem : NSObject

@property (nonatomic, assign) AlertType alertType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSNumber *num;

@end
