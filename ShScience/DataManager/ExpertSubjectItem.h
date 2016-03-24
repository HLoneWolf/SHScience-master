//
//  ExpertSubjectItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/12/3.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertSubjectItem : NSObject

///学科
///对应 后台的key
@property (nonatomic, strong) NSString *key;
///名称 对应 后台的value
@property (nonatomic, strong) NSString *name;

@end
