//
//  DataManager.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/22.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

typedef enum
{
    OrderTypeFilm,           //电影
    OrderTypeActivity,       //活动
} OrderType;
#import "LXDataManager.h"
@class User;
@class SystemItem;
@class SpecimenItem;
@class InfoItem;
@class RemoteVideoItem;
@class OrderItem;
@class ScheduleItem;
@class ExhibitItem;
@class ExhibitGroupItem;
@class FilmItem;
@class ActivityItem;
@class GameThemeItem;
@class GameTaskItem;
@class RecommendRouteItem;
@class CustomRouteItem;
@class Game;
@class SystemInfoItem;

@class PageItem;
@class PostItem;
@class InterestGroupItem;
@class ExpertSubjectItem;

@class QuestionItem;
@class LearnBookItem;
@class RankItem;

@class VersionItem;
#import "CommentItem.h"
#import "PostItem.h"
#import "LocateItem.h"
//#import "ComplainCatalogList.h"
#import <GCDAsyncUdpSocket.h>
#import <GCDAsyncSocket.h>
#import "RoomDetailItem.h"

#pragma mark - Constant
//#define kServerAddress @"http://211.144.107.201:9090/"
//comment by dsy #define kServerInsideAddress @"http://10.2.64.9:8080/"
//#define kServerInsideAddress @"http://211.144.107.201:9090/"
#define kServerAddress @"http://www.snhm.org.cn:6060/science/"
#define kServerInsideAddress @"http://www.snhm.org.cn:6060/science/"
//
#define kUser @"User"
///当前进行的游戏
#define kGameTask @"GameTask"
#define kCraftInfos @"CraftInfos"

//展品零距离最后搜索关键字
#define kVisualSearchExhibitItem @"kVisualSearchExhibitItem"


@interface DataManager : LXDataManager <GCDAsyncUdpSocketDelegate>

///外网地址(测试用）
@property (nonatomic, strong) NSString *wanAddress;
///当前服务器地址（馆内、馆外）
@property (nonatomic, strong) NSString *serverAddress;
///定位数据接收
@property (nonatomic, strong) GCDAsyncUdpSocket *udpSocket;
///最后收到定位时间
@property (nonatomic, strong) NSDate *lastInMuseumDate;

+ (DataManager *)shareDataManager;

#pragma mark - Setting
+ (void)registerDefaultsFromSettingsBundle;

#pragma mark - 用户管理
#pragma mark 1.1 登入
+ (DataRequest *)loginWithUser:(User *)user callback:(void (^)(User *user, BOOL success))callback;

#pragma mark  1.2修改会员密码
+ (DataRequest *)changePasswordWithUser:(User *)user newPassword:(NSString *)newPassword callback:(void (^)(BOOL update, BOOL success))callback;

#pragma mark 1.3 用户注册
+ (DataRequest *)registWithUser:(User *)user callback:(void (^)(BOOL registed, BOOL success))callback;

#pragma mark 1.4 修改会员信息
+ (DataRequest *)updateUserInfo:(User *)user callback:(void (^)(BOOL update, BOOL success))callback;

#pragma mark 1.5找回密码
+ (DataRequest *)findPasswordWithUser:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 获取已登录用户信息
/**获取已登录用户信息
 *没有登录返回nil
 */
+ (User *)getUser;

#pragma mark 系统管理获取浏览痕迹、我的路线、我的消息
+ (DataQueue *)loadMySystemInfoWithUser:(User *)user callback:(void (^)(SystemInfoItem *systemInfoItem, BOOL success))callback;

#pragma mark - 系统参数
#pragma mark 2.1 系统资源根目录
+ (void)loadSystem:(void (^)(SystemItem *systemItem, BOOL success))callback;

#pragma mark - 可视化搜索
#pragma mark 3.1 关键字
+ (DataRequest *)loadExhibitWithKeyword:(NSString *)keyword callback:(void (^)(NSArray *exhibits, BOOL success))callback;

#pragma mark 3.2关系
+ (DataRequest *)loadRelationWithExhibit:(ExhibitItem *)exhibitItem callback:(void (^)(NSArray *exhibits, BOOL success))callback;

#pragma mark 3.3 展品详细信息
+ (DataRequest *)loadExhibitDetailWithExhibit:(ExhibitItem *)exhibitItem callback:(void (^)(ExhibitItem *exhibitItem, BOOL success))callback;

