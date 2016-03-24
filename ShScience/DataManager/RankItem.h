//
//  RankItem.h
//  NaturalMuseumiPhone
//
//  Created by Michael Lu on 15/6/6.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSNumber *ranking;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, copy) NSString *usedTime;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isMyRank;

@end
