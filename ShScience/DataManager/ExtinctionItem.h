//
//  ExtinctionItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 15/2/4.
//  Copyright (c) 2015年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExtinctionItem : NSObject

@property (nonatomic, strong) NSNumber *sid;
///灭绝年代
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *enName;
@property (nonatomic, assign) CGPoint pt;
@property (nonatomic, strong) NSString *iconPath;

@end
