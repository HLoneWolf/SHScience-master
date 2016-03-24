//
//  InterestGroupItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/10/27.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  User;

@interface InterestGroupItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, strong) NSNumber *vote;
@property (nonatomic, strong) NSDate *date;

///创建者
@property (nonatomic, strong) User *user;
///回复
///回复人
@property (nonatomic, strong) User *replyUser;
///当前回复数量
@property (nonatomic, strong) NSNumber *replyTotal;
///回复时间
@property (nonatomic, strong) NSDate *replyDate;

@end
