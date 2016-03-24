//
//  LocateItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/9/26.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "DataManager.h"


//楼层
typedef enum
{
    Floor3 = 1,                     //地上3层
    Floor2 = 2,                     //地上2层
    Floor1 = 3,     //一层
    FloorUnderGround1 = 4,      //地下一层
    
} FloorType;


///展区
typedef enum
{
    Areaswwx = 11,
    Areadqts,
    Areazhzg,
    Areasjsyl,
    Areachetly,
    Areadwsj,
    AreaShgdkjcl,
    Areadqjy,
    Areaxxsd,
    Areajqrsj,
    Areazzz,
    Areayscl,
    Areatszg,
    Arearyjk,
    Areayhtd,
    Areaytszcl,
} AreaType;

@interface LocateItem : NSObject

@property (nonatomic, assign) CGPoint pt;
@property (nonatomic, assign) BOOL isIn;

@property (nonatomic, assign) FloorType floorType;
///楼层的中文名
@property (nonatomic, strong) NSString *floorName;
///楼层的英文标
@property (nonatomic, strong) NSString *floorMark;

///展区
@property (nonatomic, assign) AreaType areaType;
///展区中文名称
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *areaEnName;
@property (nonatomic, strong) UIImage *areaIcon;

@property (nonatomic, strong) NSString *ip;

@end