#pragma mark 3.4 标本背后的故事
+ (DataRequest *)loadSpecimenWithSpecimenId:(NSNumber *)specimenId callback:(void (^)(SpecimenItem *specimenItem, BOOL success))callback;

#pragma mark 获取标本写真
+ (DataRequest *)loadSpecimenPortraitsWithSpecimenId:(NSNumber *)specimenId callback:(void (^)(NSArray *exhibits, BOOL success))callback;

#pragma mark 3.5 展品位置
+ (void)loadExhibitPositionWithExhibit:(ExhibitItem *)exhibitItem callback:(void (^)(InfoItem *infoItem, BOOL success))callback;

#pragma mark 3.6 获取精品展品所包含的列表
+ (DataRequest *)loadExhibitsWithInfoItem:(InfoItem *)infoItem callback:(void (^)(NSArray *exhibits, BOOL success))callback;

#pragma mark 3.7 获取精品展品详细信息
+ (DataRequest *)loadExhibitGroupWithInfoItem:(InfoItem *)infoItem callback:(void (^)(ExhibitGroupItem *groupItem, BOOL success))callback;

#pragma mark - 行程
#pragma mark 4.1 存储用户行程
+ (DataRequest *)postTourWithInfoItem:(InfoItem *)infoItem callback:(void (^)(BOOL posted, BOOL success))callback;
#pragma mark 4.2 获取用户行程
+ (DataRequest *)loadTourWithDate:(NSDate *)date user:(User *)user callback:(void (^)(NSArray *tours, BOOL success))callback;


#pragma mark - 电子地图
#pragma mark 5.1 获取楼层信息点信息
+ (DataRequest *)loadPointInfoWithUser:(User *)user floor:(NSInteger)floor callback:(void (^)(NSArray *infos, BOOL success))callback;

#pragma mark 5.2 获取信息点的地图所在位置
+ (DataRequest *)loadPointInfoWithInfoItem:(InfoItem *)infoItem callback:(void (^)(InfoItem *infoItem, BOOL success))callback;

#pragma mark 5.3 获取远程视频详细信息
+ (DataRequest *)loadRemoteVideoWithInfo:(InfoItem *)infoItem callback:(void (^)(RemoteVideoItem *remoteVideoItem, BOOL success))callback;

#pragma mark 5.4 信息点点赞
+ (DataRequest *)postPraiseWithInfoItem:(InfoItem *)infoItem callback:(void (^)(NSNumber *praiseNum, BOOL success))callback;

#pragma mark - 5.5 获取信息点点赞数量
+ (DataRequest *)loadPraiseWithInfoItem:(InfoItem *)infoItem callback:(void (^)(NSNumber *praiseNum, BOOL success))callback;


//TODO: 需需要测试
#pragma mark 5.6 获取展区信息

//TODO: 后台缺少 udpPath 暂时不做
#pragma mark 5.7 展区拥挤度

#pragma mark 获取信息点展品详细信息
+ (DataRequest *)loadExhibitDetailWithInfo:(InfoItem *)infoItem callback:(void (^)(ExhibitItem *exhibitItem, BOOL success))callback;

#pragma mark 获取标本背后详细信息
+ (void)loadSpecimenDetailWithInfo:(InfoItem *)infoItem callback:(void (^)(SpecimenItem *specimenItem, BOOL success))callback;


//#pragma mark 获取展区信息
//+ (void)loadAreas:(void (^)(NSArray *areas, BOOL success))callback;

//#pragma mark - 评论
//#pragma mark 获取评论
//+ (void)loadCommnetsWithUser:(User *)user type:(CommentType)commentType callback:(void (^)(NSArray *comments, BOOL success))callback;

#pragma mark - 预约
#pragma mark 获取受众类型
+ (DataRequest *)loadPersonTypes:(void (^)(NSDictionary *personDic, BOOL success))callback;

#pragma mark 电影列表 Deprecated on 2015-4-16
//+ (DataRequest *)loadFilmsWithPersonType:(NSString *)personType user:(User *)user callback:(void (^)(NSArray *films, BOOL success))callback;

#pragma mark 活动列表 Deprecated on 2015-4-16
//+ (DataRequest *)loadActivitesWithPersonType:(NSString *)personType user:(User *)user callback:(void (^)(NSArray *activities, BOOL success))callback;

