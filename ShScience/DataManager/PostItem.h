

//
//  PostItem.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/10/27.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class User;
@class ExpertSubjectItem;
@class ExpertItem;

///发帖的类型
typedef enum {
    PostUnkown = 0,             //未知发帖类型
    PostInterestGroup = 1,      //兴趣小组
    PostActivity = 2,           //活动
    PostExpert = 3,             //专家来了
    PostComplain = 4,           //吐槽（改为随手拍了）
    PostComment = 5,            //展品评论
    PostCommentMagic = 55,      //来源于我回复的帖子里获取的 展品评论 T_T(神奇的后台接口！！！）
    PostPost = 6,               //用户发帖
} PostType;


///发贴的查询类型
typedef enum {
    PostCatalogAll = 0,
    PostCatalogStick = 1,              //置顶
    PostCatalogEssence = 2,            //精华
    PostCatalogHot = 3,                //热门
} PostCatalogType;

///帖子来源
typedef enum
{
    PostSourceInterest = 1,             //兴趣小组
    PostSourceActivity = 2,             //活动派
    PostSourceExpert = 3,               //专家来了
    PostSourceTakePhoto = 4,            //随手拍
    PostSourceComment = 5,              //展品评论
    PostSourePost = 6,                  //用户发帖
} PostSourceType;

///帖子评论的类型
typedef enum
{
    PostEntitySpecimen = 0,             //标本
    PostEntityExhibit = 1,              //展品
    PostEntityPortraits = 22,           //标本写真
} PostEntityType;

///帖子回复类型
typedef enum
{
    PostReplyExpert = 1,                //专家回帖
    PostReplyBest = 2,                  //最佳答案
} PostReplyType;

//#import "PostViewController.h"
///帖子
@interface PostItem : NSObject

///后台用来表示作为发帖时的id
@property (nonatomic, strong) NSNumber *sid;
///后台用来表示作为回复时的id
@property (nonatomic, strong) NSNumber *rid;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *content;
///提交回复， 回复的内容 （没有设计好其实可以用content代替...)
@property (nonatomic, strong) NSString *replyContent;
@property (nonatomic, strong) NSArray *picPaths;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSNumber *browseNum;
@property (nonatomic, strong) NSNumber *praiseNum;
@property (nonatomic, assign) BOOL isEssence;
@property (nonatomic, assign) BOOL isHot;

///最佳回复
@property (nonatomic, assign) PostReplyType replyType;

/**专家来了
 @brief 仅在发帖到专家来了，才会使用
 **/
@property (nonatomic, strong) ExpertSubjectItem *subjectItem;
@property (nonatomic, strong) ExpertItem *expertItem;

///积分
@property (nonatomic, strong) NSNumber *score;

///回复相关
///
@property (nonatomic, strong) NSNumber *replyTotal;
///最后回复人
@property (nonatomic, strong) User *replyUser;
///最后回复时间
@property (nonatomic, strong) NSDate *replyDate;

//图片数据
@property (nonatomic, strong) NSArray *images;
//第一张图片的尺寸
@property (nonatomic, assign) CGSize imageSize;

/**帖子所属的组
 @brief 可以是兴趣小组的id, InterestGroupItem.sid
 **/
@property (nonatomic, strong) NSNumber *typeId;

///帖子所属的组，因该和上面的typeId统一
@property (nonatomic, assign) PostType postType;

///帖子来源类型
@property (nonatomic, assign) PostSourceType postSourceType;

///评论对象类型
@property (nonatomic, assign) PostEntityType postEntityType;

///评论对象id
@property (nonatomic, strong) NSNumber *postEntityId;

///专家列表
@property (nonatomic, strong) NSMutableArray *experts;

@end
