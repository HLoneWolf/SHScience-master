//
//  VersionItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 15/4/19.
//  Copyright (c) 2015年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionItem : NSObject

///更新内容提示
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *versionShort;
@property (nonatomic, strong) NSString *updateURL;

@end
