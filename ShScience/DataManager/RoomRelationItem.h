//
//  RoomRelationItem.h
//  ShScience
//
//  Created by qiya on 16/3/7第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomRelationItem : NSObject

@property (nonatomic, strong) NSNumber *relId;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, copy)  NSString *startDate;
@property (nonatomic, copy)  NSString *endDate;


@property (nonatomic, copy)  NSString *keyWord;
@property NSArray *pics;
@property NSArray *personTypes;

@property (nonatomic, copy) NSString *contents;


@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *specificTime;
@property (nonatomic, copy) NSString *activityPrompt;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *scientist;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *audio;


@property (nonatomic, strong) NSNumber *totalParticipants;


@end
