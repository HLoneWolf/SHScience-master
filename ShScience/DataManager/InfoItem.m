//
//  PositionItem.m
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/26.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import "InfoItem.h"

@implementation InfoItem

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.sid =  [aDecoder decodeObjectForKey:@"sid"];
        self.floorCode =  [aDecoder decodeObjectForKey:@"floorCode"];
        self.pt =  [aDecoder decodeCGPointForKey:@"pt"];
        self.title=  [aDecoder decodeObjectForKey:@"title"];
        self.iconPath =  [aDecoder decodeObjectForKey:@"iconPath"];
        self.type =  [aDecoder decodeInt32ForKey:@"type"];
        self.relationId =  [aDecoder decodeObjectForKey:@"relationId"];
        self.gameTaskId =  [aDecoder decodeObjectForKey:@"gameTaskId"];
        self.praise =  [aDecoder decodeObjectForKey:@"praise"];
        self.visit =  [aDecoder decodeBoolForKey :@"visit"];
        self.locationType =  [aDecoder decodeInt32ForKey:@"locationType"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.sid forKey:@"sid"];
    [aCoder encodeObject:self.floorCode forKey:@"floorCode"];
    [aCoder encodeCGPoint:self.pt forKey:@"pt"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.iconPath forKey:@"iconPath"];
    [aCoder encodeInt32:self.type forKey:@"type"];
    [aCoder encodeObject:self.relationId forKey:@"relationId"];
    [aCoder encodeObject:self.gameTaskId forKey:@"gameTaskId"];
    [aCoder encodeObject:self.praise forKey:@"praise"];
    [aCoder encodeBool:self.visit forKey:@"visit"];
    [aCoder encodeInt32:self.locationType forKey:@"locationType"];
}

@end
