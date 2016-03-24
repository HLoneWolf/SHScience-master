//
//  ExhibitGroupItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/11/8.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InfoItem;
@interface ExhibitGroupItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) InfoItem *infoItem;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *picPath;

@end
