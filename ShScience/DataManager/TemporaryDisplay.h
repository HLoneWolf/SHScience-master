//
//  TemporaryDisplay.h
//  ShScience
//
//  Created by qiya on 16/3/9第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemporaryDisplay : NSObject
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *currentpage;
@property (nonatomic, strong) NSNumber *pagesize;
@property NSArray *dataList;



@property (nonatomic, copy) NSString *name;
@end



@interface TemporaryDisplayData : NSObject

@property (nonatomic, strong) NSNumber *dataId;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *exhibitionDate;
@property (nonatomic, strong) NSString *exhibitionEndDate;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *introduction;

@property (nonatomic, strong) NSNumber *roomId;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *audio;

@end