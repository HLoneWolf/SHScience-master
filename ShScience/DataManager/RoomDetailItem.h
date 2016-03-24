//
//  RoomDetailItem.h
//  ShScience
//
//  Created by qiya on 16/3/7第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomDetailItem : NSObject

@property (nonatomic, strong) NSNumber *detailId;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *summary;


@property (nonatomic, copy) NSString *map;
@property (nonatomic, copy)  NSString *fid;

@property (nonatomic, strong) NSNumber *threshold;


@property (nonatomic, copy)  NSString *titlePic;
@property (nonatomic, copy)  NSString *serviceId;
@property (nonatomic, copy)  NSString *video;
@property (nonatomic, copy)  NSString *audio;
@property (nonatomic, copy)  NSString *englishName;


@property NSArray *pics;

@end
