//
//  GameTaskItem.m
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 9/11/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import "GameTaskItem.h"

@implementation GameTaskItem

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        self.sid = [aDecoder decodeObjectForKey:@"sid"];
        self.tid = [aDecoder decodeObjectForKey:@"tid"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.prompt = [aDecoder decodeObjectForKey:@"prompt"];
        self.titlePic = [aDecoder decodeObjectForKey:@"titlePic"];
        self.desc = [aDecoder decodeObjectForKey:@"dec"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        self.status = [aDecoder decodeBoolForKey:@"status"];
                       
        self.blurImage = [aDecoder decodeObjectForKey:@"blurImage"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sid forKey:@"sid"];
    [aCoder encodeObject:self.tid forKey:@"tid"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.prompt forKey:@"prompt"];
    [aCoder encodeObject:self.titlePic forKey:@"titlePic"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.score forKey:@"score"];
    [aCoder encodeBool:self.status forKey:@"status"];
    
    [aCoder encodeObject:self.blurImage forKey:@"blurImage"];
}

@end
