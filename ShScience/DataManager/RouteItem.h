//
//  RouteItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/10/17.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoItem.h"

///获取用户保存的自定义规划路线时， 返回项
@interface RouteItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *titlePic;
@property (nonatomic, strong) NSNumber *sequence;
@property (nonatomic, strong) NSNumber *infoId;
@property (nonatomic, assign) InfoType infotype;

@end
