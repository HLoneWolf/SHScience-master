//
//  PageItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/10/27.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageItem : NSObject

@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *currentPage;
///内容 由各个postItem 组成
@property (nonatomic, strong) NSMutableArray *datas;

@end
