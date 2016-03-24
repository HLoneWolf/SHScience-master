//
//  Game.m
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/10/16.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import "Game.h"

@implementation Game

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self) {
        self.gameTaskItem = [aDecoder decodeObjectForKey:@"gameTaskItem"];
        self.craftInfos = [aDecoder decodeObjectForKey:@"craftInfos"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.gameTaskItem forKey:@"gameTaskItem"];
    [aCoder encodeObject:self.craftInfos forKey:@"craftInfos"];
}

@end
