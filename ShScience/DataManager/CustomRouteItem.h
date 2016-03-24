//
//  CustomRouteItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/10/17.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RouteItem;

@interface CustomRouteItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *createDate;

///由RouteItem 构成
@property (nonatomic, strong) NSArray *routes;


@end
