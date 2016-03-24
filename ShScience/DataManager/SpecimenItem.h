//
//  StoryItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/26.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LocationTypeAir = 0,
    LocationTypeGround = 1,
} LocationType;

@interface SpecimenItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconPath;
@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, assign) LocationType locationType;
@property (nonatomic, strong) NSString *lookVideoPath;
@property (nonatomic, strong) NSString *lookARPath;
@property (nonatomic, strong) NSArray *lookPics;
@property (nonatomic, strong) NSArray *studyPics;

@end