#pragma mark 获取电影或活动列表 2015-4-16新增
//时间仓促，暂时没做分页，countOfOnePage传大值
+ (DataRequest *)loadFilmsOrActivitysForType:(OrderType)type currentpage:(NSInteger)page countOfOnePage:(NSInteger)count date:(NSDate *)date callback:(void (^)(NSArray *filmsOrActivitys, BOOL success))callback;


#pragma mark 查询活动或影片安排的信息
+ (DataRequest *)newLoadSchedulesWithItem:(NSObject *)item date:(NSDate *)date callback:(void (^)(NSArray *schudules, BOOL success))callback;
#pragma mark Deprecated on 2015-4-16
//+ (DataRequest *)loadSchedulesWithItem:(NSObject *)item user:(User *)user callback:(void (^)(NSArray *schudules, BOOL success))callback;

#pragma mark 在线预约
+ (DataRequest *)loadPreorderWithScheduleItem:(ScheduleItem *)scheduleItem user:(User *)user num:(NSNumber *)num playDate:(NSDate *)date callback:(void (^)(NSString *code, BOOL success))callback;

#pragma mark 获取电影的详细信息 2015-4-16新增
+ (DataRequest *)loadFilmDetailWithScheduleItemID:(NSNumber *)itemid callback:(void (^)(FilmItem *filmItem, BOOL success))callback;
#pragma mark 获取活动的详细信息 2015-4-16新增
+ (DataRequest *)loadActivityDetailWithScheduleItemID:(NSNumber *)itemid callback:(void (^)(ActivityItem *activityItem, BOOL success))callback;

#pragma mark 获取我的预约列表
+ (DataRequest *)loadAppointmentWithUser:(User *)user callback:(void (^)(NSArray *orders, BOOL success))callback;

#pragma mark 获取电影预约明细 Deprecated on 2015-4-16
//+ (DataRequest *)loadFilmWithScheduleItem:(ScheduleItem *)scheduleItem user:(User *)user callback:(void (^)(FilmItem *filmItem, BOOL success))callback;

#pragma mark 获取活动预约明细 Deprecated on 2015-4-16
//+ (DataRequest *)loadActivityWithScheduleItem:(ScheduleItem *)scheduleItem user:(User *)user callback:(void (^)(ActivityItem *activityItem, BOOL success))callback;

#pragma mark 获取信息点的影片或活动信息合集
+ (DataRequest *)loadOrdersWithFloor:(NSInteger)floorCode callback:(void (^)(NSArray *orders, BOOL success))callback;

#pragma mark 取消预约
+ (void)postCancelWithOrder:(OrderItem *)orderItem user:(User *)user callback:(void (^)(BOOL success))callback;

#pragma mark 记录浏览数
+ (void)postPreorderBrowseCountWithItem:(NSObject *)orderItem callback:(void (^)(BOOL success))callback;

#pragma mark - 参观路线 （互动社区)
#pragma mark 根据关键字获取展馆资源
+ (DataRequest *)loadRouteWithKeyword:(NSString *)keyword callback:(void (^)(NSArray *infos, BOOL success))callback;

#pragma mark 获取公共设施列表
///根据用户的所在楼层搜索同一楼层的所有公共设施，并按照用户所在位置与公共设施距离由近到远排序。参数x或y坐标为空的情况下视为点击更多查询其他所有楼层的公共设施，不排序
///pt ＝ CGPointZero, x,y 为空
+ (DataRequest *)loadFacilityWithFloor:(FloorType)floor point:(CGPoint)pt callback:(void (^)(NSArray *facilities, BOOL success))callback;

#pragma mark 获取推荐路线
+ (DataRequest *)loadRecommendRoutes:(void (^)(NSArray *routes, BOOL success))callback;

#pragma mark 推荐路线引导点
+ (DataRequest *)loadInfoItemsWithRecommendRoute:(RecommendRouteItem *)recommendRouteItem callback:(void (^)(NSArray *infos, BOOL successs))callback;

#pragma mark 最热门参观路线
+ (DataRequest *)loadPraiseRoute:(void (^)(NSArray *infos, BOOL success))callback;

#pragma mark 最热门参观引导点
+ (DataRequest *)loadPraiseRouteInfoItems:(void (^)(NSArray *infos, BOOL success))callback;

#pragma mark 用户自定义寻路
+ (DataRequest *)loadPathWithFloor:(FloorType)floor point:(CGPoint)point targetInfoItem:(InfoItem *)infoItem callback:(void (^)(NSArray *infos, BOOL success))callback;

