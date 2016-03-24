//
//  MessageItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/12/18.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    MessageTypeMessage = 0,         //消息
    MessageTypeAnnounce =1,         //公告
} MessageType;

@interface MessageItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) MessageType messageType;

@end
