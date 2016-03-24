//
//  SystemInfoItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/12/12.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PageItem;

///系统管理下的 浏览痕迹、我的路线、我的提问
@interface SystemInfoItem : NSObject

@property (nonatomic, strong) NSArray *tours;
@property (nonatomic, strong) NSArray *routes;
@property (nonatomic, strong) NSArray *orders;
///我的发帖
@property (nonatomic, strong) PageItem *postPageItem;
///我的回帖
@property (nonatomic, strong) PageItem *replyPageItem;
///我的提问
@property (nonatomic, strong) PageItem *questionPageItem;
///我的游戏
@property (nonatomic, strong) NSArray *games;
@end