#pragma mark 自定义规化路线
+ (DataRequest *)loadCustomRouteWithFloor:(FloorType)floor point:(CGPoint)point routes:(NSArray *)infos callback:(void (^)(NSArray *infos, BOOL success))callback;

#pragma mark 10.9 保存用户自定义路线
+ (void)postCustomRoutes:(NSArray *)infos user:(User *)user routeName:(NSString *)routeName callback:(void (^)(BOOL saved, BOOL success))callback;

#pragma mark 10.10 获取用户保存的自定义路线
+ (DataRequest *)loadUserCustomRouteWithUser:(User *)user callback:(void (^)(NSArray *routes, BOOL success))callback;

#pragma mark 10.11 删除用户自定义路线
+ (void)deleteCustomRoute:(CustomRouteItem *)customRouteItem callback:(void (^)(BOOL deleted, BOOL success))callback;

#pragma mark - 评论
#pragma mark 11.1 获取展品评论列表

#pragma mark 11.2 获取展品评论详细信息
//+ (DataRequest *)loadCommentDetailWithInfoItem:(InfoItem *)infoItem callback:(void (^)(CommentItem *commentItem, BOOL success))callback;

//#pragma mark 11.3 提交展品评论
//+ (DataRequest *)postComment:(CommentItem *)commentItem user:(User *)user callback:(void (^)(BOOL post, BOOL success))callback;

#pragma mark - 互动社区
#pragma mark 大家来吐槽
#pragma mark 提交用户发帖
+ (DataQueue *)postComplain:(PostItem *)postItem callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 提交用户发帖回帖
+ (DataRequest *)replyComplainWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 11.4 提交随手拍发帖
+ (DataQueue *)postTakePhoto:(PostItem *)postItem callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 11.5 提交随手拍回帖
+ (DataRequest *)replyTakephotoWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

//#pragma mark 11.6 获取大家来吐槽 列表
//+ (DataRequest *)loadComplainWithType:(ComplainCatalogType)complainType page:(NSInteger)currentPage pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

+ (DataRequest *)loadComplainWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)currentPage pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 12.1 兴趣小组 查询
+ (DataRequest *)loadInterestGroupWithPage:(NSInteger)currentPage pagesize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem,  BOOL success))callback;

#pragma mark 12.2 兴趣小组 加入
+ (DataRequest *)joinInterestGroup:(InterestGroupItem *)groupItem user:(User*)user callback:(void (^)(BOOL joined, BOOL success))callback;

#pragma mark 12.3 兴趣小组 发帖权限
+ (DataRequest *)loadInterestGroupIsJoinedWithUser:(User *)user group:(InterestGroupItem *)groupItem callback:(void (^)(BOOL joined, BOOL success))callback;

#pragma mark 12.4 兴趣小组 发帖
+ (DataQueue *)postInterestWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 12.5 兴趣小组 回帖
+ (DataRequest *)replyInterestWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 12.6 兴趣小组 投票
+ (DataRequest *)postVoteWithInterestGroup:(InterestGroupItem *)groupItem callback:( void (^)(BOOL voted, BOOL success))callback;

#pragma mark 12.7 兴趣小组 发帖查询
+ (DataRequest *)loadPostsWithInterestGroup:(InterestGroupItem *)groupItem catalog:(PostCatalogType)postCatalogType page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 兴趣小组 搜索指定内容
+ (DataRequest *)loadInterestPostWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 12.8 回帖查询
+ (DataRequest *)loadReplyWithPost:(PostItem *)postItem page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 根据回帖获取主贴
+ (DataRequest *)loadPostWithReply:(PostItem *)reply callback:(void (^)(PostItem *postItem, BOOL success))callback;

#pragma mark 12.11 活动派发帖
+ (DataQueue *)postActivityWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 12.12 活动派回帖
+ (DataRequest *)replyActivityWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 12.13 活动派 发帖查询
+ (DataRequest *)loadActivityPostWithStick:(BOOL)isStick page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 活动派 搜索
+ (DataRequest *)loadActivityPostWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *PageItem, BOOL success))callback;

#pragma mark 12.16 专家来了 发帖
+ (DataQueue *)postExpertWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 12.18 专家来了 回帖
+ (DataRequest *)replyExpertWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 12.19 专家来了 发帖查询
+ (DataRequest *)loadExpertPostWithSubject:(ExpertSubjectItem *)subjectItem catalogType:(PostCatalogType)postCatalogType page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 专家来了 搜索指定
+ (DataRequest *)loadExpertPostWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 专家来了 学科查询
+ (DataRequest *)loadExpertSubject:(void (^)(NSArray *subjects, BOOL succeess))callback;

