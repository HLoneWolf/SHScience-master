//
//  ExhibitItem.m
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/26.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import "ExhibitItem.h"

@implementation ExhibitItem

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self ) {
        self.sid = [aDecoder decodeObjectForKey:@"sid"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.iconPath = [aDecoder decodeObjectForKey:@"iconPath"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.latinName = [aDecoder decodeObjectForKey:@"latinName"];
        self.englishName = [aDecoder decodeObjectForKey:@"englishName"];
        self.popularName = [aDecoder decodeObjectForKey:@"popularName"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
        self.gathering = [aDecoder decodeObjectForKey:@"gathering"];
        self.summary = [aDecoder decodeObjectForKey:@"summary"];
        self.tName = [aDecoder decodeObjectForKey:@"tName"];
        self.sepicmenId = [aDecoder decodeObjectForKey:@"sepicmenId"];
        self.haveStory = [aDecoder decodeBoolForKey:@"haveStory"];
        self.relationRegionId = [aDecoder decodeObjectForKey:@"relationRegionId"];
        self.infoId = [aDecoder decodeObjectForKey:@"infoId"];
        self.region = [aDecoder decodeObjectForKey:@"region"];
        self.catalog = [aDecoder decodeObjectForKey:@"catalog"];
        self.relation = [aDecoder decodeIntForKey:@"relation"];
        self.pics = [aDecoder decodeObjectForKey:@"pics"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sid forKey:@"sid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.iconPath forKey:@"iconPath"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.latinName forKey:@"latinName"];
    [aCoder encodeObject:self.englishName forKey:@"englishName"];
    [aCoder encodeObject:self.popularName forKey:@"popularName"];
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeObject:self.gathering forKey:@"gathering"];
    [aCoder encodeObject:self.summary forKey:@"summary"];
    [aCoder encodeObject:self.tName forKey:@"tName"];
    [aCoder encodeObject:self.sepicmenId forKey:@"sepicmenId"];
    [aCoder encodeBool:self.haveStory forKey:@"haveStory"];
    [aCoder encodeObject:self.relationRegionId forKey:@"relationRegionId"];
    [aCoder encodeObject:self.infoId forKey:@"infoId"];
    [aCoder encodeObject:self.region forKey:@"region"];
    [aCoder encodeObject:self.catalog forKey:@"catalog"];
    [aCoder encodeInt:self.relation forKey:@"relation"];
    [aCoder encodeObject:self.pics forKey:@"pics"];
    [aCoder encodeObject:self.status forKey:@"status"];
}

@end
