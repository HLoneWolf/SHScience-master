//
//  GameRecordItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 15/3/24.
//  Copyright (c) 2015年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameRecordItem : NSObject

///任务ID
@property (nonatomic, strong) NSNumber *sid;
///游戏名称
@property (nonatomic, strong) NSString *title;
///标题图
@property (nonatomic, strong) NSString *iconPic;
///完成时间（秒）
@property (nonatomic, strong) NSNumber *timeCosuming;
///完成日期
@property (nonatomic, strong) NSDate *date;
///最快纪录（秒）
@property (nonatomic, strong) NSNumber *bestRecord;
///当前排名
@property (nonatomic, strong) NSNumber *level;

@end