#pragma mark 专家来了 专家查询
+ (DataRequest *)loadExpertWithSubject:(ExpertSubjectItem *)subjectItem callback:(void (^)(NSArray *experts, BOOL success))callback;

//#pragma mark 12.22 大家来吐槽 发帖查询
//+ (DataRequest *)loadComplainPosts:(void (^)(NSArray *posts, BOOL success))callback;

#pragma mark 12.25 展品评论 详细列表
+ (DataRequest *)loadCommentWithInfoItem:(InfoItem *)infoItem page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 12.26 兴趣小组 退出
+ (DataRequest *)quitInterestGroup:(InterestGroupItem *)groupItem user:(User *)user callback:(void (^)(BOOL quited, BOOL success))callback;

#pragma mark 12.26 大家来吐槽 展品评论 提交
+ (DataRequest *)postCommentWithInfoItem:(InfoItem *)infoItem user:(User *)user postItem:(PostItem *)postItem callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 我的帖子
+ (DataRequest *)loadPostWithUser:(User *)user page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 我的回帖
+ (DataRequest *)loadReplyWithUser:(User *)user page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark 展品评论查询
+ (DataRequest *)loadCommentWithUser:(User *)user callback:(void (^)(PageItem *pageItem, BOOL success))callback;

#pragma mark - 删除发帖
+ (DataRequest *)deleteWithPostItem:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL deleted, BOOL success))callback;

#pragma mark - 删除回帖
+ (DataRequest *)deleteReplyWithPostItem:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL deleted, BOOL success))callback;

#pragma mark 记录帖子浏览数
+ (DataRequest *)postBrowseWithPost:(PostItem *)postItem callback:(void (^)(BOOL success, BOOL posted))callback;

#pragma mark 帖子点赞
+ (DataRequest *)postPriaseWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL praised, BOOL success))callback;

#pragma mark 最佳回帖
+ (DataRequest *)loadBestReplyWithPost:(PostItem *)postItem callback:(void (^)(PostItem *postItem, BOOL success))callback;


#pragma mark - 寻宝游戏
#pragma mark 6.1 查询所有游戏主题
+ (DataRequest *)loadGameThemes:(void (^)(NSArray *themes, BOOL success))callback;

#pragma mark 6.2 游戏任务列表
+ (DataRequest *)loadGameTasksWithTheme:(GameThemeItem *)themeItem user:(User *)user callback:(void (^)(NSArray *gameTasks, BOOL success))callback;

#pragma mark 游戏任务相关展品的信息点
+ (DataRequest *)loadExhibitsWithGameTheme:(GameThemeItem *)themeItem callback:(void (^)(NSArray *infos, BOOL success))callback;

#pragma mark 游戏开始
+ (DataRequest *)postGameStart:(GameTaskItem *)taskItem user:(User *)user callback:(void (^)(BOOL start, BOOL success))callback;

#pragma mark Game Check
+ (DataRequest *)loadCheckWithGameTask:(GameTaskItem *)taskItem user:(User *)user infoItem:(InfoItem *)infoItem callback:(void (^)(BOOL found, BOOL success))callback;

#pragma mark 游戏统计
+ (DataRequest *)loadGameStatisticalWithUser:(User *)user callback:(void (^)(NSArray *records, BOOL success))callback;

#pragma mark 保存当前游戏任务
+ (void)saveGame:(Game *)game;

#pragma mark 获取当前游戏任务
+ (Game *)getGame;

#pragma mark - 消息中心
+ (DataRequest *)loadMessageWithLocateItem:(LocateItem *)locateItem callback:(void (^)(NSArray *messages, BOOL success))callback;

#pragma mark - 图片
#pragma mark  图片下载
+ (DataRequest *)loadPicWithPath:(NSString *)picPath callback:(void (^)(UIImage *image, BOOL success))callback;

#pragma mark 批量下载
+ (DataQueue *)loadPicsWithPaths:(NSArray *)picPaths callback:(void (^)(NSArray *images,  BOOL success))callback;
#pragma mark 图片尺寸信息
+ (void)loadPicsWithPosts:(NSArray *)posts callback:(void (^)(NSArray *imageInfo, BOOL success))callback;

