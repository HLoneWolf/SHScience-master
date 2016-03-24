//
//  Game.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/10/16.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameTaskItem;

@interface Game : NSObject <NSCoding>

@property (nonatomic, strong) GameTaskItem *gameTaskItem;
@property (nonatomic, strong) NSArray *craftInfos;

@end
