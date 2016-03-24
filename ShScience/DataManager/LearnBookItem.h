//
//  LearnBookItem.h
//  NaturalMuseumiPhone
//
//  Created by Michael Lu on 15/6/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearnBookItem : NSObject

///学习单名称
@property (nonatomic, copy) NSString *name;
///学习单id
@property (nonatomic, strong) NSNumber *sid;
///气泡图
@property (nonatomic, copy) NSString *icon;
///知识点
@property (nonatomic, copy) NSString *knowledge;
///背景图
@property (nonatomic, copy) NSString *bgpic;
///分数
@property (nonatomic, strong) NSNumber *score;
///耗时(秒)
@property (nonatomic, copy) NSString *usedTime;

@end