#pragma mark - 定位
+ (void)startLocate:(void (^)(NSString *result, BOOL success))callback;
+ (void)stopLocate;

//#pragma mark - 场内 场外切换
//+ (void)serverAddress;

#pragma mark - 图片批量上传
+ (DataQueue *)postPics:(NSArray *)images callback:(void (^)(NSArray *picPaths, BOOL success))callback;
#pragma mark 图片上传
+ (DataRequest *)postPic:(UIImage *)image callback:(void (^)(NSString *picPath, BOOL success))callback;

#pragma mark - 图片完整路径
+ (NSString *)getImageURLWithPath:(NSString *)path;

#pragma mark - 视屏完整路径
+ (NSString *)getMovieURLWithPath:(NSString *)path;

#pragma mark - 社交分享
+ (void)shareWithTitle:(NSString *)title content:(NSString *)content picPath:(NSString *)picPath inView:(UIView *)sender;

#pragma mark - 预约的本地通知
#pragma mark 初始化预约通知
+(void)cancelOrderNotificationForItem:(OrderItem *)item;
+(void)cancelAllOrderNotifications;
+ (void)initOrderLocalNotification;

#pragma mark - 灭绝记录
+ (DataRequest *)loadExtinctions:(void (^)(NSArray *extinctions, BOOL success))callback;

#pragma mark - 版本更新
+ (DataRequest *)versionUpdate:(void (^)(VersionItem *versionItem, BOOL success))callback;



#pragma mark - 学习单
#pragma mark 获取电子学习单展区列表
+(DataRequest *)loadLearnBookItemsWithUser:(User *)user callback:(void (^)(NSArray *learnBookItems, BOOL success))callback;

#pragma mark 获取单个展区的10个题目
+(DataRequest *)loadQuestionItemsForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(NSArray *questionItems, BOOL success))callback;

#pragma mark 获取单个展区的10个题目的耗时和分数
+(DataRequest *)loadScoreAndTimeForLearnBookID:(NSNumber *)learnBookID questionItems:(NSArray *)items user:(User *)user callback:(void (^)(NSArray *questionItems, BOOL success))callback;

#pragma mark 获取单个或所有学习单的总分数与总时间(所有学习单的没有测试过)
//没有提交完成测试，也就是10道题没有答完，不能调用这个，会报错
+(DataRequest *)loadScoreAndTimeForLearnBookItems:(NSArray *)lItems  user:(User *)user callback:(void (^)(NSArray *learnBookItems, BOOL success))callback;

#pragma mark 提交单个问题
+ (DataRequest *)postUserAnswerForQuestionItem:(QuestionItem *)item user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 完成学习单
+ (DataRequest *)postFinishAllQuestionsForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback;

#pragma mark 获取学习单排行榜
+ (DataRequest *)loadAllRankItemsForLearnBookID:(NSNumber *)learnBookID callback:(void (^)(NSArray *rankItems, BOOL success))callback;

#pragma mark 获取我的排行榜信息
+ (DataRequest *)loadMyRankItemForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(RankItem *rankItem, BOOL success))callback;

#pragma mark 获取已经排序了的包含我的信息的学习单排行榜(iPhone5最多取19条数据，iPhone4:)
+(DataQueue *)loadAllRankInfoForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(NSArray *sortedRankItems, NSArray *learnBookItems, BOOL success))callback;

//dsy add

//首页左边的旋转图
+(DataRequest *) getInfoLeftMainPageWithUserId:(NSString *)userId mac:(NSString *)user callback:(void (^)(NSArray *rankItems, BOOL success))callback;
//问卷调查
+ (DataRequest *)accountsNaire:(NSString *)userId mac:(NSString *)mac origin:(NSString *) origin age:(NSString *)age gender:(NSString *)gender interest:(NSString *)interest callback:(void (^)(BOOL registed, BOOL success))callback;

+(DataRequest *) getZhanquRoomDetailWithId:(NSString *)rooomId callback:(void (^)(RoomDetailItem *items, BOOL success))callback;

+(DataRequest *) getZhanquRoomList:(NSString *)everthing callback:(void (^)(NSArray *items, BOOL success))callback;

+(DataRequest *) getZhanquRoomRelationList:(NSString *)zhanquId  type:(NSString *)type callback:(void (^)(NSArray *items, BOOL success))callback;

@end
