//
//  PositionItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/26.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpecimenItem.h"
#import <UIKit/UIKit.h>

typedef enum{
    InfoItemSpecimen,       //标本背后的故事
    InfoItemExhibit,        //展品
    InfoItemRemoteVideo,    //远程视屏
    InfoItemShowroom,       //展区
    InfoItemPublic = 6,     //公共设施
    InfoItemClassroom = 5,  //教室
    InfoItemCinema = 7,     //电影院
    InfoItemGroup = 8,       //精品展品
    InfoItemGame,           //寻宝游戏
    
} InfoType;




@interface InfoItem : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSNumber *floorCode;
@property (nonatomic, assign) CGPoint pt;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *relevanceName;
@property (nonatomic, strong) NSString *iconPath;
@property (nonatomic, assign) InfoType type;
@property (nonatomic, strong) NSNumber *relationId;
///游戏任务ID
@property (nonatomic, strong) NSNumber *gameTaskId;
@property (nonatomic, strong) NSNumber *praise;
@property (nonatomic, assign) BOOL visit;
@property (nonatomic, assign) LocationType locationType;

@end
