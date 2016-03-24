//
//  TourItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/12/11.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoItem.h"

@interface TourItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, assign) InfoType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconPath;
@property (nonatomic, strong) NSString *time;

@end
