//
//  DataManager.m
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/22.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import "DataManager.h"
#import "LearnBookItem.h"
#import "QuestionItem.h"
#import "RankItem.h"
#import "Help.h"
#import "User.h"
#import "SystemItem.h"
#import "ExhibitItem.h"
#import "ExhibitGroupItem.h"
#import "SpecimenItem.h"
#import "InfoItem.h"
#import "RemoteVideoItem.h"
#import "OrderItem.h"
#import "FilmItem.h"
#import "ActivityItem.h"
#import "ScheduleItem.h"
#import "GameThemeItem.h"
#import "GameTaskItem.h"
#import "GameRecordItem.h"
#import "Game.h"
#import "RecommendRouteItem.h"
#import "CustomRouteItem.h"
#import "RouteItem.h"
#import "TourItem.h"
#import "SystemInfoItem.h"
#import "JRNLocalNotificationCenter.h"
#import "UIImage+RemoteSize.h"

//帖子
#import "PageItem.h"
#import "InterestGroupItem.h"
#import "ExpertSubjectItem.h"
#import "ExpertItem.h"
//
#import "VersionItem.h"

//消息中心
#import "MessageItem.h"

#import <Reachability.h>
//dsy comment
//#import <ShareSDK/ShareSDK.h>

//灭绝项目
#import "ExtinctionItem.h"
#import "InterestLabelItem.h"
#import "RoomDetailItem.h"
#import "RoomRelationItem.h"

#pragma mark - 配置
//用户管理
#define kRegistPath @"app/museum/accounts/register"
#define kLoginPath @"/app/museum/accounts/login"
#define kChangePasswordPath @"museum/app/museum/accounts"
#define kUpdateUserPath @"museum/app/museum/accounts"
#define kTourPath @"museum/app/museum/accounts"
#define kToursPath @"museum/app/museum/accounts/tours"
#define kFindPasswordPath @"museum/app/museum/accounts"

//dsy 用户问卷调查
#define accounts_naire @"app/museum/accounts/naire"

//系统参数
#define kSystemPath @"museum/app/museum/systems"

//可视化搜索
#define kExhibitKeywordPath @"museum/app/museum/exhibits/searchKeyword"
#define kRelationExhibitPath @"museum/app/museum/exhibits"
#define kExhibitDetailPath @"museum/app/museum/exhibits"
#define kExhibitPositionPath @"museum/app/museum/exhibits"
//标本
#define kSpecimenPath @"museum/app/museum/specimens"

//精品展品组
#define kExhibtGroupPath @"museum/app/museum/exhibits/exhibitGroup"
#define kExhibtGroupApiPath @"museum/api/museum/exhibits/exhibitGroup"

//评论
#define kCommentsPath @"museum/app/museum/comments"

//行程

//电子地图
#define kPointInfoPath @"app/museum/floors"
#define kInfoPtWithInfoPath @"app/museum/informationPoints"
#define kExhibitDetailWithInfoPath @"app/museum/pointinfos/1"
#define kSpecimenDetailWihtInfoPath @"app/museum/pointinfos/0"
#define kRemoteVideoPath @"app/museum/pointinfos/2"
#define kPraiseWithInfoPath @"app/museum/pointinfos"
#define kAreaPath @"app/museum/floors/areas"

//预约
#define kPersonTypesPath @"app/museum/book/personTypes"
#define kPreorderPath @"app/museum/book/preorder"
#define kMyPreorderPath @"app/museum/book"
#define kPreorderCancelPath @"app/museum/book"
#define kPreorderBrowsePath @"app/museum/book/browse"
//2015-4-16新增接口
#define kFilmsOrActivityPath @"web/book/films/findFilmList"
#define kNewSchedulePath @"web/book/findFilmPoByDate"
#define kPreorderDetailPath @"web/book/findFilmPoById"

//学习单
#define kStudyPath @"app/study"

//参观路线
#define kRoutesKeywordPath @"museum/app/museum/routes/searchKeyword"
#define kFacilityPath @"museum/app/museum/routes/publics"
#define kRecommendRoutePath @"museum/app/museum/routes/recommend"
#define kPraiseRoutePath @"museum/app/museum/routes/praise"
#define kPraiseRouteGuidePath @"museum/app/museum/routes/praise/guide"
#define kFindingPath @"museum/app/museum/routes/pathfinding"
#define kCustomRoutePath @"museum/app/museum/routes/customroute"
#define kUserPath @"museum/app/museum/routes/customroute/userlist"

//寻宝游戏
#define kGamePath @"museum/app/museum/games"
#define kGameThemesPath @"museum/app/museum/games/themes"
#define kGameTaskPath @"museum/app/museum/games"

//展品评论
#define kExhibitCommentPath @"museum/app/sharing/exhibit"
//展品评论 2 （tmd 又来个, 仅在 使用我回复的帖子 获取type=5 的时候调用）
#define kExhibitCommentPath2 @"museum/app/community/exhibit"

//互动社区
//专家来了
#define kInterestGroupPath @"museum/app/community/interestgroup"
#define kActivityPartyPath @"museum/app/community/activityparty"
#define kExpertPostsPath @"museum/app/community/specialist"
#define kExpertPath @"museum/app/community"
#define kExpertSubjectPath @"museum/app/community/specialist/subjects"
//删除帖子
#define kInterestGroupDeletePath @"museum/web/cc/interestPost"
#define kExpertDeletePath @"museum/web/cc/specialistPost"
#define kTakingphotoDeletePath @"museum/web/cc/takingphotoPost"
//删除回复
#define kInterestGroupReplyDeletePath @"museum/web/cc/interestReply"
#define kExpertReplytDeletePath @"museum/web/cc/specialistReply"
#define kTakingphotoReplyDeletePath @"museum/web/cc/takingphotoReply"
//我的帖子
#define kMyPostPath @"museum/app/community/posts"
//我的回帖
#define kMyReplyPath @"museum/app/community/replys"

//帖子浏览数
#define kPostBrowsePath @"museum/app/community/brows"
//帖子点赞
#define kPostPraisePath @"museum/app/community/praise"
//最佳回帖
//#define kBestReplyPath @"museum/app/community"
//随手拍
#define kTakePhotoPath @"museum/app/complain/takingphoto"

//大家来吐槽
#define kComplainPath @"museum/app/community/complain"

//消息中心
#define kMessagePath @"museum/app/message"

//图片上传community
#define kPostPicPath @"api/museum/addImg/community"
//2015-5-6新接口报错，暂时不用
//#define kPostPicPath @"museum/api/museum//addCommunityImage"

//灭绝之路
#define kExtinctionPath @"museum/bg/extinction"

//App更新地址
static NSString *const kAppUpdatePath = @"http://fir.im/api/v2/app/version/54dc4e483eab23d41e0013c8?token=2e347971e65f11e4b0f6e1d67b0cbcdd4e4184ff";

@implementation NSJSONSerialization (private)

+ (id)JSONObjecNoNulltWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing *)error
{
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:result];
    
    [NSJSONSerialization recursiveWithDictionary:dic];
    
    return dic;
}

+ (void)recursiveWithDictionary:(NSMutableDictionary *)originDic
{
    //1 移除所有null
    [NSJSONSerialization removeNullValueWithDic:originDic];
    
    NSArray *allkeysValue = [originDic allKeys];
    for (NSString *key in allkeysValue) {
        NSDictionary *dic = originDic[key];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            originDic[key] = mutableDic;
            [NSJSONSerialization recursiveWithDictionary:mutableDic];
        }
        
        //
        NSArray *array = originDic[key];
        if ([array isKindOfClass:[NSArray class]]) {
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
            originDic[key] = mutableArray;
            [NSJSONSerialization recursiveWithArray:mutableArray];
        }
    }
}

+ (void)recursiveWithArray:(NSMutableArray *)originArray
{
    for (NSInteger n = 0; n < originArray.count ; n++) {
        id subObject = originArray[n];
        if ([subObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:subObject];
            [originArray replaceObjectAtIndex:n withObject:mutableArray];
            [NSJSONSerialization recursiveWithArray:mutableArray];
        }
        
        if ([subObject isKindOfClass:[NSDictionary class]]) {
            [NSJSONSerialization recursiveWithDictionary:subObject];
        }
    }
}

//移除Dictironary 中的[NSNull null]
+ (void)removeNullValueWithDic:(NSMutableDictionary *)dic
{
    NSArray *keysNullValue = [dic allKeysForObject:[NSNull null]];
    [dic removeObjectsForKeys:keysNullValue];
}


@end


@implementation DataManager

+ (DataManager *)shareDataManager
{
    static DataManager *shareInstance = nil;
    if (shareInstance ==  nil) {
        @synchronized(self)
        {
            if (shareInstance == nil) {
                shareInstance = [[self alloc] init];
                shareInstance.lastInMuseumDate = [NSDate dateWithTimeIntervalSince1970:0];
            }
        }
    }
   
    return shareInstance;
}

#pragma mark - Setting
+ (void)registerDefaultsFromSettingsBundle
{
    
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}

#pragma mark - 用户管理
#pragma mark 1.1 会员登入
//对密码加密
//登入成功保存到本地
//模拟器里，注册过的登录不了，真机没问题
+ (DataRequest *)loginWithUser:(User *)user callback:(void (^)(User *user, BOOL success))callback
{
    NSAssert(user != nil, @"登入，用户不能为空");
    NSAssert(user.account.length > 0, @"登入，用户账号不能为空");
    NSAssert(user.pwd.length > 0, @"登入，用户密码不能为空");
    NSAssert(user.mac.length > 0, @"登入，用户mac不能为空");
    
    //密码加密
    NSString *pwd = [Help md5:user.pwd];
    //
    NSString *urlString = [NSString stringWithFormat:@"%@%@?account=%@&pwd=%@&mac=%@", [DataManager shareDataManager].serverAddress, kLoginPath, user.account, pwd, user.mac];
    NSURL *url = [NSURL URLWithString:urlString];
    
    DataRequest *request = [DataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToUserWithRequest:result callback:^(User *result, BOOL success) {
                //登入成功后， usr.sid不为空
                if (success && result.sid != nil) {
                    //保存到本地
                    result.isAutoLogin = user.isAutoLogin;
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:result];
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUser];
                }
                callback(result, success);
                
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    request.showError = YES;
    request.cache = NO;
    //
    return  request;
}

#pragma mark  Convert to User
+ (void)convertToUserWithRequest:(DataRequest *)request callback:(void (^)(User *user, BOOL success))callback
{
    User *user = [[User alloc] init];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        user.sid = dic[@"result"][@"uid"];
        user.account = dic[@"result"][@"account"];
        user.pwd = dic[@"result"][@"pwd"];
        user.nickname = dic[@"result"][@"nickname"];
        user.portraitPath = dic[@"result"][@"portrait"];
        user.mail = dic[@"result"][@"mail"];
        user.mobile = dic[@"result"][@"mobile"];
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(user, success);
    }
}

#pragma mark  1.2修改会员密码
+ (DataRequest *)changePasswordWithUser:(User *)user newPassword:(NSString *)newPassword callback:(void (^)(BOOL update, BOOL success))callback
{
    NSAssert(user.account.length > 0, @"修改会员密码， 账号不能为空");
    NSAssert(user.pwd.length > 0, @"修改会员密码， 原密码不能为空");
    NSAssert(newPassword.length > 0, @"修改会员密码， 新密码不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/changePwd", [DataManager shareDataManager].serverAddress, kChangePasswordPath, (long)user.sid.integerValue];
    NSURL *url = [NSURL URLWithString:urlString];
    
    DataRequest *request = [DataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL update, BOOL success) {
                callback(update, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    //
    [request setPostValue:user.account forKey:@"account"];
    
    //jiami
    NSString *pwd = [Help md5:user.pwd];
    [request setPostValue:pwd forKey:@"srcPwd"];
    newPassword = [Help md5:newPassword];
    [request setPostValue:newPassword forKey:@"newPwd"];
    request.requestMethod = @"POST";
    
    return request;
}

#pragma mark 1.3 用户注册
+ (DataRequest *)registWithUser:(User *)user callback:(void (^)(BOOL registed, BOOL success))callback
{
    NSAssert(user != nil, @"用户注册，user不能为空");
    
    //如果有头像，先上传头像

    DataRequest *requestPic = [DataManager postPic:user.portraitImage callback:^(NSString *picPath, BOOL success) {
//        if (success && picPath.length > 0) {
//            user.portraitPath = picPath;
//        }
//        
        DataRequest *registUser = [DataManager registWithUser:user portraitPath:picPath callback:^(BOOL registed, BOOL success) {
            callback(registed, success);
        }];
        
        [registUser startAsynchronous];
        
    }];
    
    
    
    return requestPic;
}

///
+ (DataRequest *)registWithUser:(User *)user portraitPath:(NSString *)portraitPath callback:(void (^)(BOOL registed, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kRegistPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    DataRequest *request = [DataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    //头像
    if (portraitPath.length >0) {
        [request setPostValue:portraitPath forKey:@"portrait"];
    }
    //
    [request setPostValue:user.account forKey:@"account"];
    NSString *pwd = [Help md5:user.pwd];
    [request setPostValue:pwd forKey:@"pwd"];
    [request setPostValue:user.nickname forKey:@"nickname"];
    [request setPostValue:user.mail forKey:@"mail"];
    [request setPostValue:user.mobile forKey:@"mobile"];
    
    
    request.requestMethod = @"POST";
    
    return request;
}

#pragma mark 1.4 修改会员信息
+ (DataRequest *)updateUserInfo:(User *)user callback:(void (^)(BOOL update, BOOL success))callback
{
    NSAssert(user.mail.length > 0, @"修改会员信息， mail不能为空");
    NSAssert(user.mobile.length > 0, @"修改会员信息， mobile不能为空");
    NSAssert(user.nickname.length > 0, @"修改会员信息， nickname不能为空");
    //NSAssert(user.portraitPath.length > 0, @"修改会员信息， portraitPath不能为空");
    
    DataRequest *requestPic = [DataManager postPic:user.portraitImage callback:^(NSString *picPath, BOOL success) {
        user.portraitPath = picPath;
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/update", [DataManager shareDataManager].serverAddress, kUpdateUserPath, (long)user.sid.integerValue];
        NSURL *url = [NSURL URLWithString:urlString];

        DataRequest *request = [DataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
            if (success) {
                //更新成功
                
                [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                    
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUser];
                    
                    callback(found, success);
                }];
            }else{
                callback(NO, success);
            }
        }];
        
        [request setPostValue:user.mail forKey:@"mail"];
        [request setPostValue:user.mobile forKey:@"mobile"];
        [request setPostValue:user.nickname forKey:@"nickname"];
        [request setPostValue:picPath forKey:@"portrait"];
        request.requestMethod = @"POST";
        
        [request startAsynchronous];
    }];
    
    return requestPic;
}

#pragma mark 1.5找回密码
+ (DataRequest *)findPasswordWithUser:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.account != nil, @"找回密码，user.account不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@/getPassword", [DataManager shareDataManager].serverAddress, kFindPasswordPath, user.account];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    return request;
}

#pragma mark  获取本地用户信息
+ (User *)getUser
{
    User *user= nil;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    if (data != nil) {
        user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return user;
}

#pragma mark 系统管理获取浏览痕迹、我的路线、我的消息
+ (DataQueue *)loadMySystemInfoWithUser:(User *)user callback:(void (^)(SystemInfoItem *systemInfoItem, BOOL success))callback
{
    DataRequest *request1 = [DataManager loadTourWithDate:[NSDate date] user:user callback:^(NSArray *tours, BOOL success) {

    }];
    request1.showHUD = NO;
    
    DataRequest *request2 = [DataManager loadUserCustomRouteWithUser:user callback:^(NSArray *routes, BOOL success) {

    }];
    request2.showHUD = NO;
    
    DataRequest *request3 = [DataManager loadAppointmentWithUser:user callback:^(NSArray *orders, BOOL success) {
        
    }];
    request3.showHUD = NO;
    
    //获取我的帖子
    DataRequest *request4 = [DataManager loadPostWithUser:user page:1 pagesize:30 callback:^(PageItem *pageItem, BOOL success) {
        //
    }];
    request4.showHUD = NO;
    
    //我的回帖
    DataRequest *request5 = [DataManager loadReplyWithUser:user page:1 pagesize:30 callback:^(PageItem *pageItem, BOOL success) {
        //
    }];
    request5.showHUD = NO;
    
    //我的游戏
    DataRequest *request6 = [DataManager loadGameStatisticalWithUser:user callback:^(NSArray *list, BOOL success) {
        //
    }];
    request6.showHUD = NO;
    
    NSArray *requests = @[request1, request2, request3, request4, request5, request6];
    DataQueue *queue = [LXDataManager requestWithRequests:requests callback:^(DataQueue *result, BOOL success) {
        SystemInfoItem *systemInfo = nil;
        if (success) {
            //
            systemInfo = [[SystemInfoItem alloc] init];
            //浏览痕迹
            DataRequest *requestTour = result.requests[0];
            [DataManager convertToToursWithRequest:requestTour callback:^(NSArray *tours, BOOL success) {
                systemInfo.tours = tours;
            }];
            
            //路线
            DataRequest *requestRoute = result.requests[1];
            [DataManager convertToRoutesWithRequest:requestRoute callback:^(NSArray *routes, BOOL success) {
                NSMutableArray *temp=[[NSMutableArray alloc] init];
                for (CustomRouteItem *custom in routes) {
                    if (custom.routes.count>0) {
                        [temp addObject:custom];
                    } else {
                        [self deleteCustomRoute:custom callback:^(BOOL deleted, BOOL success) {
                        }];
                    }
                }
                systemInfo.routes = temp;
            }];
            
            //预约
            DataRequest *requestOrder = result.requests[2];
            [DataManager convertToOrdersWithRequest:requestOrder callback:^(NSArray *orders, BOOL success) {
       
                if (success && orders.count>0) {
                    NSMutableArray *newOrders=[[NSMutableArray alloc] init];
                    for (OrderItem *theOrderItem in orders) {
                        [newOrders addObject:theOrderItem];
                    }
                    NSArray *sortedArray1 = [newOrders sortedArrayUsingComparator:^NSComparisonResult(OrderItem *obj1, OrderItem *obj2){
                        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                        [dateFormatter setDateFormat:@"HH:mm"];
                        NSDate *date1=[dateFormatter dateFromString:obj1.beginTime];
                        NSDate *date2=[dateFormatter dateFromString:obj2.beginTime];
                        if ([date1 timeIntervalSinceDate:date2]<0) {
                            return NSOrderedAscending;
                        }
                        if ([date1 timeIntervalSinceDate:date2]>0){
                            return NSOrderedDescending;
                        }
                        return NSOrderedSame;
                    }];

                    systemInfo.orders = sortedArray1;
                } else {
                    systemInfo.orders = orders;
                }
            }];
            
            //我的帖子
            DataRequest *requestPost = result.requests[3];
            [DataManager convertToPostsWithRequest:requestPost postType:PostUnkown callback:^(PageItem *pageItem, BOOL success) {
                if (success) {
                    systemInfo.postPageItem = pageItem;
                }
            }];
            
            //我的回复
            DataRequest *requestReply = result.requests[4];
            [DataManager convertToPostsWithRequest:requestReply postType:PostUnkown callback:^(PageItem *pageItem, BOOL success) {
                if (success) {
                    systemInfo.replyPageItem = pageItem;
                }
            }];
            
            //我的游戏
            DataRequest *requestGame = result.requests[5];
        }
        callback(systemInfo, success);
      
    }];
    
    return queue;
}

#pragma mark - 系统参数
#pragma mark 2.1 系统资源根目录
+ (void)loadSystem:(void (^)(SystemItem *systemItem, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kSystemPath];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        //
        if (success) {
            [DataManager convertToSystemWithRequest:result  callback:^(SystemItem *systemItem, BOOL success) {
                callback(systemItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    request.showHUD = NO;
    [request startAsynchronous];
}

+ (void)convertToSystemWithRequest:(DataRequest *)request callback:(void (^)(SystemItem *systemItem, BOOL success))callback
{
    SystemItem *systemItem;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        systemItem = [[SystemItem alloc] init];
        systemItem.baseUrl = dic[@"result"][@"baseUrl"];
        systemItem.resourceBaseUrl = dic[@"result"][@"resourceBaseUrl"];
#warning 后台没有返回 udpPath和bookThreshold
#warning url 最后不一定提供 / 结尾
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(systemItem, success);
    }
}

#pragma mark - 可视化搜索
#pragma mark 3.1 关键字搜索
+ (DataRequest *)loadExhibitWithKeyword:(NSString *)keyword  callback:(void (^)(NSArray *exhibits, BOOL success))callback
{
    NSAssert(keyword != nil && ![keyword isEqualToString:@""], @"可视化搜索， keyword不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?key=%@", [DataManager shareDataManager].serverAddress, kExhibitKeywordPath, keyword];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        
        if (success) {
            [DataManager convertToExhibitWithRequest:result callback:^(NSArray *exhibits, BOOL success) {
                callback(exhibits, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 3.2 相关展品列表（远亲、近邻)
+ (DataRequest *)loadRelationWithExhibit:(ExhibitItem *)exhibitItem callback:(void (^)(NSArray *exhibits, BOOL success))callback
{
    NSAssert(exhibitItem.sid != nil, @"相关展品列表, exhibitItem 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/relationExhibits", [DataManager shareDataManager].serverAddress, kRelationExhibitPath,(long) exhibitItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExhibitWithRequest:result callback:^(NSArray *exhibits, BOOL success) {
                callback(exhibits, success);
            }];
        }else{
            callback(nil, success);
        }
    }];

    return request;
}

+ (void)convertToExhibitWithRequest:(DataRequest *)request callback:(void (^)(NSArray *exhibits, BOOL success))callback
{
    NSMutableArray *exhibits = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *eDic in dic[@"result"]) {
            ExhibitItem *eItem = [[ExhibitItem alloc] init];
            eItem.sid = eDic[@"eid"];
            eItem.name = eDic[@"name"];
            eItem.latinName = eDic[@"latinName"];
            eItem.iconPath = eDic[@"icon"];
            eItem.haveStory = ((NSNumber *)eDic[@"haveStory"]).boolValue;
            @try {
                //loadRelationWithExhibit 用到
                eItem.relation =  ((NSNumber *)eDic[@"relation"]).intValue;
            }
            @catch (NSException *exception) {
                //
            }
            @finally {
                //
            }
            
            [exhibits addObject:eItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(exhibits, success);
    }
}

#pragma mark 3.3 展品详细信息
+ (DataRequest *)loadExhibitDetailWithExhibit:(ExhibitItem *)exhibitItem callback:(void (^)(ExhibitItem *exhibitItem, BOOL success))callback
{
    NSAssert(exhibitItem.sid != nil, @"相关展品列表, exhibitItem 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@", [DataManager shareDataManager].serverAddress, kExhibitDetailPath, exhibitItem.sid.stringValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExhibitDetailWithRequest:result callback:^(ExhibitItem *exhibitDetailItem, BOOL success) {
                //loadExhibitDetailItem 没有haveStory
                //在这里补上
                exhibitDetailItem.haveStory = exhibitItem.haveStory;
                callback(exhibitDetailItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    
    return request;
}

+ (void)convertToExhibitDetailWithRequest:(DataRequest *)request callback:(void (^)(ExhibitItem *exhibitItem, BOOL succeess))callback
{
    ExhibitItem *eItem;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        NSDictionary *eDic = dic[@"result"];
        eItem = [[ExhibitItem alloc] init];
        
        eItem.sid = eDic[@"eid"];
        eItem.name = eDic[@"name"];
        eItem.latinName = eDic[@"latinName"];
        eItem.iconPath = eDic[@"icon"];
        
        //
        eItem.summary = eDic[@"summary"];
        eItem.age = eDic[@"age"];
        eItem.gathering = eDic[@"gathering"];
        eItem.code = eDic[@"code"];
        eItem.latinName = eDic[@"latinName"];
        eItem.englishName = eDic[@"englishName"];
        eItem.popularName = eDic[@"popularName"];
        eItem.pics = eDic[@"pics"];
        eItem.relationRegionId = eDic[@"erid"];
        eItem.tName = eDic[@"tname"];
        eItem.sepicmenId = eDic[@"sid"];
        eItem.infoId = eDic[@"infoId"];
        
        //分类地位
        eItem.status = eDic[@"taxonomic"];
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(eItem, success);
    }
}

#pragma mark 3.4 标本背后的故事
+ (DataRequest *)loadSpecimenWithSpecimenId:(NSNumber *)specimenId callback:(void (^)(SpecimenItem *specimenItem, BOOL success))callback
{
    NSAssert(specimenId != nil, @"标本背后的故事, specimenId 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i", [DataManager shareDataManager].serverAddress, kSpecimenPath, specimenId.intValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSpecimenWithRequest:result callback:^(SpecimenItem *specimentItem, BOOL success) {
                callback(specimentItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    request.cache = YES;
    return request;
}

+ (void)convertToSpecimenWithRequest:(DataRequest *)request callback:(void (^)(SpecimenItem *specimentItem, BOOL success))callback
{
    SpecimenItem *specimenItem = nil;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        NSDictionary *sDic = dic[@"result"];
        specimenItem = [[SpecimenItem alloc] init];
        specimenItem.sid = sDic[@"id"];
        specimenItem.name = sDic[@"specimenName"];
        specimenItem.iconPath = sDic[@"specimenIcon"];
        specimenItem.introduce = sDic[@"specimenIntroduction"];
        specimenItem.locationType = ((NSNumber *)sDic[@"specimenType"]).intValue;
        specimenItem.lookVideoPath = sDic[@"lookVideo"];
        specimenItem.lookARPath = sDic[@"iosLookVideoAr"];
        //specimenItem.lookPics = sDic[@"lookPics"];
        specimenItem.lookPics = sDic[@"iosLookPics"];
        //specimenItem.studyPics = sDic[@"studyPics"];
        specimenItem.studyPics = sDic[@"iosStudyPics"];
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(specimenItem, success);
    }
}

#pragma mark 获取标本写真
+ (DataRequest *)loadSpecimenPortraitsWithSpecimenId:(NSNumber *)specimenId callback:(void (^)(NSArray *exhibits, BOOL success))callback
{
    NSAssert(specimenId != nil, @"获取标本写真，specimenId不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/portraits", [DataManager shareDataManager].serverAddress, kSpecimenPath, specimenId.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExhibitsWithRequest:result callback:^(NSArray *exhibits, BOOL success) {
                callback(exhibits, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 3.5 展品位置
+ (void)loadExhibitPositionWithExhibit:(ExhibitItem *)exhibitItem callback:(void (^)(InfoItem *infoItem, BOOL success))callback
{
    NSAssert(exhibitItem.sid != nil, @"展品位置， exhibitItem.sid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i/position", [DataManager shareDataManager].serverAddress, kExhibitPositionPath, exhibitItem.sid.intValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPositionWithRequest:result callback:^(InfoItem *infoItem, BOOL success) {
                callback(infoItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    request.cache = YES;
    [request startAsynchronous];
}


+(void)convertToPositionWithRequest:(DataRequest *)request callback:(void (^)(InfoItem *infoItem, BOOL success))callback
{
    InfoItem *pItem = nil;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        NSDictionary *pDic = dic[@"result"];
        pItem = [[InfoItem alloc] init];
        pItem.type = InfoItemExhibit;
        pItem.sid = pDic[@"id"];
        pItem.floorCode = pDic[@"floorCode"];
        NSNumber *x = pDic[@"x"];
        NSNumber *y = pDic[@"y"];
        //iPhone 调整
        pItem.pt = CGPointMake(x.floatValue * 0.5f, y.floatValue * 0.5f);
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(pItem, success);
    }

}

#pragma mark 3.6 获取精品展品所包含的列表
+ (DataRequest *)loadExhibitsWithInfoItem:(InfoItem *)infoItem callback:(void (^)(NSArray *exhibits, BOOL success))callback
{
    
    NSAssert(infoItem.relationId != nil, @"获取精品展品所包含， relationId不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/exhibitList", [DataManager shareDataManager].serverAddress, kExhibtGroupPath, (long)infoItem.relationId.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExhibitsWithRequest:result callback:^(NSArray *exhibits, BOOL success) {
                callback(exhibits, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToExhibitsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *exhibits, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        NSMutableArray *exhibits = [NSMutableArray array];
        @try {
            for (NSDictionary *eDic in dic[@"result"]) {
                ExhibitItem *eItem = [[ExhibitItem alloc] init];
                
                eItem.sid = eDic[@"eid"];
                eItem.name = eDic[@"name"];
                eItem.latinName = eDic[@"latinName"];
                eItem.iconPath = eDic[@"icon"];
                
                //
                eItem.summary = eDic[@"summary"];
                eItem.age = eDic[@"age"];
                eItem.gathering = eDic[@"gathering"];
                eItem.code = eDic[@"code"];
                eItem.latinName = eDic[@"latinName"];
                eItem.englishName = eDic[@"englishName"];
                eItem.popularName = eDic[@"popularName"];
                //又是个垃圾接口
                eItem.pics = eDic[@"pics"];
                if (eDic[@"image"] != nil) {
                    eItem.pics = eDic[@"image"];
                }

                eItem.relationRegionId = eDic[@"erid"];
                eItem.tName = eDic[@"tname"];
                eItem.sepicmenId = eDic[@"sid"];
                
                //分类地位
                eItem.status = eDic[@"taxonomic"];
                [exhibits addObject:eItem];
            }
        }
        @catch (NSException *exception) {
            //
            message = exception.description;
            exhibits = nil;
            success = NO;
        }
        @finally {
            if (request.showError && !success) {
                [DataManager showMessage:message dur:request.errorDur];
            }
            
        }
        callback(exhibits, success);
    }];
}

#pragma mark 3.7 获取精品展品详细信息
+ (DataRequest *)loadExhibitGroupWithInfoItem:(InfoItem *)infoItem callback:(void (^)(ExhibitGroupItem *groupItem, BOOL success))callback
{
    NSAssert(infoItem.relationId != nil, @"获取精品展品， infoImte.relationId 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li", [DataManager shareDataManager].serverAddress, kExhibtGroupApiPath, (long)infoItem.relationId.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExhibitGroupItemWithRequest:result callback:^(ExhibitGroupItem *groupItem, BOOL success) {
                groupItem.infoItem = infoItem;
                callback(groupItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToExhibitGroupItemWithRequest:(DataRequest *)request callback:(void (^)(ExhibitGroupItem *groupItem, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        ExhibitGroupItem *gItem;
        if (success) {
            @try {
                gItem = [[ExhibitGroupItem alloc] init];
                gItem.sid = dic[@"result"][@"id"];
                gItem.title = dic[@"result"][@"title"];
                gItem.detail = dic[@"result"][@"introduce"];
                gItem.picPath = dic[@"result"][@"pic"];
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
                gItem = nil;
            }
            @finally {
                if (request.showError && !success) {
                    [DataManager showMessage:message dur:request.errorDur];
                }
            }
        }
        
        callback(gItem, success);
    }];
}


#pragma mark - 行程
#pragma mark 4.1 存储用户行程
//存储当前用户的行程点，没有用户返回nil
+ (DataRequest *)postTourWithInfoItem:(InfoItem *)infoItem callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(infoItem.sid != nil, @"存储用户行程, infoItem.sid 不能为空");
    User *user = [DataManager getUser];
    [user generateMAC];
    if (user.mac == nil) {
        return nil;
    }
    
    //接口修改了
    //NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/tour", [DataManager shareDataManager].serverAddress, kTourPath, (long)user.sid.integerValue];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kToursPath];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                if (callback) {
                    callback(found, success);
                }
                
            }];
        }else{
            if (callback) {
                callback(NO, success);
            }
        }
    }];
    
    request.requestMethod = @"POST";
    [request setPostValue:infoItem.sid forKey:@"infoId"];
    [request setPostValue:user.mac forKey:@"mac"];
    [request setPostValue:user.sid forKey:@"userId"];
    return  request;
}

#pragma mark 4.2 获取用户行程
+ (DataRequest *)loadTourWithDate:(NSDate *)date user:(User *)user callback:(void (^)(NSArray *tours, BOOL success))callback
{
    NSAssert(user.sid != nil, @"获取用户行程, user.sid 不能为空");
    [user generateMAC];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    //
    NSString *urlString = [NSString stringWithFormat:@"%@%@?date=%@&userId=%li", [DataManager shareDataManager].serverAddress, kToursPath, dateString, (long)user.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToToursWithRequest:result callback:^(NSArray *tours, BOOL success)
             {
                 callback(tours, success);
             }];
        }else{
            callback(nil, success);
        }
    }];
    
    return  request;
}

+ (void)convertToToursWithRequest:(DataRequest *)request callback:(void (^)(NSArray *tours, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        NSMutableArray *tours = nil;
        @try {
            NSArray *results = dic[@"result"];
            tours = [NSMutableArray arrayWithCapacity:results.count];
            for (NSDictionary *tDic in results) {
                TourItem *tItem = [[TourItem alloc] init];
                tItem.sid = tDic[@"id"];
                tItem.type = ((NSNumber *)tDic[@"type"]).intValue;
                tItem.name = tDic[@"name"];
                tItem.iconPath = tDic[@"titlePic"];
                //接口修改了
                //                NSNumber *timeOffset = tDic[@"date"];
                //                NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeOffset.doubleValue / 1000.0f];
                tItem.time = tDic[@"time"];
                
                [tours addObject:tItem];
            }
        }
        @catch (NSException *exception) {
            message = exception.description;
            success = NO;
            tours = nil;
        }
        @finally {
            //
        }
        
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        
        callback(tours, success);
    }];
}


#pragma mark - 电子地图
#pragma mark 5.1 获取楼层信息点信息
+ (DataRequest *)loadPointInfoWithUser:(User *)user floor:(NSInteger)floor callback:(void (^)(NSArray *infos, BOOL success))callback
{
    if (user ==  nil) {
        user = [DataManager getUser];
    }
    if (user.mac == nil) {
        [user generateMAC];
    }
    
    NSNumber *sid = @0;
    if (user.sid != nil) {
        sid = user.sid;
    }
    //http://www.snhm.org.cn/museum/app/museum/floors/1/pointinfos?userId=2&mac=9547AAA5-C2F0-49AD-8F8D-499CF43D1A99
    NSString *tempStr = @"http://www.snhm.org.cn/museum/";
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/pointinfos?userId=%@&mac=%@", [DataManager shareDataManager].serverAddress, kPointInfoPath, (long)floor, sid, user.mac];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/pointinfos?userId=%@&mac=%@", tempStr, kPointInfoPath, (long)floor, sid, user.mac];
    
    DataRequest *request =[DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        //
        if (success) {
            [DataManager convertToInfosWithRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToInfosWithRequest:(DataRequest *)request callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSMutableArray *infos = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *infoDic in dic[@"result"]) {
            InfoItem *iItem = [[InfoItem alloc] init];
            iItem.sid = infoDic[@"id"];
            iItem.title = infoDic[@"title"];
            iItem.relevanceName = infoDic[@"relevanceName"];
            iItem.iconPath = infoDic[@"icon"];
            iItem.type = ((NSNumber *)infoDic[@"type"]).intValue;
            iItem.relationId = infoDic[@"relationshipId"];
            iItem.gameTaskId = infoDic[@"gameTaskId "];
            iItem.praise = infoDic[@"praise"];
            NSNumber *x = infoDic[@"pointX"];
            NSNumber *y = infoDic[@"pointY"];
            //iPhone 调整
            iItem.pt = CGPointMake(x.floatValue * 0.5f, y.floatValue * 0.5f);
            iItem.visit = ((NSNumber *)infoDic[@"visit"]).boolValue;
            iItem.locationType = ((NSString *)infoDic[@"positionType"]).intValue;
            
            [infos addObject:iItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(infos, success);
    }
}

#pragma mark 5.2 获取信息点的地图所在位置
+ (DataRequest *)loadPointInfoWithInfoItem:(InfoItem *)infoItem callback:(void (^)(InfoItem *infoItem, BOOL success))callback
{
    NSAssert(infoItem != nil, @"获取信息点的地图所在位置, infoItem 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i/%i/position", [DataManager shareDataManager].serverAddress, kInfoPtWithInfoPath, infoItem.type, infoItem.sid.intValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //
            [DataManager convertToInfoWithPointRequest:result callback:^(InfoItem *infoItem, BOOL success) {
                callback(infoItem, success);
            } ];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
    
}

+ (void)convertToInfoWithPointRequest:(DataRequest *)request callback:(void (^)(InfoItem *infoItem, BOOL success))callback
{
    InfoItem *infoItem = nil;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        NSDictionary *infoDic = dic[@"result"];
        infoItem  = [[InfoItem alloc] init];
        NSNumber *x;
        NSNumber *y;
        x = infoDic[@"x"];
        y = infoDic[@"y"];
        
        infoItem.pt = CGPointMake(x.floatValue * 0.5f, y.floatValue * 0.5f);
        infoItem.floorCode = infoDic[@"floorCode"];infoItem.floorCode = infoDic[@"floorCode"];
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(infoItem, success);
    }
}


#pragma mark 5.3 获取远程视频详细信息
+ (DataRequest *)loadRemoteVideoWithInfo:(InfoItem *)infoItem callback:(void (^)(RemoteVideoItem *remoteVideoItem, BOOL success))callback
{
    NSAssert(infoItem.sid != nil, @"获取远程视频详细信息, infoItem.sid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i", [DataManager shareDataManager].serverAddress, kRemoteVideoPath, infoItem.sid.intValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToRemoteVideoWithRequest:result callback:^(RemoteVideoItem *remoteVideoItem, BOOL success) {
                callback(remoteVideoItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToRemoteVideoWithRequest:(DataRequest *)request callback:(void (^)(RemoteVideoItem *remoteVideoItem, BOOL success))callback
{
    RemoteVideoItem *videoItem = nil;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        videoItem = [[RemoteVideoItem alloc] init];
        NSDictionary *vDic = dic[@"result"];
        videoItem.sid = vDic[@"id"];
        videoItem.title = vDic[@"title"];
        videoItem.iconPath = vDic[@"icon"];
        videoItem.urlPath = vDic[@"url"];
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
        videoItem = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(videoItem, success);
    }
}

#pragma mark 5.4 信息点点赞
+ (DataRequest *)postPraiseWithInfoItem:(InfoItem *)infoItem callback:(void (^)(NSNumber *praiseNum, BOOL success))callback
{
    NSAssert(infoItem.sid != nil, @"信息点点赞，infoItem.sid 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i/praise", [DataManager shareDataManager].serverAddress, kPraiseWithInfoPath, infoItem.sid.intValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPraiseWithRequest:result callback:^(NSNumber *praiseNum, BOOL success) {
                callback(praiseNum, success);
            }];
        }else{
            callback(0, success);
        }
    }];
    
    [request setRequestMethod:@"POST"];
    return request;
}

+ (void)convertToPraiseWithRequest:(DataRequest *)request callback:(void (^)(NSNumber* praiseNum, BOOL success))callback
{
    NSNumber *praise;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        if (dic[@"result"] != nil) {
            praise = dic[@"result"];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(praise, success);
    }
}

#pragma mark - 5.5 获取信息点点赞数量
+ (DataRequest *)loadPraiseWithInfoItem:(InfoItem *)infoItem callback:(void (^)(NSNumber *praiseNum, BOOL success))callback
{
    NSAssert(infoItem.sid != nil, @"获取信息点点赞数量，infoItem.sid不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/praise", [DataManager shareDataManager].serverAddress, kPraiseWithInfoPath, (long)infoItem.sid.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //
            [DataManager convertToPraiseNumWithRequest:result callback:^(NSNumber *praiseNum, BOOL success)
             {
                 callback(praiseNum, success);
             }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToPraiseNumWithRequest:(DataRequest *)request callback:(void (^)(NSNumber *praiseNum, BOOL success))callback

{
    NSNumber *praiseNum = nil;
    NSString *message = nil;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        praiseNum = dic[@"result"];
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
        praiseNum = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(praiseNum, success);
    }
}

//TODO: 需测试
//#pragma mark 5.6 获取展区信息
//+ (void)loadAreas:(void (^)(NSArray *areas, BOOL success))callback
//{
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kAreaPath];
//    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
//        NSLog(@"Areas: %@", result.responseString);
//        if (success) {
//            [DataManager convertToAreasWithRequest:result callback:^(NSArray *areas, BOOL success) {
//                callback(areas, success);
//            }];
//        }else{
//            callback(nil, success);
//        }
//    }];
//    
//    request.cache = YES;
//    [request startAsynchronous];
//}
//
//+ (void)convertToAreasWithRequest:(DataRequest *)request callback:(void (^)(NSArray *areas, BOOL success))callback
//{
//    NSMutableArray *areas = [NSMutableArray array];
//    NSString *message;
//    BOOL success = YES;
//    NSError *error = nil;
//    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
//    
//    //JSON 错误
//    if(error != nil)
//    {
//        message = error.description;
//        success = NO;
//    }
//    
//    //格式错误
//    @try {
//        for (NSDictionary *areaDic in dic[@"result"]) {
//            AreaItem *areaItem = [[AreaItem alloc] init];
//            areaItem.sid = areaDic[@"id"];
//            areaItem.name = areaDic[@"name"];
//            areaItem.threshold = areaDic[@"threshold"];
//            areaItem.code = areaDic[@"code"];
//            areaItem.iconPath = areaDic[@"icon"];
//            
//            [areas addObject:areaItem];
//        }
//    }
//    @catch (NSException *exception) {
//        success = NO;
//        message = exception.description;
//    }
//    @finally {
//        if (request.showError && !success) {
//            [DataManager showMessage:message dur:request.errorDur];
//        }
//        callback(areas, success);
//    }
//}

#pragma mark 获取标本背后详细信息
+ (void)loadSpecimenDetailWithInfo:(InfoItem *)infoItem callback:(void (^)(SpecimenItem *specimenItem, BOOL success))callback
{
    NSAssert(infoItem.sid != nil, @"获取标本背后详细信息, infoItem.sid不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i", [DataManager shareDataManager].serverAddress, kSpecimenDetailWihtInfoPath, infoItem.sid.intValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSpecimenWithRequest:result callback:^(SpecimenItem *specimentItem, BOOL success) {
                callback(specimentItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    request.cache = YES;
    [request startAsynchronous];
}

#pragma marm - 展品互动
#warning 暂时不做

#pragma mark - 预约
#pragma mark 获取受众类型
+ (DataRequest *)loadPersonTypes:(void (^)(NSDictionary *personDic, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPersonTypesPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    DataRequest *request = [DataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPersonTypesWithRequest:result callback:^(NSDictionary *result, BOOL success) {
                callback(result, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToPersonTypesWithRequest:(DataRequest *)request callback:(void (^)(NSDictionary *result, BOOL success))callback
{
    NSDictionary *result = nil;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        result = dic[@"result"];
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(result, success);
    }
}

#pragma mark 获取电影或活动列表 2015-4-16新增
+ (DataRequest *)loadFilmsOrActivitysForType:(OrderType)type currentpage:(NSInteger)page countOfOnePage:(NSInteger)count date:(NSDate *)date callback:(void (^)(NSArray *filmsOrActivitys, BOOL success))callback{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?type=%i&currentpage=%i&pagesize=%i&date=%@", [DataManager shareDataManager].serverAddress, kFilmsOrActivityPath,type,page,count,dateString];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    DataRequest *request = [DataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            if (type == OrderTypeFilm) {
                [DataManager newConvertToFilmsWithRequest:result callback:^(NSArray *films, BOOL success) {
                    callback(films, success);
                }];
            } else {
                [DataManager newConvertToActivitiesWithRequest:result callback:^(NSArray *activities, BOOL success) {
                    callback(activities, success);
                }];
            }
        }else{
            callback(nil, success);
        }
    }];

    return  request;
}

//2015-4-16新增
+ (void)newConvertToFilmsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *films, BOOL success))callback
{
    NSMutableArray *films = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *filmDic in dic[@"result"][@"data"]) {
            FilmItem *filmItem = [[FilmItem alloc] init];
            filmItem.sid = filmDic[@"id"];
            filmItem.name = filmDic[@"name"];
            filmItem.titlePic = filmDic[@"image"];
            filmItem.playTime = filmDic[@"length"];
            filmItem.introduction = filmDic[@"introduction"];
            filmItem.bookNum = filmDic[@"bookNum"];
            filmItem.browseNum = filmDic[@"browseNum"];
            filmItem.filmPrompt = filmDic[@"filmPrompt"];
            
            [films addObject:filmItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(films, success);
    }
}

+ (void)convertToFilmsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *films, BOOL success))callback
{
    NSMutableArray *films = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *filmDic in dic[@"result"]) {
            FilmItem *filmItem = [[FilmItem alloc] init];
            filmItem.sid = filmDic[@"id"];
            filmItem.name = filmDic[@"name"];
            filmItem.titlePic = filmDic[@"titlePic"];
            filmItem.playTime = filmDic[@"playTime"];
            filmItem.introduction = filmDic[@"introduction"];
            filmItem.bookNum = filmDic[@"bookNum"];
            filmItem.browseNum = filmDic[@"browseNum"];

            
            [films addObject:filmItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(films, success);
    }
}

//2015-4-16新增
+ (void)newConvertToActivitiesWithRequest:(DataRequest *)request callback:(void (^)(NSArray *results, BOOL success))callback
{
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    
    NSMutableArray *activities = [NSMutableArray array];
    //
    //#warning mark 接口问题 result == null
    //    if (dic[@"result"] == [NSNull null]) {
    //        callback(activities, YES);
    //        return;
    //    }
    
    //格式错误
    @try {
        for (NSDictionary *activityDic in dic[@"result"][@"data"]) {
            ActivityItem *activityItem = [[ActivityItem alloc] init];
            activityItem.sid = activityDic[@"id"];
            activityItem.perseonTypes=activityDic[@"personTypes"];
            activityItem.name = activityDic[@"title"];
            activityItem.titlePic = activityDic[@"icon"];
            activityItem.contents = activityDic[@"contents"];
            activityItem.browseNum = activityDic[@"browseNum"];
            activityItem.activityPrompt = activityDic[@"activityPrompt"];
            //dsy add
            activityItem.beginTime = activityDic[@"beginTime"];
            activityItem.endTime = activityDic[@"endTime"];
            
            [activities addObject:activityItem];
        }
    }
    @catch (NSException *exception) {
        
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(activities, success);
    }
}

+ (void)convertToActivitiesWithRequest:(DataRequest *)request callback:(void (^)(NSArray *results, BOOL success))callback
{
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    
    NSMutableArray *activities = [NSMutableArray array];
//    
//#warning mark 接口问题 result == null
//    if (dic[@"result"] == [NSNull null]) {
//        callback(activities, YES);
//        return;
//    }
    
    //格式错误
    @try {
        for (NSDictionary *activityDic in dic[@"result"]) {
            ActivityItem *activityItem = [[ActivityItem alloc] init];
            activityItem.sid = activityDic[@"id"];
            activityItem.perseonTypes=activityDic[@"personTypes"];
            activityItem.name = activityDic[@"name"];
            activityItem.titlePic = activityDic[@"titlePic"];
            activityItem.contents = activityDic[@"contents"];
            activityItem.browseNum = activityDic[@"browseNum"];
            [activities addObject:activityItem];
        }
    }
    @catch (NSException *exception) {

        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(activities, success);
    }
}

#pragma mark 查询活动或影片安排的信息
+ (DataRequest *)newLoadSchedulesWithItem:(NSObject *)item date:(NSDate *)date callback:(void (^)(NSArray *schudules, BOOL success))callback
{
    
    NSNumber *sid = nil;
    PreorderType preorderType = -1;
    if ([item isKindOfClass:[FilmItem class]]) {
        //
        FilmItem *filmItem = (FilmItem *)item;
        NSAssert(filmItem.sid != nil, @"查询安排信息， filmItem.sid不能为空");
        sid = filmItem.sid;
        preorderType = PreorderFilm;
    }
    
    if ([item isKindOfClass:[ActivityItem class]]) {
        //
        ActivityItem *activityItem = (ActivityItem *)item;
        NSAssert(activityItem.sid != nil, @"查询安排信息， activityItem.sid不能为空");
        sid = activityItem.sid;
        preorderType = PreorderActivity;
    }
    
    NSString *dateString;
    if (date) {
        NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        dateString= [dateFormtter stringFromDate:date];
    }
    
    if ([item isKindOfClass:[OrderItem class]]) {
        OrderItem *orderItem = (OrderItem *)item;
        NSAssert(orderItem.cid != nil, @"查询安排信息， orderItem.sid不能为空");
        sid = orderItem.cid;
        preorderType = orderItem.preorderType;
        if (dateString==nil) {
             dateString = orderItem.bookDate;
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?id=%@&type=%i&date=%@", [DataManager shareDataManager].serverAddress, kNewSchedulePath,sid,preorderType,dateString];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSchedulesWithRequest:result preorderType:preorderType callback:^(NSArray *schedules, BOOL success) {
                callback(schedules, success);
            }];
        }else{
            callback(nil, success);
        }
    }];

    return  request;
}

+ (void)convertToSchedulesWithRequest:(DataRequest *)request preorderType:(PreorderType)preorderType callback:(void (^)(NSArray *schedules, BOOL success))callback
{
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    NSMutableArray *schedules = [NSMutableArray array];
    @try {
        for (NSDictionary *schDic in dic[@"result"]) {
            ScheduleItem *schItem = [[ScheduleItem alloc] init];
            schItem.sid = schDic[@"id"];
            schItem.beginTime = schDic[@"beginTime"];
            schItem.address = schDic[@"addressName"];
            schItem.cid = schDic[@"cId"];
            schItem.infoItemType = ((NSNumber *)schDic[@"pointType"]).intValue;
            schItem.preoderType = preorderType;
            schItem.bookNum = schDic[@"bookNum"];
            schItem.bookCode = schDic[@"bookCode"];
            schItem.isGroup = schDic[@"isGroup"];
            
            [schedules addObject:schItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
        schedules = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(schedules, success);
    }
}

#pragma mark 在线预约
+ (DataRequest *)loadPreorderWithScheduleItem:(ScheduleItem *)scheduleItem user:(User *)user num:(NSNumber *)num playDate:(NSDate *)date callback:(void (^)(NSString *code, BOOL success))callback
{
    
    NSAssert(scheduleItem.preoderType == PreorderFilm || scheduleItem.preoderType  == PreorderActivity, @"在线预约，未知的预约类型");
    NSAssert(scheduleItem.sid != nil, @"在线预约, 活动安排或排片id, 不能为空");
    NSAssert(user.sid != nil, @"在线预约, 用户id, 不能为空");
    NSAssert(num != nil && num.integerValue >0 , @"在线预约, 预约数量不能为空且大于0");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPreorderPath];
    
#ifdef Book_Debug
    DataRequest *request = [DataManager requestBookWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPreorderCodeWithRequest:result callback:^(NSString *code, BOOL success) {
                callback(code, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
#else
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPreorderCodeWithRequest:result callback:^(NSString *code, BOOL success) {
                callback(code, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
#endif
    
    [request setPostValue:scheduleItem.sid forKey:@"scheduleId"];
    [request setPostValue:[NSNumber numberWithInteger:scheduleItem.preoderType] forKey:@"type"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:num.stringValue forKey:@"num"];
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormtter stringFromDate:date];
    [request setPostValue:dateString forKey:@"date"];
    
    request.requestMethod = @"POST";

    return request;
}

+ (void)convertToPreorderCodeWithRequest:(DataRequest *)request callback:(void (^)(NSString *code, BOOL success))callback
{
    NSString *code;
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        code = dic[@"result"];
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(code, success);
    }
}


#pragma mark 获取我的预约列表
+ (DataRequest *)loadAppointmentWithUser:(User *)user callback:(void (^)(NSArray *orders, BOOL success))callback
{
    NSAssert(user.sid != nil, @"我的预约列表， user.sid 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/bookList", [DataManager shareDataManager].serverAddress, kMyPreorderPath, (long)user.sid.integerValue];

    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToOrderItemWithRequest:result callback:^(NSArray *orders, BOOL success) {
                callback(orders, success);
            }];
        }else{
            callback(nil, success);
        }
    }];

    return  request;
}

+ (void)convertToOrderItemWithRequest:(DataRequest *)request callback:(void (^)(NSArray *orders, BOOL success))callback
{

    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    NSMutableArray *orders = [NSMutableArray array];
    @try {
        NSDictionary *results = dic[@"result"];
        for (NSDictionary *orderDic in results) {
            OrderItem *orderItem = [[OrderItem alloc] init];
            orderItem.sid = orderDic[@"id"];
            orderItem.scheduleId = orderDic[@"scheduleId"];
            orderItem.preorderType = ((NSNumber *)orderDic[@"type"]).intValue;
            orderItem.cid = orderDic[@"cId"];
            orderItem.name = orderDic[@"name"];
            orderItem.address = orderDic[@"address"];
            orderItem.bookCode = orderDic[@"bookCode"];
            orderItem.bookNum = orderDic [@"bookNum"];
            orderItem.bookDate = orderDic[@"bookDate"];
            orderItem.beginTime = orderDic[@"beginTime"];
            orderItem.check = ((NSNumber *)orderDic[@"check"]).boolValue;
            
            [orders addObject:orderItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(orders, success);
    }
}

#pragma mark 获取电影的详细信息 2015-4-16新增
+ (DataRequest *)loadFilmDetailWithScheduleItemID:(NSNumber *)itemid callback:(void (^)(FilmItem *filmItem, BOOL success))callback {
    NSAssert(itemid != nil, @"获取电影详细信息， itemid不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@?id=%@&type=0", [DataManager shareDataManager].serverAddress, kPreorderDetailPath, itemid];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        //
        if (success) {
            //
            [DataManager convertToFilmItemWithRequest:result callback:^(FilmItem *filmItem, BOOL success) {
                callback(filmItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return  request;
}

///电影详细信息
+ (void)convertToFilmItemWithRequest:(DataRequest *)request  callback:(void (^)(FilmItem *filmItem, BOOL success))callback
{
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    FilmItem *filmItem = [[FilmItem alloc] init];
    @try {
        NSDictionary *filmDic = dic[@"result"];
        filmItem.scheduleId = filmDic[@"id"];
        filmItem.name = filmDic[@"name"];
        filmItem.titlePic =  filmDic[@"image"];
        filmItem.filmType = ((NSNumber *)filmDic[@"filemType"]).intValue;
        filmItem.beginTime = filmDic[@"releaseDate"];
        filmItem.endTime = filmDic[@"endDate"];
        filmItem.playBeginTime = filmDic[@"playBeginTime"];
        filmItem.playTime = filmDic[@"length"];
        filmItem.screenings = filmDic[@"screenings"];
        filmItem.address = filmDic[@"address"];
        filmItem.introduction = filmDic[@"introduction"];
        filmItem.maxBookNum = filmDic[@"maxBookNum"];
        filmItem.bookNum = filmDic[@"bookNum"];
        filmItem.browseNum = filmDic[@"browseNum"];
        filmItem.bookCode = filmDic[@"bookCode"];
        filmItem.bookDate = filmDic[@"bookDate"];
        filmItem.check = ((NSNumber *)filmDic[@"check"]).boolValue;
        
        filmItem.bookId = filmDic[@"bookId"];
        filmItem.cId = filmDic[@"cId"];
        filmItem.infoItemType = ((NSNumber *)filmDic[@"pointType"]).intValue;    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
        filmItem = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(filmItem, success);
    }
}


#pragma mark 获取活动的详细信息 2015-4-16新增
+ (DataRequest *)loadActivityDetailWithScheduleItemID:(NSNumber *)itemid callback:(void (^)(ActivityItem *activityItem, BOOL success))callback {
    NSAssert(itemid != nil, @"获取活动的详细信息， itemid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?id=%@&type=1", [DataManager shareDataManager].serverAddress, kPreorderDetailPath, itemid];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToActivityWithRequest:result callback:^(ActivityItem *activityItem, BOOL success) {
                callback(activityItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToActivityWithRequest:(DataRequest *)request callback:(void (^)(ActivityItem *activityItem, BOOL success))callback
{
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    ActivityItem *actItem = [[ActivityItem alloc] init];
    @try {
        NSDictionary *actDic = dic[@"result"];
        actItem.sid =actDic[@"id"];
        actItem.scheduleId = actDic[@"scheduleId"];
        actItem.name = actDic[@"title"];
        actItem.titlePic =  actDic[@"icon"];
        actItem.pics = actDic[@"pics"];
        actItem.contents = actDic[@"contents"];
        actItem.address = actDic[@"address"];
        actItem.addressType = ((NSNumber *)actDic[@"addressType"]).intValue;
        actItem.activityDate = actDic[@"activityDate"];
        actItem.beginTime = actDic[@"startDate"];
        actItem.endTime = actDic[@"endDate"];
        if ([actItem.endTime rangeOfString:@"00:"].length>0) {
            actItem.endTime = [actItem.endTime stringByReplacingOccurrencesOfString:@"00:" withString:@"24:"];
        }
        actItem.personType = actDic[@"personType"];
        actItem.perseonTypes = actDic[@"personTypes"];
        actItem.maxBookNum = actDic[@"maxBookNum"];
        actItem.bookNum =  actDic[@"bookNum"];
        actItem.browseNum =  actDic[@"browseNum"];
        actItem.bookCode = actDic[@"bookCode"];
        actItem.bookDate = actDic[@"bookdDate"];
        actItem.check = ((NSNumber *)actDic[@"check"]).boolValue;
        
        actItem.bookId = actDic[@"bookId"];
        actItem.cId = actDic[@"cId"];
        actItem.infoItemType = ((NSNumber *)actDic[@"pointType"]).intValue;
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
        actItem = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(actItem, success);
    }
}

#pragma mark 获取信息点的影片或活动信息合集
+ (DataRequest *)loadOrdersWithFloor:(NSInteger)floorCode callback:(void (^)(NSArray *orders, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/mapDisplay", [DataManager shareDataManager].serverAddress, kMyPreorderPath, (long)floorCode];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToOrdersWithRequest:result callback:^(NSArray *orders, BOOL success) {
                NSMutableArray *array = [NSMutableArray array];
                for (OrderItem *oItem in orders) {
                    oItem.floor=floorCode;
                    [array addObject:oItem];
                }
                callback(orders, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToOrdersWithRequest:(DataRequest *)request callback:(void (^)(NSArray *orders, BOOL success))callback
{
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }

    //
    NSMutableArray *orders = [NSMutableArray array];
    @try {
        for (NSDictionary *orderDic in dic[@"result"]) {
            OrderItem *orderItem = [[OrderItem alloc] init];
            
            orderItem.sid = orderDic[@"id"];
            orderItem.scheduleId = orderDic[@"scheduleId"];
            orderItem.preorderType = ((NSNumber *)orderDic[@"type"]).intValue;
            orderItem.cid = orderDic[@"cId"];
            orderItem.name = orderDic[@"name"];
            orderItem.address = orderDic[@"address"];
            orderItem.bookCode = orderDic[@"bookCode"];
            orderItem.bookNum = orderDic [@"bookNum"];
            orderItem.bookDate = orderDic[@"bookDate"];
            orderItem.beginTime = orderDic[@"beginTime"];
            orderItem.check = ((NSNumber *)orderDic[@"check"]).boolValue;
            
            NSNumber *x = orderDic[@"x"];
            NSNumber *y = orderDic[@"y"];
            
            //iphone 调整
            orderItem.pt = CGPointMake(x.floatValue * 0.5f, y.floatValue *0.5f);
            
            [orders addObject:orderItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
        orders = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(orders, success);
    }
}

#pragma mark 取消预约
+ (void)postCancelWithOrder:(OrderItem *)orderItem user:(User *)user callback:(void (^)(BOOL success))callback
{
    NSAssert(orderItem.sid != nil, @"取消预约， orderItem.sid不能为空");
    NSAssert(user.sid != nil, @"取消预约, user.sid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/cancel", [DataManager shareDataManager].serverAddress, kPreorderCancelPath, (long)orderItem.sid.integerValue];
#ifdef Book_Debug
    //TODO: 后台问题，没有测试
    DataRequest *request = [DataManager requestBookWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        callback(success);
    }];
#else
    //TODO: 后台问题，没有测试
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        callback(success);
    }];
#endif
   
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    request.showHUD=NO;
    [request startAsynchronous];
}

#pragma mark 记录浏览数
+ (void)postPreorderBrowseCountWithItem:(NSObject *)item callback:(void (^)(BOOL success))callback
{
#warning 在没有网络的情况下，没有缓存浏览数，丢失浏览数
    NSNumber *sid;
    PreorderType preorderType = PreorderOther;
    
    if ([item isKindOfClass:[FilmItem class]]) {
        sid = ((FilmItem *)item).sid;
        preorderType = PreorderFilm;
    }
    
    if ([item isKindOfClass:[ActivityItem class]]) {
        sid = ((ActivityItem *)item).sid;
        preorderType = PreorderActivity;
    }
    
    if ([item isKindOfClass:[OrderItem class]]) {
        OrderItem *orderItem = (OrderItem *)item;
        NSAssert(orderItem.cid != nil, @"记录浏览数， orderItem.sid不能为空");
        sid = orderItem.cid;
        preorderType = orderItem.preorderType;
    }
    
    NSAssert(sid != nil, @"记录浏览数: 活动或影片id不能为空");
    NSAssert(preorderType != PreorderOther, @"记录浏览数: 未知的预约类型");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPreorderBrowsePath];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {

    }];
    
    request.showHUD = NO;
    [request setRequestMethod:@"POST"];
    [request setPostValue:sid forKey:@"cId"];
    [request setPostValue:[NSNumber numberWithInteger:preorderType] forKey:@"type"];
    [request startAsynchronous];
}

#pragma mark - 投票 （互动社区)
#warning 暂缓开发

#pragma mark - 参观路线 （互动社区)
#pragma mark 根据关键字获取展馆资源
+ (DataRequest *)loadRouteWithKeyword:(NSString *)keyword callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSAssert(keyword != nil && ![keyword isEqualToString:@""], @"根据关键字获取展馆资源， keyword不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?keyword=%@", [DataManager shareDataManager].serverAddress, kRoutesKeywordPath, keyword];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //
            [DataManager convertToInfosWithRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 获取公共设施列表
///根据用户的所在楼层搜索同一楼层的所有公共设施，并按照用户所在位置与公共设施距离由近到远排序。参数x或y坐标为空的情况下视为点击更多查询其他所有楼层的公共设施，不排序
+ (DataRequest *)loadFacilityWithFloor:(FloorType)floor point:(CGPoint)pt callback:(void (^)(NSArray *facilities, BOOL success))callback
{
    //处理CGPointZero
    NSString *urlString;
    if (CGPointEqualToPoint(pt, CGPointZero)) {
        urlString = [NSString stringWithFormat:@"%@%@?fCode=%i", [DataManager shareDataManager].serverAddress, kFacilityPath, floor];
    }else{
        urlString = [NSString stringWithFormat:@"%@%@?fCode=%i&x=%f&y=%f", [DataManager shareDataManager].serverAddress, kFacilityPath, floor, pt.x, pt.y];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //TODO:没有数据,需要修改convertToInfos
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToInfosWithRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 获取推荐路线
+ (DataRequest *)loadRecommendRoutes:(void (^)(NSArray *routes, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kRecommendRoutePath];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToRecommendRouteWithRequest:result callback:^(NSArray *recommends, BOOL success) {
                callback(recommends, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToRecommendRouteWithRequest:(DataRequest *)request callback:(void (^)(NSArray *recommends, BOOL success))callback
{
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //
    NSMutableArray *recommends = [NSMutableArray array];
    @try {
        for (NSDictionary *rDic in dic[@"result"]) {
            RecommendRouteItem  *item= [[RecommendRouteItem alloc] init];
            item.sid = rDic[@"id"];
            item.title = rDic[@"title"];
            item.introduction = rDic[@"introduction"];
           
            NSMutableArray *routeRooms = [NSMutableArray array];
            for (NSDictionary *roomsDic in rDic[@"routeRooms"]) {
                InfoItem *infoItem = [[InfoItem alloc] init];
                infoItem.sid = roomsDic[@"id"];
                infoItem.title = roomsDic[@"name"];
                infoItem.iconPath = roomsDic[@"icon"];
                infoItem.type = [roomsDic[@"type"] intValue];
                [routeRooms addObject:infoItem];
            }
            item.routesRooms = routeRooms;

            [recommends addObject:item];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
        recommends = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(recommends, success);
    }
}

#pragma mark 推荐路线引导点
+ (DataRequest *)loadInfoItemsWithRecommendRoute:(RecommendRouteItem *)recommendRouteItem callback:(void (^)(NSArray *infos, BOOL successs))callback
{
    NSAssert(recommendRouteItem.sid != nil, @"获取推荐路线引导点， recommendRouteItem.sid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li", [DataManager shareDataManager].serverAddress, kRecommendRoutePath, (long)recommendRouteItem.sid.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToInfosWithRecommedRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToInfosWithRecommedRequest:(DataRequest *)request callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSMutableArray *infos = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *infoDic in dic[@"result"]) {
            InfoItem *iItem = [[InfoItem alloc] init];
            iItem.floorCode = infoDic[@"fCode"];
            NSNumber *x = infoDic[@"x"];
            NSNumber *y = infoDic[@"y"];
            //iPhone 调整
            iItem.pt = CGPointMake(x.floatValue * 0.5, y.floatValue * 0.5);
            [infos addObject:iItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(infos, success);
    }
}

#pragma mark 最热门参观路线
+ (DataRequest *)loadPraiseRoute:(void (^)(NSArray *infos, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPraiseRoutePath];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //
            [DataManager convertToInfosWithPraiseRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}


+ (void)convertToInfosWithPraiseRequest:(DataRequest *)request callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSMutableArray *infos = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *infoDic in dic[@"result"]) {
            InfoItem *iItem = [[InfoItem alloc] init];
            iItem.sid = infoDic[@"id"];
            iItem.title = infoDic[@"name"];
            iItem.iconPath = infoDic[@"icon"];
            iItem.praise = infoDic[@"praiseNum"];
            iItem.floorCode = (NSNumber *)infoDic[@"floorCode"];
            iItem.type = ((NSNumber *)infoDic[@"type"]).intValue;
            [infos addObject:iItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(infos, success);
    }
}

#pragma mark 最热门参观引导点
+ (DataRequest *)loadPraiseRouteInfoItems:(void (^)(NSArray *infos, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPraiseRouteGuidePath];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToInfosWithRecommedRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 用户自定义寻路
+ (DataRequest *)loadPathWithFloor:(FloorType)floor point:(CGPoint)point targetInfoItem:(InfoItem *)infoItem callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSAssert(infoItem.sid != nil, @"用户自定义寻路, infoItem.sid 不能为空");
    NSAssert(infoItem.type == InfoItemSpecimen || infoItem.type == InfoItemExhibit || infoItem.type == InfoItemRemoteVideo || InfoItemShowroom, @"用户自定义寻路, infoItem.type 必须为标本背后故事、展品、远程视屏或展区");
    
    NSString *urlString;
    if (CGPointEqualToPoint(point, CGPointZero)) {
        urlString =[NSString stringWithFormat:@"%@%@?fCode=%i&type=%i&cid=%li&isIn=%i", [DataManager shareDataManager].serverAddress, kFindingPath, floor, infoItem.type, (long)infoItem.sid.integerValue, 1];
    }else{
        urlString =[NSString stringWithFormat:@"%@%@?x=%f&y=%f&fCode=%i&type=%i&cid=%li&isIn=%i", [DataManager shareDataManager].serverAddress, kFindingPath, point.x, point.y, floor, infoItem.type, (long)infoItem.sid.integerValue, 1];
    }
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //
            [DataManager convertToInfosWithRecommedRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 自定义规化路线
+ (DataRequest *)loadCustomRouteWithFloor:(FloorType)floor point:(CGPoint)point routes:(NSArray *)infos callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSAssert(infos != nil && infos.count > 0, @"自定义规划路线，routes不能为空");
    
    NSString *routeString = @"";
    for (InfoItem *item in infos) {
        NSNumber *type = [NSNumber numberWithInteger:item.type];
        routeString = [routeString stringByAppendingString:type.stringValue];
        routeString = [routeString stringByAppendingString:@","];
        routeString = [routeString stringByAppendingString:item.sid.stringValue];
        routeString = [routeString stringByAppendingString:@";"];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?x=%f&y=%f&fCode=%i&routs=%@&isIn=%i", [DataManager shareDataManager].serverAddress, kCustomRoutePath, point.x, point.y, floor, routeString, 1];

    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToInfosWithRecommedRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else
        {
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 10.9 保存用户自定义路线
+ (void)postCustomRoutes:(NSArray *)infos user:(User *)user routeName:(NSString *)routeName callback:(void (^)(BOOL saved, BOOL success))callback
{
    NSAssert(infos.count > 0, @"保存自定义路线， 路线不能为空");
    NSAssert(user.sid != nil, @"保存自定义路线， user不能为空");
    NSAssert(routeName.length > 0, @"保存自定义路线， 路线名不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kCustomRoutePath];
    
    NSString *routeString = @"";
    for (InfoItem *item in infos) {
        NSNumber *type = [NSNumber numberWithInteger:item.type];
        routeString = [routeString stringByAppendingString:type.stringValue];
        routeString = [routeString stringByAppendingString:@","];
        routeString = [routeString stringByAppendingString:item.sid.stringValue];
        routeString = [routeString stringByAppendingString:@";"];
    }
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        //
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:routeName forKey:@"routeName"];
    [request setPostValue:routeString forKey:@"routs"];
    [request setRequestMethod:@"POST"];
    
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    [request setStringEncoding:enc];
    request.showHUD=NO;
    [request startAsynchronous];
}

#pragma mark 10.10 获取用户保存的自定义路线
+ (DataRequest *)loadUserCustomRouteWithUser:(User *)user callback:(void (^)(NSArray *routes, BOOL success))callback
{
    NSAssert(user.sid != nil, @"获取用户保存的自定义路线， 用户不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i", [DataManager shareDataManager].serverAddress, kUserPath, user.sid.intValue];
    DataRequest *requset = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToRoutesWithRequest:result callback:^(NSArray *routes, BOOL success) {
                callback(routes, success);
            }];
        }else{
            callback(nil, success);
        }

    }];
    
    return requset;
}

+ (void)convertToRoutesWithRequest:(DataRequest *)request callback:(void (^)(NSArray *routes, BOOL success))callback
{
    
    NSMutableArray *routes = [NSMutableArray array];

    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    
    //格式错误
    @try {
        NSArray *results = dic[@"result"];
        
        for (NSDictionary *customRouteDic in results) {
            CustomRouteItem *customRouteItem = [[CustomRouteItem alloc] init];
            customRouteItem.sid = customRouteDic[@"id"];
            customRouteItem.title = customRouteDic[@"title"];
            NSTimeInterval time = ((NSNumber *)customRouteDic[@"createDate"]).integerValue / 1000.0f;
            customRouteItem.createDate = [NSDate dateWithTimeIntervalSince1970:time];
            
            NSMutableArray *routePaths = [NSMutableArray array];
            NSArray *list = customRouteDic[@"list"];
            for (NSDictionary *routeDic in list) {
//                RouteItem *routeItem  = [[RouteItem alloc] init];
//                routeItem.name = routeDic[@"name"];
//                routeItem.titlePic = routeDic[@"titlePic"];
//                routeItem.sequence = routeDic[@"sequence"];
//                routeItem.infoId = routeDic[@"entityId"];
//                routeItem.infotype = ((NSNumber *)routeDic[@"entityType"]).intValue;
                InfoItem *infoItem = [[InfoItem alloc] init];
                infoItem.title = routeDic[@"name"];
                infoItem.iconPath = routeDic[@"titlePic"];
                infoItem.sid = routeDic[@"entityId"];
                infoItem.type = ((NSNumber *)routeDic[@"entityType"]).intValue;
                
                [routePaths addObject:infoItem];
            }
            
            customRouteItem.routes = routePaths;
            [routes addObject:customRouteItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(routes, success);
    }
}

#pragma mark 10.11 删除用户自定义路线
+ (void)deleteCustomRoute:(CustomRouteItem *)customRouteItem callback:(void (^)(BOOL deleted, BOOL success))callback
{
    NSAssert(customRouteItem.sid != nil, @"删除用户自定义路线, 路线id 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i", [DataManager shareDataManager].serverAddress, kCustomRoutePath, customRouteItem.sid.intValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success)
        {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];

    request.showHUD=NO;
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];
}

#pragma mark - 寻宝游戏
#pragma mark  6.1 查询所有游戏主题
+ (DataRequest *)loadGameThemes:(void (^)(NSArray *themes, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kGameThemesPath];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToThemesWithRequest:result callback:^(NSArray *themes, BOOL success) {
                callback(themes, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return  request;
}

+ (void)convertToThemesWithRequest:(DataRequest *)request callback:(void (^)(NSArray *themes, BOOL success))callback
{
    NSMutableArray *themes = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        NSDictionary *results = dic[@"result"];
        for (NSDictionary *themeDic in results) {
            GameThemeItem *themeItem = [[GameThemeItem alloc] init];
            themeItem.sid = themeDic[@"id"];
            themeItem.title = themeDic[@"title"];
            themeItem.titlePic = themeDic[@"titlePic"];
            themeItem.introduction = themeDic[@"introduction"];
            
            [themes addObject:themeItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(themes, success);
    }
}

#pragma mark  6.2 游戏任务列表
+ (DataRequest *)loadGameTasksWithTheme:(GameThemeItem *)themeItem user:(User *)user callback:(void (^)(NSArray *gameTasks, BOOL success))callback
{
    NSAssert(themeItem.sid != nil, @"获取游戏任物列表， themeItem.sid 不能为空");
    NSString *urlString;
    if (user == nil) {
        urlString = [NSString stringWithFormat:@"%@%@/%li/taskList", [DataManager shareDataManager].serverAddress, kGameTaskPath, (long)themeItem.sid.integerValue];
    }else
    {
        urlString = [NSString stringWithFormat:@"%@%@/%li/taskList?userId=%i", [DataManager shareDataManager].serverAddress, kGameTaskPath, (long)themeItem.sid.integerValue, user.sid.intValue];
    }
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToTasksWithRequest:result callback:^(NSArray *gameTasks, BOOL success) {
                callback(gameTasks, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToTasksWithRequest:(DataRequest *)request callback:(void (^)(NSArray *gameTasks, BOOL success))callback
{
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    NSMutableArray *tasks = [NSMutableArray array];
    @try {
        NSDictionary *results = dic[@"result"];
        for (NSDictionary *taskDic in results) {
            GameTaskItem *taskItem = [[GameTaskItem alloc] init];
            taskItem.sid = taskDic[@"id"];
            taskItem.tid = taskDic[@"tid"];
            taskItem.title = taskDic[@"title"];
            taskItem.prompt = taskDic[@"prompt"];
            taskItem.titlePic = taskDic[@"titlePic"];
            taskItem.desc = taskDic[@"description"];
            taskItem.score = taskDic[@"score"];
            taskItem.status = ((NSNumber *)taskDic[@"status"]).boolValue;
            
            [tasks addObject:taskItem];
        }
    }
    @catch (NSException *exception) {
        message = exception.description;
        success = NO;
        tasks = nil;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(tasks, success);
    }

}

#pragma mark 游戏任务相关展品的信息点
+ (DataRequest *)loadExhibitsWithGameTheme:(GameThemeItem *)themeItem callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSAssert(themeItem.sid != nil, @"获取游戏任务相关展品的信息点， themeItem.sid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/exhibitList", [DataManager shareDataManager].serverAddress, kGamePath, (long)themeItem.sid.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToInfosWithGameRequest:result callback:^(NSArray *infos, BOOL success) {
                callback(infos, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToInfosWithGameRequest:(DataRequest *)request callback:(void (^)(NSArray *infos, BOOL success))callback
{
    NSMutableArray *infos = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *infoDic in dic[@"result"]) {
            InfoItem *iItem = [[InfoItem alloc] init];
            iItem.sid = infoDic[@"id"];
            iItem.title = infoDic[@"title"];
            iItem.iconPath = infoDic[@"icon"];
            iItem.relationId = infoDic[@"relationshipId"];
            iItem.gameTaskId = infoDic[@"gameTaskId"];
            NSNumber *x = infoDic[@"x"];
            NSNumber *y = infoDic[@"y"];
            //iPhone 调整
            iItem.pt = CGPointMake(x.floatValue * 0.5f, y.floatValue * 0.5f);
            iItem.floorCode = infoDic[@"floorCode"];
            
            [infos addObject:iItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(infos, success);
    }
}

#pragma mark 游戏开始
+ (DataRequest *)postGameStart:(GameTaskItem *)taskItem user:(User *)user callback:(void (^)(BOOL start, BOOL success))callback
{
    NSAssert(taskItem.sid != nil, @"游戏开始，taskItem.sid不能为空");
    NSAssert(user.sid != nil, @"游戏开始，user.sid不能为空");
#warning 后台没有放弃游戏接口，重复开始同一个游戏返回错误代码-1, (后台开发沟通不畅，放弃沟通）
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/start?userId=%li", [DataManager shareDataManager].serverAddress, kGamePath, (long)taskItem.sid.integerValue, (long)user.sid.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
            callback(found, success);
        }];
    }];
    return request;
}

#pragma mark Game Check
+ (DataRequest *)loadCheckWithGameTask:(GameTaskItem *)taskItem user:(User *)user infoItem:(InfoItem *)infoItem callback:(void (^)(BOOL found, BOOL success))callback
{
    NSAssert(taskItem.sid != nil, @"Game check, taskItem.sid不能为空");
    NSAssert(user.sid != nil,  @"Game check, user.sid不能为空");
    NSAssert(infoItem.sid != nil,  @"Game check, infoItem.sid不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/check?userId=%li&exhibitId=%li", [DataManager shareDataManager].serverAddress, kGamePath, (long)taskItem.sid.integerValue, (long)user.sid.integerValue, (long)infoItem.relationId.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
        
    }];
    
    request.cache = NO;
    return request;
}

+ (void)convertToSuccessWithRequest:(DataRequest *)request callback:(void (^)(BOOL found, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        
        BOOL found = NO;
        if (success) {
            @try {
                NSNumber *code = dic[@"code"];
                if (code.integerValue == 1 ) {
                    found = YES;
                }
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
            }
            @finally {
                if (request.showError && !success) {
                    [DataManager showMessage:message dur:request.errorDur];
                }
            }
        }
        
        callback(found, success);
    }];
}

#pragma mark 游戏统计
+ (DataRequest *)loadGameStatisticalWithUser:(User *)user callback:(void (^)(NSArray *records, BOOL success))callback
{
    NSAssert(user.sid != nil, @"获取游戏统计， user.sid不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/statistical?userId=%li", [DataManager shareDataManager].serverAddress, kGamePath, (long)user.sid.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        //
        NSLog(@"result %@", result.responseString);
        if (success){
            [DataManager convertToGameRecordWithRequest:result callback:^(NSArray *records, BOOL success) {
                callback(records, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToGameRecordWithRequest:(DataRequest *)request callback:(void (^)(NSArray *records, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        if (success) {
            NSMutableArray *records = nil;
            @try {
                NSArray *gameTasks = dic[@"gameTasks"];
                records = [NSMutableArray arrayWithCapacity:gameTasks.count];
                for (NSDictionary *rDic in gameTasks) {
                    GameRecordItem *record = [[GameRecordItem alloc] init];
                    record.title = rDic[@"title"];
                    record.iconPic = rDic[@"titlePic"];
                    record.timeCosuming = rDic[@"usedTime"];
                    NSTimeInterval interval = ((NSNumber *)rDic[@"compelteDate"]).doubleValue/1000.0;
                    record.date = [NSDate dateWithTimeIntervalSince1970:interval];
                    record.level = rDic[@"overMe"];
                    
                    [records addObject:record];
                }
            }
            @catch (NSException *exception) {
                success = NO;
                message = exception.description;
                records = nil;
            }
            @finally {
                if (!success && request.showError) {
                    [DataManager showMessage:message dur:request.errorDur];
                }
                callback(records, success);
            }
        }
    }];
}

#pragma mark 保存当前游戏任务
+ (void)saveGame:(Game *)game;
{
    NSData *gameData = [NSKeyedArchiver archivedDataWithRootObject:game];
    [[NSUserDefaults standardUserDefaults] setObject:gameData forKey:kGameTask];
}

#pragma mark 获取当前游戏任务
+ (Game *)getGame
{
    NSData *gameData = [[NSUserDefaults standardUserDefaults] objectForKey:kGameTask];
    Game *game = [NSKeyedUnarchiver unarchiveObjectWithData:gameData];
    
    return game;
}

#pragma mark - 评论
#pragma mark 11.1 获取展品评论列表

//#pragma mark 11.2 获取展品评论详细信息
//+ (DataRequest *)loadCommentDetailWithInfoItem:(InfoItem *)infoItem callback:(void (^)(CommentItem *commentItem, DataRequest *request, BOOL success))callback
//{
//    //NSAssert(infoItem.relationId != nil, @"获取展品评论详细信息，infoItem.sid不能为空" );
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/comment", [DataManager shareDataManager].serverAddress, kExhibitCommentPath, (long)infoItem.relationId.integerValue];
//    __autoreleasing DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
//        if(success)
//        {
//            [DataManager convertToCommentWithRequest:result callback:^(CommentItem *commentItem, BOOL success) {
//                callback(commentItem, result, success);
//            }];
//
//        }else
//        {
//            callback(nil, result, success);
//        }
//    }];
//    
//    return request;
//}


//#pragma mark 11.3 提交展品评论
//+ (DataRequest *)postComment:(CommentContent *)commentContent user:(User *)user callback:(void (^)(BOOL post, BOOL success))callback
//{
//    NSAssert(user.sid != nil, @"提交展品评论， user.sid不能为空");
//    NSAssert(commentContent.content.length > 0, @"提交展品评论， 评论不能为空");
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/comment", [DataManager shareDataManager].serverAddress, kExhibitCommentPath, (long)user.sid.integerValue];
//    
//    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
//        if (success) {
//            //
//            [DataManager convertToSuccessWithRequest:result callback:^(BOOL post, BOOL success) {
//                callback(post, success);
//            }];
//        }else{
//            callback(NO, success);
//        }
//    }];
//    
//    request.requestMethod = @"POST";
//    return request;
//}


#pragma mark - 互动社区
#pragma mark 大家来吐槽
#pragma mark 提交用户发帖
+ (DataQueue *)postComplain:(PostItem *)postItem callback:(void (^)(BOOL posted, BOOL success))callback
{
    //首先上传图片
    DataQueue *queue = [DataManager postPics:postItem.images callback:^(NSArray *picPaths, BOOL success) {
        if (success) {
            //构造路径
            NSString *pathString = @"";
            for (NSString *picString in picPaths) {
                pathString =  [pathString stringByAppendingString:picString];
                pathString = [pathString stringByAppendingString:@","];
            }
            
            //发帖
            NSString *urlString = [NSString stringWithFormat:@"%@%@/post", [DataManager shareDataManager].serverAddress, kComplainPath];
            DataRequest *requestPic = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
                if (success) {
                    //
                    [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                        callback(found, success);
                    }];
                    
                }else{
                    callback(NO, success);
                }
                
            }];
            
            [requestPic setRequestMethod:@"POST"];
            [requestPic setPostValue:postItem.title forKey:@"title"];
            [requestPic setPostValue:postItem.content forKey:@"postContent"];
            [requestPic setPostValue:postItem.user.sid forKey:@"userId"];
            
            
            
            [requestPic setPostValue:pathString forKey:@"pics"];
            
            [requestPic startAsynchronous];
            
            
        }else{
            callback(NO, success);
        }
    }];
    
    
    return queue;
}

#pragma mark 提交用户发帖回帖
+ (DataRequest *)replyComplainWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.sid != nil, @"回帖， user.sid不能为空");
    NSAssert(postItem.sid != nil, @"回帖， postItem.sid不能为空");
    NSAssert(postItem.replyContent.length > 0, @"回帖， postItem.replyContent 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/reply", [DataManager shareDataManager].serverAddress, kComplainPath, (long)postItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL posted, BOOL success) {
                callback(posted, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:postItem.replyContent forKey:@"replyContent"];
    return  request;
}

#pragma mark 随手拍
#pragma mark 11.4 提交随手拍发帖
+ (DataQueue *)postTakePhoto:(PostItem *)postItem callback:(void (^)(BOOL posted, BOOL success))callback
{
    //首先上传图片
    DataQueue *queue = [DataManager postPics:postItem.images callback:^(NSArray *picPaths, BOOL success) {
        if (success) {
            //构造路径
            NSString *pathString = @"";
            for (NSString *picString in picPaths) {
                pathString =  [pathString stringByAppendingString:picString];
                pathString = [pathString stringByAppendingString:@","];
            }

            //发帖
            NSString *urlString = [NSString stringWithFormat:@"%@%@/post", [DataManager shareDataManager].serverAddress, kTakePhotoPath];
            DataRequest *requestPic = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
                if (success) {
                    //
                    [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                        callback(found, success);
                    }];
                    
                }else{
                    callback(NO, success);
                }
                
            }];
            
            [requestPic setRequestMethod:@"POST"];
            [requestPic setPostValue:postItem.title forKey:@"title"];
            [requestPic setPostValue:postItem.content forKey:@"postContent"];
            [requestPic setPostValue:postItem.user.sid forKey:@"userId"];
            
            
            
            [requestPic setPostValue:pathString forKey:@"pics"];
            
            [requestPic startAsynchronous];
            
            
        }else{
            callback(NO, success);
        }
    }];
    
    
    return queue;
}

#pragma mark 11.5 提交随手拍回帖
+ (DataRequest *)replyTakephotoWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.sid != nil, @"回帖， user.sid不能为空");
    NSAssert(postItem.sid != nil, @"回帖， postItem.sid不能为空");
    NSAssert(postItem.replyContent.length > 0, @"回帖， postItem.replyContent 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/reply", [DataManager shareDataManager].serverAddress, kTakePhotoPath, (long)postItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL posted, BOOL success) {
                callback(posted, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:postItem.replyContent forKey:@"replyContent"];
    return  request;
}

#pragma mark 11.6 获取大家来吐槽 列表
//+ (DataRequest *)loadComplainWithType:(ComplainCatalogType)complainType page:(NSInteger)currentPage pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback
//{
//    NSString *urlString;
//    if (complainType == ComplainAll) {
//        urlString  = [NSString stringWithFormat:@"%@%@/posts?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kComplainPath, (long)currentPage, (long)pageSize];
//    }else
//    {
//        urlString  = [NSString stringWithFormat:@"%@%@/posts?currentpage=%li&pagesize=%li&sourcetype=%i", [DataManager shareDataManager].serverAddress, kComplainPath, (long)currentPage, (long)pageSize, complainType];
//    }
//    
//    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
//        if (success) {
//            [DataManager convertToPostsWithRequest:result postType:PostComplain callback:^(PageItem *pageItem, BOOL success) {
//                callback(pageItem, success);
//            }];
//        }else{
//            callback(nil, success);
//        }
//    } ];
//    
//    return request;
//    
//}

#pragma mark 大家来吐槽 搜索指定
+ (DataRequest *)loadComplainWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)currentPage pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSString *urlString;
    if (keyword != nil) {
        urlString = [NSString stringWithFormat:@"%@%@/posts?currentpage=%li&pagesize=%li&title=%@", [DataManager shareDataManager].serverAddress, kComplainPath, (long)currentPage, (long)pageSize, keyword];
    }
    
    if (user.sid != nil) {
        urlString = [NSString stringWithFormat:@"%@%@/posts?currentpage=%li&pagesize=%li&userId=%li", [DataManager shareDataManager].serverAddress, kComplainPath, (long)currentPage, (long)pageSize, (long)user.sid.integerValue];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostComplain callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, success);
        }
    } ];
    
    return request;
}

#pragma mark 兴趣小组
#pragma mark 12.1 兴趣小组 查询
+ (DataRequest *)loadInterestGroupWithPage:(NSInteger)currentPage pagesize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem,  BOOL success))callback
{
    //status 1 已审核   2已通过
    int status = 2;
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kInterestGroupPath, status, (long)currentPage, (long)pageSize];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success)
        {
            [DataManager convertToGroupWithRequest:result callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else
        {
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToGroupWithRequest:(DataRequest *)request callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        if (success) {
            //
            PageItem *pItem = nil;
            @try {
                pItem = [[PageItem alloc] init];
                pItem.total = dic[@"result"][@"total"];
                pItem.pageSize = dic[@"result"][@"pagesize"];
                pItem.currentPage = dic[@"result"][@"currentpage"];
                
                NSMutableArray *datas = [NSMutableArray array];
                for (NSDictionary *groupDic in dic[@"result"][@"data"]) {
                    InterestGroupItem *gItem = [[InterestGroupItem alloc] init];
                    gItem.sid = groupDic[@"id"];
                    gItem.name = groupDic[@"name"];
                    gItem.introduce = groupDic[@"introduce"];
                    gItem.vote = groupDic[@"vote"];
                    gItem.thumb = groupDic[@"titlePic"];
  
                    //创建人
                    User *user = [[User alloc] init];
                    user.sid = groupDic[@"userId"];
                    user.portraitPath = groupDic[@"portrait"];
                    
                    user.nickname = groupDic[@"creator"];
                    
                    gItem.user = user;
                    gItem.date = [NSDate dateWithTimeIntervalSince1970:((NSNumber *)groupDic[@"createTime"]).integerValue /1000.0f];
                    
                    
                    ///回复信息
                    gItem.replyTotal = groupDic[@"totalPostNum"];
                    
                    ///回复时间
                    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *dateString = groupDic[@"lastPostDate"];
                    gItem.replyDate = [dateFormatter dateFromString:dateString];
                    
                    ///
                    User *replyUser = [[User alloc] init];
                    replyUser.sid = groupDic[@"lastUserId"];
                    replyUser.nickname = groupDic[@"lastUserName"];
                    
                    gItem.replyUser = replyUser;
                    
                    [datas addObject:gItem];
                }
                pItem.datas = datas;
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
                pItem = nil;
            }
            @finally {
                if (request.showError && !success) {
                    [DataManager showMessage:message dur:request.errorDur];
                }
                
                callback(pItem, success);
            }
        }
    }];
}

#pragma mark 12.2 兴趣小组 加入
+ (DataRequest *)joinInterestGroup:(InterestGroupItem *)groupItem user:(User*)user callback:(void (^)(BOOL joined, BOOL success))callback
{
    NSAssert(user.sid != nil, @"加入兴趣小组， user.sid 不能为空");
    NSAssert(groupItem.sid != nil, @"加入兴趣小组， groupItem.sid 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/join", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)groupItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL joined, BOOL success) {
                callback(joined, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    [request setPostValue:user.sid forKey:@"userId"];
    //0:普通会员 1：管理员 2：组长;默认0
    [request setPostValue:@0 forKey:@"type"];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark 12.3 兴趣小组 发帖权限
+ (DataRequest *)loadInterestGroupIsJoinedWithUser:(User *)user group:(InterestGroupItem *)groupItem callback:(void (^)(BOOL joined, BOOL success))callback
{
    NSAssert(user.sid != nil, @"检查兴趣小组权限， user.sid 不能为空");
    NSAssert(groupItem.sid != nil, @"检查兴趣小组权限， groupItem.sid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/post/check?userId=%li", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)groupItem.sid.integerValue, (long)user.sid.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL joined, BOOL success) {
                callback(joined, success);
            }];
        }else{
            callback (NO, success);
        }
    }];

    return request;
}

#pragma mark 12.4 兴趣小组 发帖
+ (DataQueue *)postInterestWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.sid != nil, @"发帖， user.sid不能为空");
    NSAssert(postItem.typeId != nil, @"发帖， postItem.typeId不能为空");
    NSAssert(postItem.title.length > 0, @"发帖， postItem.title 不能为空");
    NSAssert(postItem.content.length > 0, @"发帖， postItem.contetnt 不能为空");
    
    
    //首先上传图片
    DataQueue *queue = [DataManager postPics:postItem.images callback:^(NSArray *picPaths, BOOL success) {
        if (success) {
            
            //构造路径
            NSString *pathString = @"";
            for (NSString *picString in picPaths) {
                pathString =  [pathString stringByAppendingString:picString];
                pathString = [pathString stringByAppendingString:@","];
            }
    
            NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/post", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)postItem.typeId.integerValue];
            DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
                if (success) {
                    [DataManager convertToSuccessWithRequest:result callback:^(BOOL posted, BOOL success) {
                        callback(posted, success);
                    }];
                }else{
                    callback(NO, success);
                }
            }];
            
            [request setRequestMethod:@"POST"];
            [request setPostValue:user.sid forKey:@"userId"];
            [request setPostValue:postItem.content forKey:@"postContent"];
            [request setPostValue:postItem.title forKey:@"title"];
            [request setPostValue:pathString forKey:@"pics"];
            
            [request startAsynchronous];
            
        }else{
            callback(NO, success);
        }
    }];
    
    return queue;
}

#pragma mark 12.5 兴趣小组 回帖
+ (DataRequest *)replyInterestWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.sid != nil, @"回帖， user.sid不能为空");
    NSAssert(postItem.sid != nil, @"回帖， postItem.sid不能为空");
    NSAssert(postItem.replyContent.length > 0, @"回帖， postItem.replyContent 不能为空");
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/reply", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)postItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL posted, BOOL success) {
                callback(posted, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:postItem.replyContent forKey:@"replyContent"];
    return  request;
}

#pragma mark 12.6 兴趣小组 投票
+ (DataRequest *)postVoteWithInterestGroup:(InterestGroupItem *)groupItem callback:( void (^)(BOOL voted, BOOL success))callback
{
    NSAssert(groupItem.sid != nil, @"投票，groupItem.sid不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/vote", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)groupItem.sid.integerValue];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL voted, BOOL success) {
                callback(voted, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark 兴趣小组发帖查询
+ (DataRequest *)loadPostsWithInterestGroup:(InterestGroupItem *)groupItem catalog:(PostCatalogType)postCatalogType page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSAssert(groupItem.sid != nil, @"兴趣小组， 查询发帖groupItem.sid不能为空");
    if (page == 1 || page == 0) {
        //1、 首先查询置顶
        NSString *urlStickString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&type=%i&interestgroupId=%li", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long) pagesize, (long)page, PostCatalogStick, (long)groupItem.sid.integerValue];
        
        DataRequest *requestStick = [DataManager requestWithURL:[NSURL URLWithString:urlStickString] callback:^(DataRequest *result, BOOL success) {
            if (success) {
                [DataManager convertToPostsWithRequest:result postType:PostInterestGroup callback:^(PageItem *pageItem, BOOL success) {
                    //callback(pageItem, success);
                    //获取了置顶的帖子
                    NSArray *stickPosts = pageItem.datas;
                    //2、查询
                    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/posts?pagesize=%li&currentpage=%li&type=%i", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)groupItem.sid.integerValue,(long) pagesize, (long)page, postCatalogType];
                    
                    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
                        if (success) {
                            [DataManager convertToPostsWithRequest:result postType:PostInterestGroup callback:^(PageItem *pageItem, BOOL success) {
                                //3、插入置顶
                                if (stickPosts != nil)
                                {
                                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, stickPosts.count)];
                                    [pageItem.datas insertObjects:stickPosts atIndexes:indexSet];
                                }
                                callback(pageItem, success);
                                
                            }];
                        }else{
                            callback(nil, success);
                        }
                    }];
                    
                    request.showHUD = NO;
                    [request startAsynchronous];
                    
                }];
                
            }else{
                callback(nil, success);
            }
        }];
        
         return requestStick;
    }else{
        //2、查询
        NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/posts?pagesize=%li&currentpage=%li&type=%i", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)groupItem.sid.integerValue,(long) pagesize, (long)page, postCatalogType];
        
        DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
            if (success) {
                [DataManager convertToPostsWithRequest:result postType:PostInterestGroup callback:^(PageItem *pageItem, BOOL success) {
                    callback(pageItem, success);
                    
                }];
            }else{
                callback(nil, success);
            }
        }];
        
        return request;

    }
}

#pragma mark 兴趣小组 搜索指定内容
+ (DataRequest *)loadInterestPostWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSString *urlString;
    if (keyword != nil) {
        //搜索指定帖子
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&title=%@", [DataManager shareDataManager].serverAddress, kInterestGroupPath,(long) pagesize, (long)page, keyword];
    }
    if (user.sid != nil) {
        //搜索指定人
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&userId=%li", [DataManager shareDataManager].serverAddress, kInterestGroupPath,(long) pagesize, (long)page, (long)user.sid.integerValue];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostInterestGroup callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToPostsWithRequest:(DataRequest *)request postType:(PostType)postType callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        PageItem *pageItem = nil;
        if (success) {
            @try {
                //后台是两个浆糊做的，部分接口返回相同的属性，可能使用不同的名称 ：）
                pageItem = [[PageItem alloc] init];
                //后台total 发过来是 string T_T
                NSString  *totalString = dic[@"result"][@"total"];
                pageItem.total = [NSNumber numberWithInteger:totalString.integerValue];
                pageItem.pageSize = dic[@"result"][@"pagesize"];
                pageItem.currentPage = dic[@"result"][@"currentpage"];
                
                NSMutableArray *posts = [NSMutableArray array];
                for (NSDictionary *pDic in dic[@"result"][@"data"]) {
                    PostItem *pItem = [[PostItem alloc] init];
                    pItem.sid = pDic[@"id"];
                    pItem.rid = pDic[@"replyId"];
                    pItem.title = pDic[@"title"];
                    
                    if (pDic[@"postContent"] != nil) {
                        pItem.content = pDic[@"postContent"];
                    }
                    if (pDic[@"replyContent"] != nil) {
                        pItem.content = pDic[@"replyContent"];
                    }
                    if (pDic[@"content"] != nil) {
                        //我的回复接口 返回的...
                        pItem.content = pDic[@"content"];
                    }
                    
                    pItem.picPaths = pDic[@"pics"];
                    
                    //发帖时间
                    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *dateString = pDic[@"postDate"];
                    pItem.date = [dateFormatter dateFromString:dateString];
                    if (pDic[@"createTime"] != nil) {
                        NSNumber *createTime = pDic[@"createTime"];
                        pItem.date  = [NSDate dateWithTimeIntervalSince1970:createTime.floatValue/1000.0f];
                    }
                    
                    //点赞数量
                    pItem.praiseNum = pDic[@"praiseNum"];
                    pItem.isEssence = ((NSNumber *)pDic[@"isEssence"]).boolValue;
                    pItem.isHot = ((NSNumber *)pDic[@"isHot"]).boolValue;
                    
                    //发帖人
                    User *user = [[User alloc] init];
                    user.sid = pDic[@"postUserId"];
                    
                    //后台不同接口返回的相同sid
                    if (pDic[@"userId"] !=nil) {
                        user.sid = pDic[@"userId"];
                    }
                    
                    if (pDic[@"postUserName"] != nil) {
                        user.nickname = pDic[@"postUserName"];
                    }
                    
                    if ( pDic[@"postPortrait"] != nil) {
                        user.portraitPath = pDic[@"postPortrait"];
                    }
                    
                    if ( pDic[@"userName"] != nil) {
                        user.nickname = pDic[@"userName"];
                    }
                    
                    if (pDic[@"portrait"] != nil) {
                        user.portraitPath = pDic[@"portrait"];
                    }
                    
                    pItem.user = user;
                    
                    //帖子浏览数量
                    pItem.browseNum  = pDic[@"browseNum"];
                    
                    pItem.replyTotal = pDic[@"replyTotal"];
                    
                    //回复人
                    User *replyUser = [[User alloc] init];
                    replyUser.sid = pDic[@"replyUserId"];
                    replyUser.nickname = pDic[@"replyUserName"];
                    pItem.replyUser = replyUser;
                    
                    //最后回复时间
                    pItem.replyDate = [dateFormatter dateFromString:pDic[@"replyDate"]];
                    //
                    pItem.postSourceType = ((NSNumber *)pDic[@"type"]).intValue;
                    
                    //
                    pItem.postType = postType;
                    if (postType == PostUnkown && pDic[@"type"] != nil) {
                        pItem.postType = ((NSNumber *)pDic[@"type"]).intValue;
                    }
                    
                    //评论对象id
                    NSString *entityIdString = (NSString *)pDic[@"entityId"];
                    if (entityIdString != nil) {
                        pItem.postEntityId = [NSNumber numberWithInteger:entityIdString.integerValue];
                    }else{
                        pItem.postEntityId = nil;
                    }
                    
                    //评论对象类型
                    NSString *entityType = (NSString *)pDic[@"entityType"];
                    if (entityType != nil) {
                        pItem.postEntityType = entityType.intValue;
                    }else{
                        pItem.postEntityType = -1;
                    }
                    
                    //兴趣小组id
                    pItem.typeId = pDic[@"groupId"];
                    
                    //最佳回复
                    pItem.replyType = ((NSNumber *)pDic[@"isCorrect"]).integerValue;
                    //
                    [posts addObject:pItem];
                }
                pageItem.datas = posts;
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
                pageItem = nil;
            }
            @finally {
                if (request.showError && !success) {
                    [DataManager showMessage:message dur:request.errorDur];
                }
            }
            
        }
        
        callback(pageItem, success);
    }];
}

#pragma mark 12.8 回帖查询
+ (DataRequest *)loadReplyWithPost:(PostItem *)postItem page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSAssert(postItem.sid != nil, @"回帖查询， postItem.sid 不能为空");
    NSString *urlString;
    if (postItem.postType == PostInterestGroup) {
        urlString = [NSString stringWithFormat:@"%@%@/%li/replys?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)postItem.sid.integerValue, (long)page, (long)pageSize];
    }
    
    if (postItem.postType == PostComplain) {
        urlString = [NSString stringWithFormat:@"%@%@/%li/replys?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kTakePhotoPath, (long)postItem.sid.integerValue, (long)page, (long)pageSize];
    }
    
    //回复用户发帖
    if (postItem.postType == PostPost) {
        urlString = [NSString stringWithFormat:@"%@%@/%li/replys?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kComplainPath, (long)postItem.sid.integerValue, (long)page, (long)pageSize];
    }
    
    //展品评论
    if (postItem.postType == PostComment) {
        urlString = [NSString stringWithFormat:@"%@%@/%li/comment?type=%i&currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kExhibitCommentPath, (long)postItem.postEntityId.integerValue, postItem.postEntityType, (long)page, (long)pageSize];
    }
    //...
    if (postItem.postType == PostCommentMagic) {
        urlString = [NSString stringWithFormat:@"%@%@/%li/replys?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kExhibitCommentPath2, (long)postItem.sid.integerValue, (long)page, (long)pageSize];
    }

    
    //活动派
    if (postItem.postType == PostActivity)
    {
        urlString = [NSString stringWithFormat:@"%@%@/%li/replys?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kActivityPartyPath, (long)postItem.sid.integerValue, (long)page, (long)pageSize];
    }
    
    //专家来了
    if (postItem.postType == PostExpert) {
        urlString = [NSString stringWithFormat:@"%@%@/%li/replys?currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kExpertPostsPath, (long)postItem.sid.integerValue, (long)page, (long)pageSize];
    }
    
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:postItem.postType callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark 根据回帖获取主贴
+ (DataRequest *)loadPostWithReply:(PostItem *)reply callback:(void (^)(PostItem *postItem, BOOL success))callback
{
    if (reply.postType ==PostCommentMagic) {
        reply.postType = PostComment;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@museum/app/community/replyDetail?id=%li&type=%i&currentpage=1&pagesize=30", [DataManager shareDataManager].serverAddress, (long)reply.sid.integerValue, reply.postType];
    
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostWithRequest:result callback:^(PostItem *postItem, BOOL success) {
                callback(postItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToPostWithRequest:(DataRequest *)request callback:(void (^)(PostItem *postItem, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        PostItem *postItem = nil;
        if (success) {
            @try {
                postItem = [[PostItem alloc] init];
                postItem.sid = dic[@"result"][@"id"];
                postItem.postType = ((NSNumber *)dic[@"result"][@"type"]).intValue;
                postItem.picPaths = dic[@"result"][@"pics"];
                postItem.browseNum= dic[@"result"][@"browseNum"];
                postItem.content = dic[@"result"][@"postContent"];
                postItem.title = dic[@"result"][@"title"];
                postItem.replyTotal = dic[@"result"][@"replyTotal"];
                
                User *replyUser = [[User alloc] init];
                replyUser.sid= dic[@"result"][@"replyUserId"];
                replyUser.nickname = dic[@"result"][@"replyUserName"];
                postItem.replyUser = replyUser;
                
                postItem.postEntityId = dic[@"result"][@"entityId"];
                postItem.postEntityType = ((NSNumber *)dic[@"result"][@"entityType"]).intValue;
                postItem.typeId = dic[@"result"][@"groupId"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                postItem.date = [dateFormatter dateFromString:dic[@"result"][@"postDate"]];
                postItem.replyDate = [dateFormatter dateFromString:dic[@"result"][@"replyDate"]];
                
                postItem.praiseNum = dic[@"result"][@"praiseNum"];
                postItem.isEssence = ((NSNumber *)dic[@"result"][@"isEssence"]).boolValue;
                postItem.isHot = ((NSNumber *)dic[@"result"][@"isHot"]).boolValue;
                
                User *postUser = [[User alloc] init];
                postUser.sid = dic[@"result"][@"postUserId"];
                postUser.nickname = dic[@"result"][@"postUserName"];
                postUser.portraitPath = dic[@"result"][@"postPortrait"];
                postItem.user = postUser;
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
                postItem = nil;
            }
            @finally {
                if (request.showError && !success) {
                    [DataManager showMessage:message dur:request.errorDur];
                }
            }
            
        }
        
        callback(postItem, success);
    }];
}

#pragma mark 12.9 兴趣小组 新增
//App 不需要

#pragma mark 活动派
#pragma mark 12.11 活动派 发帖
+ (DataQueue *)postActivityWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback

{
    NSAssert(user.sid != nil, @"发帖， user.sid不能为空");
    NSAssert(postItem.title.length > 0, @"发帖， postItem.title 不能为空");
    NSAssert(postItem.content.length > 0, @"发帖， postItem.contetnt 不能为空");
    
    DataQueue *queue = [DataManager postPics:postItem.images callback:^(NSArray *picPaths, BOOL success) {
        if (success) {
            //构造路径
            NSString *pathString = @"";
            for (NSString *picString in picPaths) {
                pathString =  [pathString stringByAppendingString:picString];
                pathString = [pathString stringByAppendingString:@","];
            }

            //发帖
            NSString *urlString = [NSString stringWithFormat:@"%@%@/post", [DataManager shareDataManager].serverAddress, kActivityPartyPath];
            DataRequest *requestPic = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
                if (success) {
                    //
                    [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                        callback(found, success);
                    }];
                    
                }else{
                    callback(NO, success);
                }
                
            }];
            
            [requestPic setRequestMethod:@"POST"];
            [requestPic setPostValue:postItem.title forKey:@"title"];
            [requestPic setPostValue:postItem.content forKey:@"postContent"];
            [requestPic setPostValue:postItem.user.sid forKey:@"userId"];
            [requestPic setPostValue:pathString forKey:@"pics"];
            [requestPic startAsynchronous];

        }else{
            callback(NO, success);
        }

    }];

    
    return queue;
}

#pragma mark 12.12 活动派回帖
+ (DataRequest *)replyActivityWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.sid != nil, @"回帖， user.sid不能为空");
    NSAssert(postItem.sid != nil, @"回帖， postItem.sid不能为空");
    NSAssert(postItem.replyContent.length > 0, @"回帖， postItem.replyContent 不能为空");
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/reply", [DataManager shareDataManager].serverAddress, kActivityPartyPath, (long)postItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL posted, BOOL success) {
                callback(posted, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:postItem.replyContent forKey:@"replyContent"];
    return  request;
}


#pragma mark 12.13 活动派 发帖查询
+ (DataRequest *)loadActivityPostWithStick:(BOOL)isStick page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{

    ///isStick ＝ 1 时查询置顶帖子， 查询所有帖子 不要提交isStick
    NSString *urlString;
    if (isStick) {
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&stick=%i", [DataManager shareDataManager].serverAddress, kActivityPartyPath, (long)pageSize, (long)page, isStick];
    }else{
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li", [DataManager shareDataManager].serverAddress, kActivityPartyPath, (long)pageSize, (long)page];
    }

    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostActivity callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, NO);
        }
    }];
    
    return request;

}

#pragma makr 活动派 搜索
+ (DataRequest *)loadActivityPostWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *PageItem, BOOL success))callback

{
    NSString *urlString;
    if (keyword != nil) {
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&title=%@", [DataManager shareDataManager].serverAddress, kActivityPartyPath, (long)pageSize, (long)page, keyword];
    }
    if (user.sid != nil) {
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&userId=%li", [DataManager shareDataManager].serverAddress, kActivityPartyPath, (long)pageSize, (long)page, (long)user.sid.integerValue];
    }
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostActivity callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, NO);
        }
    }];
    
    return request;
}

#pragma mark 专家来了
#pragma mark 12.16 专家来了 发帖
+ (DataQueue *)postExpertWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert (user.sid != nil, @"专家来了发帖, user.sid 不能为空");
    NSAssert(postItem.title.length > 0, @"发帖， postItem.title 不能为空");
    NSAssert(postItem.content.length > 0, @"发帖， postItem.contetnt 不能为空");
    
    
    DataQueue *queue = [DataManager postPics:postItem.images callback:^(NSArray *picPaths, BOOL success) {
        if (success) {
            //构造路径
            NSString *pathString = @"";
            for (NSString *picString in picPaths) {
                pathString =  [pathString stringByAppendingString:picString];
                pathString = [pathString stringByAppendingString:@","];
            }

            //发帖
            NSString *urlString = [NSString stringWithFormat:@"%@%@/post",[DataManager shareDataManager].serverAddress, kExpertPostsPath];
            
            DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {

                if (success) {
                    [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                        callback(found, success);
                    }];
                }else{
                    callback(NO, success);
                }
            }];
            
            [request setRequestMethod:@"POST"];
            [request setPostValue:user.sid forKey:@"userId"];
            [request setPostValue:postItem.content forKey:@"postContent"];
            [request setPostValue:postItem.title forKey:@"title"];
            [request setPostValue:pathString forKey:@"pics"];
            [request setPostValue:postItem.score forKey:@"score"];
            
            [request startAsynchronous];
            
        }else{
            callback(NO, success);
        }
        
    }];
    
    return queue;
    
    
}

#pragma mark 12.18 专家来了 回帖
+ (DataRequest *)replyExpertWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.sid != nil, @"回帖， user.sid不能为空");
    NSAssert(postItem.sid != nil, @"回帖， postItem.sid不能为空");
    NSAssert(postItem.replyContent.length > 0, @"回帖， postItem.replyContent 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/reply", [DataManager shareDataManager].serverAddress, kExpertPostsPath, (long)postItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL posted, BOOL success) {
                callback(posted, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:postItem.replyContent forKey:@"replyContent"];
    return  request;
}

#pragma mark 12.19 专家来了 发帖查询
+ (DataRequest *)loadExpertPostWithSubject:(ExpertSubjectItem *)subjectItem catalogType:(PostCatalogType)postCatalogType page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSString *urlString;
    if (subjectItem.key != nil) {
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&subjectkey=%@&type=%i", [DataManager shareDataManager].serverAddress, kExpertPostsPath, (long)pageSize, (long)page, subjectItem.key, postCatalogType];
    }else{
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&type=%i", [DataManager shareDataManager].serverAddress, kExpertPostsPath, (long)pageSize, (long)page,  postCatalogType];
    }

    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostExpert callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, NO);
        }
    }];
    
    return request;
}

#pragma mark 专家来了 搜索指定
+ (DataRequest *)loadExpertPostWithKeyword:(NSString *)keyword user:(User *)user page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
 
    NSString *urlString;
    if (keyword != nil) {
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&title=%@", [DataManager shareDataManager].serverAddress, kExpertPostsPath, (long)pageSize, (long)page, keyword];
    }
    
    if (user != nil)
    {
        urlString = [NSString stringWithFormat:@"%@%@/posts?pagesize=%li&currentpage=%li&userId=%li", [DataManager shareDataManager].serverAddress, kExpertPostsPath, (long)pageSize, (long)page, (long)user.sid.integerValue];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostExpert callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, NO);
        }
    }];
    
    return request;
}


#pragma mark 专家来了 学科查询
+ (DataRequest *)loadExpertSubject:(void (^)(NSArray *subjects, BOOL succeess))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kExpertSubjectPath];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExpertSubjectsWithRequest:result calback:^(NSArray *subjects, BOOL success) {
                callback(subjects, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}


+ (void)convertToExpertSubjectsWithRequest:(DataRequest *)request calback:(void (^)(NSArray *subjects, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        NSMutableArray *subjects = nil;
        if (success) {
            @try {
                subjects = [NSMutableArray array];
                NSArray *results = dic[@"result"];
                for (NSDictionary *sDic in results) {
                    ExpertSubjectItem *sItem = [[ExpertSubjectItem alloc] init];
                    sItem.key = sDic[@"key"];
                    sItem.name = sDic[@"value"];
                    
                    [subjects addObject:sItem];
                }
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
            }
            @finally {
                //
            }
        }
        
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        
        callback(subjects, success);
    }];
}

#pragma mark 专家来了 专家查询
+ (DataRequest *)loadExpertWithSubject:(ExpertSubjectItem *)subjectItem callback:(void (^)(NSArray *experts, BOOL success))callback
{
    NSAssert(subjectItem.key.length > 0, @"查询学科专家， 学科subjectItem.key不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@/specialist", [DataManager shareDataManager].serverAddress, kExpertPath, subjectItem.key];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExpertsWithRequest:result callback:^(NSArray *experts, BOOL success) {
                callback(experts, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToExpertsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *experts, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        NSMutableArray *experts = nil;
        if (success) {
            @try {
                NSArray *results = dic[@"result"][@"data"];
                experts = [NSMutableArray arrayWithCapacity:results.count];
                for (NSDictionary *eDic in results) {
                    ExpertItem  *eItem = [[ExpertItem alloc] init];
                    eItem.sid = eDic[@"id"];
                    eItem.name = eDic[@"name"];
                    
                    [experts addObject:eItem];
                }
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
            }
            @finally {
                //
            }
        }
        
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        
        callback(experts, success);
    }];
}

//#pragma mark 12.22 大家来吐槽 发帖查询
//+ (DataRequest *)loadComplainPosts:(void (^)(NSArray *posts, BOOL success))callback
//{
//    return nil;
//}

#pragma mark 12.25 展品评论 详细列表
+ (DataRequest *)loadCommentWithInfoItem:(InfoItem *)infoItem page:(NSInteger)page pageSize:(NSInteger)pageSize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSAssert(infoItem.relationId != nil, @"获取展品评论详细信息, relationId 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/comment?pagesize=%li&currentpage=%li&type=%i", [DataManager shareDataManager].serverAddress, kExhibitCommentPath,(long)infoItem.relationId.integerValue, (long)pageSize, (long)page, infoItem.type];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            
            [DataManager convertToPostsWithRequest:result postType:PostComplain callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}


+ (void)convertToCommentWithRequest:(DataRequest *)request callback:(void (^)(PageItem *pageItem, BOOL success))callback;
{
    
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        //格式处理
        PageItem *pageItem = nil;
        if (success) {
            @try {
                NSDictionary *resultDic = dic[@"result"];
                PageItem *pageItem= [[PageItem alloc] init];
                pageItem.currentPage = resultDic[@"currentpage"];
                pageItem.pageSize = resultDic[@"pagesize"];
                
                NSArray *data = resultDic[@"data"];
                NSMutableArray *contents = [NSMutableArray array];
                for (NSDictionary *contentDic in data){
                    CommentContent * content = [[CommentContent alloc] init];
                    content.sid = contentDic[@"id"];
                    content.content = contentDic[@"contents"];
                    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *dateString = contentDic[@"createDate"];
                    content.date = [dateFormatter dateFromString:dateString];
                    User *user = [[User alloc] init];
                    user.sid = contentDic[@"userId"];
                    user.nickname = contentDic[@"userName"];
                    content.user = user;
                    
                    [contents addObject:content];
                }
                pageItem.datas = contents;
            }
            
            @catch (NSException *exception) {
                success = NO;
                message = exception.description;
                pageItem = nil;
            }
            @finally {
                //
                
            }
        }
        
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        
        callback(pageItem, success);
        
    }];
}

#pragma mark 12.26 兴趣小组 退出
+ (DataRequest *)quitInterestGroup:(InterestGroupItem *)groupItem user:(User *)user callback:(void (^)(BOOL quited, BOOL success))callback
{
    NSAssert(groupItem.sid != nil, @"退出兴趣小组, groupItem.sid不能为空");
    NSAssert(user.sid != nil, @"退出兴趣小组, user.sid不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/exit", [DataManager shareDataManager].serverAddress, kInterestGroupPath, (long)groupItem.sid.integerValue];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else
        {
            callback(NO, success);
        }
    }];
    
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    
    return request;
}

#pragma mark 12.26 大家来吐槽 展品评论 提交
+ (DataRequest *)postCommentWithInfoItem:(InfoItem *)infoItem user:(User *)user postItem:(PostItem *)postItem callback:(void (^)(BOOL posted, BOOL success))callback
{
    NSAssert(user.sid != nil, @"大家来吐槽 提交展品评论, user.sid不能为空");
    NSAssert(postItem.replyContent.length > 0, @"大家来吐槽 提交展品评论, content不能为空");

    NSString *urlString = [NSString stringWithFormat:@"%@%@/%li/comment?type=%i", [DataManager shareDataManager].serverAddress, kExhibitCommentPath, (long)infoItem.relationId.integerValue, infoItem.type];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL posted, BOOL success) {
                callback(posted, success);
            }];
        }else{
            callback(NO, success);
        }
    }];

    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:postItem.replyContent forKey:@"content"];
    [request setPostValue:[NSNumber numberWithInt:infoItem.type] forKey:@"type"];
    [request setRequestMethod:@"POST"];
    return request;
}

#pragma mark 我的帖子
+ (DataRequest *)loadPostWithUser:(User *)user page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSAssert(user.sid != nil, @"获取我的帖子, user.sid 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@?userId=%li&currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kMyPostPath, (long)user.sid.integerValue, (long)page, (long)pagesize];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostUnkown callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    //文档说明使用POST，实际使用GET
    //[request setRequestMethod:@"POST"];
    //[request setPostValue:user.sid forKey:@"userId"];
    return request;
}

#pragma mark 我的回帖
+ (DataRequest *)loadReplyWithUser:(User *)user page:(NSInteger)page pagesize:(NSInteger)pagesize callback:(void (^)(PageItem *pageItem, BOOL success))callback
{
    NSAssert(user.sid != nil, @"获取我的回帖, user.sid 不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@%@?userId=%li&currentpage=%li&pagesize=%li", [DataManager shareDataManager].serverAddress, kMyReplyPath, (long)user.sid.integerValue, (long)page, (long)pagesize];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostsWithRequest:result postType:PostUnkown callback:^(PageItem *pageItem, BOOL success) {
                callback(pageItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

#pragma mark - 删除发帖
+ (DataRequest *)deleteWithPostItem:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL deleted, BOOL success))callback
{
    NSAssert(postItem.sid != nil, @"删除帖子，postItem.sid 不能为空");
    NSAssert(user.sid != nil, @"删除帖子， user.sid 不能为空");
    NSString *urlString;
    
    switch (postItem.postType) {
        case PostInterestGroup:
            urlString = [NSString stringWithFormat:@"%@%@/%li/delete?userId=%li", [DataManager shareDataManager].serverAddress, kInterestGroupDeletePath, (long)postItem.sid.integerValue, (long)user.sid.integerValue];
            break;
        case PostExpert:
            urlString = [NSString stringWithFormat:@"%@%@/%li/delete?userId=%li", [DataManager shareDataManager].serverAddress, kExpertDeletePath, (long)postItem.sid.integerValue, (long)user.sid.integerValue];
            break;
        case PostComplain:
            urlString = [NSString stringWithFormat:@"%@%@/%li/delete?userId=%li", [DataManager shareDataManager].serverAddress, kTakingphotoDeletePath, (long)user.sid.integerValue, (long)postItem.user.sid.integerValue];
            break;
            
        default:
            urlString = nil;
            break;
    }
    
    if (urlString == nil) {
        return nil;
    }
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    return request;
}

#pragma mark - 删除回帖
+ (DataRequest *)deleteReplyWithPostItem:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL deleted, BOOL success))callback
{
    NSAssert(postItem.sid != nil, @"删除回复，postItem.sid 不能为空");
    NSAssert(user.sid != nil, @"删除回复， user.sid 不能为空");
    NSString *urlString = nil;
    
    switch (postItem.postType) {
        case PostInterestGroup:
            urlString = [NSString stringWithFormat:@"%@%@/%li/delete?userId=%li", [DataManager shareDataManager].serverAddress, kInterestGroupReplyDeletePath, (long)postItem.sid.integerValue, (long)user.sid.integerValue];
            break;
        case PostExpert:
            urlString = [NSString stringWithFormat:@"%@%@/%li/delete?userId=%li", [DataManager shareDataManager].serverAddress, kExpertReplytDeletePath, (long)postItem.sid.integerValue, (long)user.sid.integerValue];
            break;
        case PostComplain:
            urlString = [NSString stringWithFormat:@"%@%@/%li/delete?userId=%li", [DataManager shareDataManager].serverAddress, kTakingphotoReplyDeletePath, (long)postItem.sid.integerValue, (long)user.sid.integerValue];
            break;
        default:
            break;
    }
    
    if (urlString == nil) {
        return nil;
    }
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    return request;
}


#pragma mark 记录帖子浏览数
+ (DataRequest *)postBrowseWithPost:(PostItem *)postItem callback:(void (^)(BOOL posted, BOOL success))callback
{
    //必须有postType 和 postId
    //记录帖子浏览数，非必需功能，不报错所以这里也不断言了
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPostBrowsePath];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                if (callback != nil)
                {
                    callback(found, YES);
                }
                
            }];
        }else
        {
            if (callback != nil) {
                callback(NO, YES);
            }
        }
    }];
    request.requestMethod = @"POST";
    [request setPostValue:[NSNumber numberWithInt:postItem.postType] forKey:@"type"];
    [request setPostValue:postItem.sid forKey:@"postId"];
    request.showHUD = NO;
    request.showError = NO;
    return request;
}

#pragma mark 帖子点赞
+ (DataRequest *)postPriaseWithPost:(PostItem *)postItem user:(User *)user callback:(void (^)(BOOL praised, BOOL success))callback
{
    NSAssert(user.sid !=nil , @"帖子点赞, user.sid不能为空");
    NSAssert(postItem.postType > 0, @"帖子点赞， postType 必需有效");
    NSAssert(postItem.sid != nil, @"帖子点赞， postItem.sid 不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPostPraisePath];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                if (callback != nil)
                {
                    callback(found, success);
                }
            }];
        }else{
            if (callback != nil) {
                callback(NO, success);
            }
        }
    }];
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:[NSNumber numberWithInt:postItem.postType].stringValue forKey:@"type"];
    [request setPostValue:postItem.sid.stringValue forKey:@"postId"];
    return  request;
}

//#pragma mark 最佳回帖
//+ (DataRequest *)loadBestReplyWithPost:(PostItem *)postItem callback:(void (^)(PostItem *postItem, BOOL success))callback
//{
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%i/reply/%li/correct", [DataManager shareDataManager].serverAddress, kBeatReplyPath, postItem.postType, (long)postItem.sid.integerValue];
//    
//    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
//        if (success) {
//            [DataManager convertToPostsWithRequest:result postType:postItem.postType callback:^(PageItem *pageItem, BOOL success) {
//                NSLog(@"best reply:%@", result.responseString);
//            }];
//        }else{
//            callback(nil, success);
//        }
//    }];
//    
//    
//    [request setRequestMethod:@"POST"];
//    return request;
//}

#pragma mark - 消息中心
+ (DataRequest *)loadMessageWithLocateItem:(LocateItem *)locateItem callback:(void (^)(NSArray *messages, BOOL success))callback
{
    NSString *urlSring = [NSString stringWithFormat:@"%@%@/%i", [DataManager shareDataManager].serverAddress, kMessagePath, locateItem.areaType];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlSring] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToMessageWithRequest:result callback:^(NSArray *messages, BOOL success) {
                callback(messages, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToMessageWithRequest:(DataRequest *)request callback:(void (^)(NSArray *messages, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        NSMutableArray *messages = nil;
        if (success) {
            @try {
                NSArray *results = dic[@"result"];
                messages = [NSMutableArray arrayWithCapacity:results.count];
                for (NSDictionary *mDic in results) {
                    MessageItem *messageItem = [[MessageItem alloc] init];
                    messageItem.sid = mDic[@"id"];
                    messageItem.title = mDic[@"title"];
                    messageItem.content = mDic[@"contents"];
                    
                    messageItem.date = mDic[@"createDate"];
                    messageItem.messageType = ((NSNumber *)mDic[@"type"]).intValue;
                    
                    [messages addObject:message];
                }
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
                messages = nil;
            }
            @finally {
                if (request.showError && !success) {
                    [DataManager showMessage:message dur:request.showError];
                }
            }
        }
        callback(messages, success);
    }];
}

#pragma mark - DataManagaer默认State code 处理
#ifdef Book_Debug
+ (DataRequest *)requestBookWithURL:(NSURL *)url callback:(void (^)(DataRequest *result, BOOL success))callback
{
    //success = NO 默认由后台直接提示错误信息
    //success = YES 由前台来考虑如何处理
    DataRequest *request = [LXDataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //获取State code
            NSError *error = nil;
            NSString *message = @"未知错误";
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result.responseData options:NSJSONReadingMutableContainers error:&error];
            
            //JSON 格式错误
            if (error != nil) {
                success = NO;
                message = error.debugDescription;
            }
            
            //code 错误
            int code = -1;
            @try {
                //
                code = ((NSNumber *)dic[@"code"]).intValue;
                message = dic[@"msg"];
            }
            @catch (NSException *exception) {
                //
                success = NO;
                message = exception.description;
            }
            @finally {
                //Code码
                switch (code) {
                    case -6://仅用于在线预约,"请在前一天0点前预约!"
                        success = NO;
                        break;
                    case -5://仅用于在线预约,"当天预约数不能超过2张!"
                        success = NO;
                        break;
                    case -4:
                        success = NO;
                        break;
                    case -3:
                        success = NO;
                        break;
                    case -2:
                        success = NO;
                        break;
                    case -1:
                        success = NO;
                        break;
                    case 1:
                        success = YES;
                        break;
                    default:
                        message = [NSString stringWithFormat:@"%@", message];
                        success = NO;
                        break;
                }
                
                if (!success && result.showError) {
                    [DataManager showMessage:message dur:result.errorDur];
                }
                
            }
        }
        
        callback(result, success);
    }];
    
    return request;
}
#endif

+ (DataRequest *)requestWithURL:(NSURL *)url callback:(void (^)(DataRequest *result, BOOL success))callback
{
    //success = NO 默认由后台直接提示错误信息
    //success = YES 由前台来考虑如何处理
    DataRequest *request = [LXDataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            //获取State code
            NSError *error = nil;
            NSString *message = @"未知错误";
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result.responseData options:NSJSONReadingMutableContainers error:&error];
            
            //JSON 格式错误
            if (error != nil) {
                success = NO;
                message = error.debugDescription;
            }
            
            //code 错误
            int code = -1;
            @try {
                //
                code = ((NSNumber *)dic[@"code"]).intValue;
                message = dic[@"msg"];
            }
            @catch (NSException *exception) {
                //
                success = NO;
                message = exception.description;
            }
            @finally {
                //Code码
                switch (code) {
/*在线预约和取消预约的code
 case -6://仅用于在线预约,"请在前一天0点前预约!"
 success = NO;
 break;
 case -5://仅用于在线预约,"当天预约数不能超过2张!"
 success = NO;
 break;
 case -4:
 success = NO;
 break;
 case -3:
 success = NO;
 break;
 case -2:
 success = NO;
 break;
 case -1:
 success = NO;
 break;
 case 1:
 success = YES;
 break;
*/
                    case -1:
                        //
                        success = NO;
                        break;
                        
                    case 1:
                        //
                        success = YES;
                        break;
                    case -2:
                        //仅用于寻宝游戏， 代表答案错误 ，（又多了个"无此用户")
                        success = YES;
                        break;
                        //兴趣小组加入， 重复加入小组
                    case -3:
                        success = YES;
                        break;
                    case -4:
#warning 发帖相关展品不存在错误和兴趣小组没有权限错误都使用了-4
                        //用于评论, 发帖权限 (相关展品不存在)
                        success = NO;
                        break;
                    case -8:
                        //发帖, 用户积分不足
                        success = NO;
                        break;
                    case -9:
                        //密吗不正确
                        success = NO;
                        break;
                    case -14:
                        //已经点过赞
                        success = YES;
                        break;
                    case -6://仅用于在线预约,"请在前一天0点前预约!"
                        success = NO;
                        break;
                    case -5://仅用于在线预约,"当天预约数不能超过2张!"
                        success = NO;
                        break;
                    default:
                        message = [NSString stringWithFormat:@"接口错误: code %i, %@", code, message];
                        success = NO;
                        break;
                }
                
                if (!success && result.showError) {
                    [DataManager showMessage:message dur:result.errorDur];
                }
                
            }
        }

        callback(result, success);
    }];
    
    return request;
}


#pragma mark - Request To JSON
+ (void)convertToJsonWithRequest:(DataRequest *)request callback:(void (^)(NSDictionary *dic, NSString *message, BOOL success))callback
{
    //
    NSString *message;
    BOOL success = YES;
    //JSON 处理
    NSError *error = nil;
    if (request.responseData == nil) {
        callback(nil, message, success);
        return;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }

    
    callback(dic, message, success);
}


#pragma mark - 图片
#pragma mark 图片下载
+ (DataRequest *)loadPicWithPath:(NSString *)picPath callback:(void (^)(UIImage *image, BOOL success))callback
{
    //NSAssert(picPath != nil && ![picPath isEqualToString:@""], @"获取图片，picPath不能为空");
    NSString *urlString = [NSString stringWithFormat:@"%@museum/%@", [DataManager shareDataManager].serverAddress, picPath];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    DataRequest *request = [LXDataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            UIImage *image =  [[UIImage alloc] initWithData:result.responseData];
            callback(image, success);
        }else{
            callback(nil, success);
        }
    }];

    request.cache = YES;
    request.hud.mode = MBProgressHUDModeIndeterminate;

    return request;
}

#pragma mark 批量下载
+ (DataQueue *)loadPicsWithPaths:(NSArray *)picPaths callback:(void (^)(NSArray *images,  BOOL success))callback
{
    if (picPaths.count == 0) {
        callback(nil, NO);
        return nil;
    }
    
    NSMutableArray *requests=[[NSMutableArray alloc] init];
    for (NSString *picPath in picPaths) {
        NSString *urlString  = [NSString stringWithFormat:@"%@museum/%@", [DataManager shareDataManager].serverAddress, picPath];
        DataRequest *request=[DataRequest requestWithURL:[NSURL URLWithString:urlString]];
        [requests addObject:request];
    }
    
    DataQueue *queue=[LXDataManager requestWithRequests:requests callback:^(DataQueue *result, BOOL success) {
        if (success) {
            NSMutableArray *images=[[NSMutableArray alloc] init];
            for (DataRequest *request in result.requests) {
                
                UIImage *image = [[UIImage alloc] initWithData:request.responseData];
                if (image != nil) {
                    ///缓存没有 responseHeader
                    NSString *type = request.url.relativePath.pathExtension;
                    type = [type lowercaseString];
                    if ([type isEqualToString:@"gif"]) {
                        //if
                        [images addObject:request.responseData];
                    }else{
                        //非gif
                        UIImage *image = [[UIImage alloc] initWithData:request.responseData];
                        [images addObject:image];
                        
                    }
                    
                }
            }
            
            
            callback(images, success);
        }else{
            callback(nil, success);
        }
        
    } ];
    
    queue.hud.mode = MBProgressHUDModeAnnularDeterminate;
    return queue;
}

#pragma mark 图片尺寸信息
+ (void)loadPicsWithPosts:(NSArray *)posts callback:(void (^)(NSArray *imageInfo, BOOL success))callback
{
    NSMutableArray *imageInfo = [NSMutableArray array];
    NSMutableArray *picURLs = [NSMutableArray array];
    //帖子的第一张图片
    for (PostItem *postItem in posts) {
        if (postItem.picPaths.count > 0) {
            NSString *urlString  = [NSString stringWithFormat:@"%@museum/%@", [DataManager shareDataManager].serverAddress, postItem.picPaths[0]];
            [picURLs addObject:[NSURL URLWithString:urlString]];
        }
    }
    
    for (NSURL *url in picURLs) {
        [UIImage requestSizeFor:url completion:^(NSURL *imgURL, CGSize size) {
            [imageInfo addObject:@{@"imageSize":[NSValue valueWithCGSize:size], @"imageUrl":imgURL.relativePath}];
            if (imageInfo.count == picURLs.count) {
                callback(imageInfo, YES);
            }
        }];
    }
}

#pragma mark - 图片完整路径
+ (NSString *)getImageURLWithPath:(NSString *)path
{
    NSString *urlString  = [NSString stringWithFormat:@"%@museum/%@", [DataManager shareDataManager].serverAddress, path];
    return urlString;
}

#pragma mark - 视屏完整路径
+ (NSString *)getMovieURLWithPath:(NSString *)path
{
    NSString *urlString  = [NSString stringWithFormat:@"%@museum/%@", [DataManager shareDataManager].serverAddress, path];
    return urlString;
}

#pragma mark - 信息显示
+ (void)showMessage:(NSString *)message dur:(CGFloat)dur
{
    MBProgressHUD *errorHUD = nil;
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    errorHUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    errorHUD.removeFromSuperViewOnHide = YES;
    errorHUD.mode = MBProgressHUDModeText;
    errorHUD.detailsLabelText = message;
    [errorHUD show:YES];
    
    [errorHUD hide:YES afterDelay:dur];
}

#pragma mark - 定位

+ (void)startLocate:(void (^)(NSString *result, BOOL success))callback
{
    NSLog(@"Inner StartLocate");
    GCDAsyncUdpSocket *udpSocket;
    if ([DataManager shareDataManager].udpSocket == nil) {
        [DataManager shareDataManager].udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:[DataManager shareDataManager] delegateQueue:dispatch_get_main_queue()];
       
    }
    udpSocket = [DataManager shareDataManager].udpSocket;
    NSError *error;
    NSLog(@"Inner StartLocate Socket is ok");
    if (![udpSocket bindToPort:61111 error:&error]) {
        NSLog(@"socket error: error binding %@", error.description);
        
        callback(nil, NO);
        return;
    }
    
    if (![udpSocket beginReceiving:&error]) {
        NSLog(@"socket error: error receiving: %@", error.description);
        
        return;
    }
}

+ (void)stopLocate
{
    GCDAsyncUdpSocket *udpSocket = [DataManager shareDataManager].udpSocket;
    [udpSocket close];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSLog(@"udp recevie data");
    
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *results = [message componentsSeparatedByString:@","];

    //dsy 简单检查消息格式
    if([results count]<5){
        NSLog(@"message=%@ format is not correct",message);
        return ;
    }
    LocateItem *item = [[LocateItem alloc] init];
    
    @try {
//        CGFloat x = ((NSString *)results[1]).integerValue/3.125f;
//        CGFloat y = ABS(((NSString *)results[2]).integerValue)/3.125f;
//        item.pt = CGPointMake(x * 0.5, y * 0.5);
        
        CGFloat x = ((NSString *)results[1]).integerValue;
        CGFloat y = ABS(((NSString *)results[2]).integerValue);
        item.pt = CGPointMake(x/3, y/3);//获得的信息点处于3

        item.isIn = !((NSNumber *)results[3]).boolValue;
        item.floorType = ((NSString *)results[4]).intValue;
        item.areaType = ((NSString *)results[5]).intValue;
        item.ip = results[6];//这个表示是楼上还是楼下默认为0，1为楼下
        
        //收到定位信息，服务器地址切换到内部
        [DataManager shareDataManager].serverAddress = kServerInsideAddress;
        [DataManager shareDataManager].lastInMuseumDate = [NSDate date];
        
        [[NSNotificationCenter defaultCenter ]postNotificationName:@"DataManagerLocate" object:nil userInfo:@{@"locateItem":item}];
    }
    @catch (NSException *exception) {
        //
        NSLog(@"handler udp message exception :%@",exception);
    }
    @finally {
        
    }
}

#pragma mark - 图片批量上传
+ (DataQueue *)postPics:(NSArray *)images callback:(void (^)(NSArray *picPaths, BOOL success))callback
{
    //NSAssert(images.count > 0, @"图片批量上传,images.count ＝ 0");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPostPicPath];

    NSMutableArray *requests = [NSMutableArray array];
    
    for (UIImage *image in images) {
        DataRequest *request = [DataRequest requestWithURL:[NSURL URLWithString:urlString]];
        //2015-5-6需求：上传接口更改、图片无需压缩
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
        
        [request setRequestMethod:@"POST"];
        [request setData:imageData withFileName:@"testImage1.jpg" andContentType:@"image/jpeg" forKey:@"imgfile"];
        
        [requests addObject:request];
    }
    
    DataQueue *queue = [DataManager requestWithRequests:requests callback:^(DataQueue *result, BOOL success) {
        if (success) {
            NSMutableArray *results= [NSMutableArray array];
            __block BOOL post = YES;
            for (DataRequest *request in result.requests) {
                request.showError = result.showError;
                request.errorDur = result.errorDur;
                [DataManager convertToPicPathWithRequest:request callback:^(NSString *picPath, BOOL success) {
                    if (success && picPath.length > 0) {
                        [results addObject:picPath];
                    }else{
                        post = NO;
                    }
                }];
            }
            callback(results, post);
        }else{
            callback(nil,success);
        }
    }];
    
    return queue;
}

#pragma mark  图片上传
+ (DataRequest *)postPic:(UIImage *)image callback:(void (^)(NSString *picPath, BOOL success))callback
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kPostPicPath];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        [DataManager convertToPicPathWithRequest:result callback:^(NSString *picPath, BOOL success) {
            //
            if (success ) {
                //
                callback(picPath, success);
                
            }else{
                callback(nil, success);
            }
        }];
    }];
    
     //2015-5-6需求：上传接口更改、图片无需压缩
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    
    [request setRequestMethod:@"POST"];
    [request setData:imageData withFileName:@"testImage1.jpg" andContentType:@"image/jpeg" forKey:@"imgfile"];
    
    return request;
}

+ (void)convertToPicPathWithRequest:(DataRequest *)request callback:(void (^)(NSString *picPath, BOOL success))callback
{
    
    
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        
        NSString *picPath = nil;
        @try {
            picPath = dic[@"result"];
        }
        @catch (NSException *exception) {
            success = NO;
            message = exception.description;
            picPath = nil;
        }
        @finally {
            if (picPath == nil) {
                message = @"图片上传失败";
                success = NO;
            }
            
            if (request.showError && !success) {
                [DataManager showMessage:message dur:request.errorDur];
            }
        }
        
        callback(picPath, success);
    }];
}

#pragma mark - 社交分享
+ (void)shareWithTitle:(NSString *)title content:(NSString *)content picPath:(NSString *)picPath inView:(UIView *)sender
{
    /*
    id imageURL = nil;
    if (picPath != nil) {
        imageURL = [ShareSDK imageWithUrl:[DataManager getImageURLWithPath:picPath]];
    }
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:nil
                                                image:imageURL
                                                title:title
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:ShareTypeAny
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:nil
                       shareOptions:nil
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 UIWindow *window = [UIApplication sharedApplication].keyWindow;
                                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
                                 hud.removeFromSuperViewOnHide = YES;
                                 hud.mode = MBProgressHUDModeText;
                                 if (state == SSPublishContentStateSuccess)
                                 {
                                     
                                     hud.labelText = @"发表成功";
                                 }
                                 else if (state == SSPublishContentStateFail)
                                 {
                                     
                                     hud.labelText = @"发布失败, 请稍后再试";
                                 }
                                 
                                 [hud hide:YES afterDelay:2.0];
                             }];
     */
    
}

#pragma mark - 预约的本地通知
#pragma mark 初始化预约通知
+(void)cancelOrderNotificationForItem:(OrderItem *)item {
    [[JRNLocalNotificationCenter defaultCenter] cancelLocalNotificationForKey:[NSString stringWithFormat:@"%@",item.sid]];
}

+(void)cancelAllOrderNotifications {
    [[JRNLocalNotificationCenter defaultCenter] cancelAllLocalNotifications];
}

+ (void)initOrderLocalNotification {
    User *user = [self getUser];
    if (user != nil) {
        DataRequest *request = [self loadAppointmentWithUser:user callback:^(NSArray *orders, BOOL success) {
            if (orders.count>0 && success) {
                [[JRNLocalNotificationCenter defaultCenter] cancelAllLocalNotifications];
                for (OrderItem *orderItem in orders) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSDate *orderBeginDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@:00",orderItem.bookDate,orderItem.beginTime]];
                    if ([orderBeginDate timeIntervalSinceDate:[NSDate date]] > 30*60) {
                        NSDate *postDate = [NSDate dateWithTimeInterval:-30*60 sinceDate:orderBeginDate];
                        NSString *key = [NSString stringWithFormat:@"%@",orderItem.sid];
                        NSString *body;
                        if (orderItem.preorderType == PreorderFilm) {
                            body = [NSString stringWithFormat:@"您预约的电影《%@》将在%@上映",orderItem.name,orderItem.beginTime];
                        } else {
                            body = [NSString stringWithFormat:@"您预约的活动《%@》将在%@进行",orderItem.name,orderItem.beginTime];
                        }
                        NSInteger badgeCount = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:orderItem.name,@"name",orderItem.beginTime ,@"beginTime",@(orderItem.preorderType) ,@"type",nil];
                        [[JRNLocalNotificationCenter defaultCenter] postNotificationOn:postDate forKey:key alertBody:body alertAction:@"查看详细" soundName:nil launchImage:nil userInfo:dic badgeCount:badgeCount repeatInterval:0];
                    }
                }
            }
        }];
        request.showHUD=NO;
        request.showError=NO;
        [request startAsynchronous];
    }
}

#pragma mark - 灭绝记录
+ (DataRequest *)loadExtinctions:(void (^)(NSArray *extinctions, BOOL success))callback

{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kExtinctionPath];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToExtinctionsWithRequest:result callback:^(NSArray *extinctions, BOOL success) {
                callback(extinctions, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return request;
}

+ (void)convertToExtinctionsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *extinctions, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        if (success) {
            //
            NSMutableArray *extinctions = nil;
            
            @try {
                NSArray *results = dic[@"result"];
                extinctions = [NSMutableArray arrayWithCapacity:results.count];
                for (NSDictionary *eDic in results) {
                    ExtinctionItem *eItem = [[ExtinctionItem alloc] init];
                    eItem.sid = eDic[@"id"];
                    eItem.age = eDic[@"age"];
                    eItem.name = eDic[@"name"];
                    eItem.enName = eDic[@"ename"];
                    NSNumber *x = eDic[@"x"];
                    NSNumber *y = eDic[@"y"];
                    eItem.pt = CGPointMake(x.floatValue*0.5f, y.floatValue*0.5f);
                    eItem.iconPath = eDic[@"icon"];
                    
                    [extinctions addObject:eItem];
                }
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
                extinctions = nil;
            }
            @finally {
                if (!success && request.showHUD) {
                    [DataManager showMessage:message dur:2.0];
                }
            }
            
            callback(extinctions, success);
        }
    }];
}

#pragma mark - 版本更新
+ (DataRequest *)versionUpdate:(void (^)(VersionItem *versionItem, BOOL success))callback
{
    DataRequest *reqeust = [LXDataManager requestWithURL:[NSURL URLWithString:kAppUpdatePath] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToVersionWithRequest:result callback:^(VersionItem *versionItem, BOOL success) {
                callback(versionItem, success);
            }];
        }else{
            callback(nil, success);
        }
    }];
    
    return reqeust;
}

+ (void)convertToVersionWithRequest:(DataRequest *)request callback:(void (^)(VersionItem *versionItem, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        VersionItem *versionItem = nil;
        if (success) {
            @try {
                versionItem = [[VersionItem alloc] init];
                versionItem.message = dic[@"changelog"];
                versionItem.versionShort = dic[@"versionShort"];
                versionItem.updateURL = dic[@"update_url"];
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
                versionItem = nil;
            }
            @finally {
                
            }
        }
        
        if (!success && request.showError) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(versionItem, success);
    }];
}

#pragma mark - 学习单
#pragma mark 获取电子学习单展区列表
+(DataRequest *)loadLearnBookItemsWithUser:(User *)user callback:(void (^)(NSArray *learnBookItems, BOOL success))callback {
    NSNumber *userid;
    if (user && user.sid && user.sid.integerValue>0) {
        userid = user.sid;
    }
    
    NSString *urlString;
    if (userid && userid.integerValue>0) {
        urlString = [NSString stringWithFormat:@"%@%@?userId=%@", [DataManager shareDataManager].serverAddress, kStudyPath, userid];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, kStudyPath];
    }
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToLearnBookItemsWithRequest:result callback:^(NSArray *learnBookItems, BOOL success) {
                callback(learnBookItems,success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];

    return  request;
}

+ (void)convertToLearnBookItemsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *learnBookItems, BOOL success))callback {
    NSMutableArray *learnBookItems = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *itemDic in dic[@"result"][@"data"]) {
            LearnBookItem *item = [[LearnBookItem alloc] init];
            item.sid = itemDic[@"id"];
            item.name = itemDic[@"name"];
            item.icon = itemDic[@"icon"];
            item.knowledge = itemDic[@"knowledge"];
            item.bgpic = itemDic[@"bgpic"];
            item.score = @([itemDic[@"score"] integerValue]);
            item.usedTime = [NSString stringWithFormat:@"%@",itemDic[@"userTime"]];
            
            [learnBookItems addObject:item];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(learnBookItems, success);
    }
}

#pragma mark 获取单个展区的10个题目
+(DataRequest *)loadQuestionItemsForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(NSArray *questionItems, BOOL success))callback {
    NSAssert(learnBookID != nil, @"获取10个题目，learnBookID不能为空");
    NSAssert(user.sid != nil, @"获取10个题目，user.sid不能为空");

    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@/questions?userId=%@", [DataManager shareDataManager].serverAddress, kStudyPath, learnBookID, user.sid];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToQuestionItemsWithRequest:result callback:^(NSArray *questions, BOOL success) {
                callback(questions,success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}


+ (void)convertToQuestionItemsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *questions, BOOL success))callback {
    NSMutableArray *questions = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    if ([dic[@"result"] count] == 0) {
        callback(questions, success);
        return;
    }
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *itemDic in dic[@"result"][@"questions"]) {
            QuestionItem *item = [[QuestionItem alloc] init];
            item.sid = itemDic[@"id"];
            item.sort = itemDic[@"sort"];
            item.question = itemDic[@"question"];
            item.rightAnswer = itemDic[@"realanswer"];
            NSMutableArray *answers = [NSMutableArray array];
            for (NSDictionary *answerDic in itemDic[@"answers"]) {
                AnswerItem *aItem = [[AnswerItem alloc] init];
                aItem.sid = answerDic[@"id"];
                aItem.name = answerDic[@"name"];
                aItem.number = answerDic[@"number"];
                [answers addObject:aItem];
            }
            item.answerItems = [NSArray arrayWithArray:answers];
            item.myAnswerNumber = itemDic[@"myAnswer"];
            if ([itemDic[@"isFinished"] integerValue] == 0) {
                item.isFinished = NO;
            } else {
                item.isFinished = YES;
            }
      
            [questions addObject:item];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        
        NSArray *sortedArray;
        if (questions.count > 0) {
            sortedArray = [questions sortedArrayUsingComparator:^NSComparisonResult(QuestionItem *obj1, QuestionItem *obj2) {
                if (obj1.sort.integerValue < obj2.sort.integerValue) {
                    return NSOrderedAscending;
                }
                if (obj1.sort.integerValue > obj2.sort.integerValue){
                    return NSOrderedDescending;
                }
                return NSOrderedSame;
            }];
        } else {
            sortedArray = [NSArray arrayWithArray:questions];
        }
        
        callback(sortedArray, success);
    }
}

#pragma mark 获取单个或所有学习单的总分数与总时间(所有学习单的没有测试过)
+(DataRequest *)loadScoreAndTimeForLearnBookItems:(NSArray *)lItems  user:(User *)user callback:(void (^)(NSArray *learnBookItems, BOOL success))callback {
    NSAssert(user.sid != nil, @"获取单个或所有学习单的总分数与总时间，user.sid不能为空");
    NSAssert(lItems != nil, @"获取单个或所有学习单的总分数与总时间，lItems不能为空");
    NSAssert(lItems.count > 0, @"获取单个或所有学习单的总分数与总时间，lItems数量要大于0");
    NSString *urlString;
    if (lItems.count == 1) {
        NSString *lId = [[lItems[0] sid] stringValue];
        urlString = [NSString stringWithFormat:@"%@%@/statistics?userId=%@&id=%@", [DataManager shareDataManager].serverAddress, kStudyPath, user.sid, lId];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@/statistics?userId=%@&id=", [DataManager shareDataManager].serverAddress, kStudyPath, user.sid];
    }
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToLearnBookScoresWithRequest:result callback:^(NSArray *learnBookItems, BOOL success) {
                //接口里没给，learnBookItems里面没有sid，learnBookItems里有多个的话，不能判断
                if (learnBookItems.count>0 && lItems.count>0) {
                    LearnBookItem *oldItem = (LearnBookItem *)lItems[0];
                    LearnBookItem *newItem = (LearnBookItem *)learnBookItems[0];
                    oldItem.usedTime = newItem.usedTime;
                    oldItem.score = newItem.score;
                }
                callback(lItems, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

+ (void)convertToLearnBookScoresWithRequest:(DataRequest *)request callback:(void (^)(NSArray *learnBookItems, BOOL success))callback {
    NSMutableArray *learnBookItems = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
            LearnBookItem *item = [[LearnBookItem alloc] init];
            item.sid = dic[@"result"][@"id"];
            item.usedTime = [NSString stringWithFormat:@"%@",dic[@"result"][@"usedTime"]];
            item.score = @([dic[@"result"][@"score"] integerValue]);
            
            [learnBookItems addObject:item];

    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(learnBookItems, success);
    }
}

#pragma mark 获取单个展区的10个题目的耗时和分数
+(DataRequest *)loadScoreAndTimeForLearnBookID:(NSNumber *)learnBookID questionItems:(NSArray *)items user:(User *)user callback:(void (^)(NSArray *questionItems, BOOL success))callback {
    NSAssert(learnBookID != nil, @"获取10个题目的耗时和分数，learnBookID不能为空");
    NSAssert(user.sid != nil, @"获取10个题目的耗时和分数，user.sid不能为空");
#warning TODO:questionItems为空的时候，返回只有耗时和分数的questionItems；
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@/usedTimeList?userId=%@", [DataManager shareDataManager].serverAddress, kStudyPath, learnBookID, user.sid];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToTimeQuestionItemsWithRequest:result callback:^(NSArray *questions, BOOL success) {
                for (QuestionItem *itemOld in items) {
                    for (QuestionItem *itemNew in questions) {
                        if ([itemOld.sid isEqualToNumber:itemNew.sid]) {
                            itemOld.score = itemNew.score;
                            itemOld.usedTime = itemNew.usedTime;
                        }
                    }
                }
                
                callback(items,success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

+ (void)convertToTimeQuestionItemsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *questions, BOOL success))callback {
    NSMutableArray *questions = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    if ([dic[@"result"] count] == 0) {
        callback(questions, success);
        return;
    }
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *itemDic in dic[@"result"]) {
            QuestionItem *item = [[QuestionItem alloc] init];
            item.sid = itemDic[@"id"];
            item.sort = itemDic[@"sort"];
            item.usedTime = [NSString stringWithFormat:@"%@",itemDic[@"usedTime"]];
            item.score = @([itemDic[@"score"] integerValue]);
            
            [questions addObject:item];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        
        NSArray *sortedArray;
        if (questions.count > 0) {
            sortedArray = [questions sortedArrayUsingComparator:^NSComparisonResult(QuestionItem *obj1, QuestionItem *obj2) {
                if (obj1.sort.integerValue < obj2.sort.integerValue) {
                    return NSOrderedAscending;
                }
                if (obj1.sort.integerValue > obj2.sort.integerValue){
                    return NSOrderedDescending;
                }
                return NSOrderedSame;
            }];
        } else {
            sortedArray = [NSArray arrayWithArray:questions];
        }
        
        callback(sortedArray, success);
    }
}

#pragma mark 提交单个问题
+ (DataRequest *)postUserAnswerForQuestionItem:(QuestionItem *)item user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback {
    NSAssert(user.sid != nil, @"提交单个问题,user.sid不能为空");
    NSAssert(item.myAnswerNumber != nil, @"提交单个问题,item.myAnswerNumber不能为空");
    NSAssert(item.usedTime != nil, @"提交单个问题,item.usedTime不能为空");
    NSAssert(item.sid != nil, @"提交单个问题,item.sid不能为空");

    NSString *urlString = [NSString stringWithFormat:@"%@%@/questions/%@/submit", [DataManager shareDataManager].serverAddress, kStudyPath, item.sid];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToPostUserAnswerSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    request.requestMethod = @"POST";
    [request setPostValue:item.myAnswerNumber forKey:@"answer"];
    [request setPostValue:user.sid forKey:@"userId"];
    [request setPostValue:item.usedTime forKey:@"usedTime"];
    
    return request;
}

+ (void)convertToPostUserAnswerSuccessWithRequest:(DataRequest *)request callback:(void (^)(BOOL found, BOOL success))callback
{
    [DataManager convertToJsonWithRequest:request callback:^(NSDictionary *dic, NSString *message, BOOL success) {
        
        BOOL found = NO;
        if (success) {
            @try {
                NSNumber *code = dic[@"code"];
                //－2表示回答错误
                if (code.integerValue == 1 || code.integerValue == -2) {
                    found = YES;
                }
            }
            @catch (NSException *exception) {
                message = exception.description;
                success = NO;
            }
            @finally {
                if (request.showError && !success) {
                    [DataManager showMessage:message dur:request.errorDur];
                }
            }
        }
        
        callback(found, success);
    }];
}

#pragma mark 完成学习单
+ (DataRequest *)postFinishAllQuestionsForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(BOOL posted, BOOL success))callback {
    NSAssert(user.sid != nil, @"完成学习单,user.sid不能为空");
    NSAssert(learnBookID != nil, @"完成学习单,learnBookID不能为空");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@/finished?userId=%@", [DataManager shareDataManager].serverAddress, kStudyPath, learnBookID, user.sid];
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    
    return request;
}

#pragma mark 获取学习单排行榜
+ (DataRequest *)loadAllRankItemsForLearnBookID:(NSNumber *)learnBookID callback:(void (^)(NSArray *rankItems, BOOL success))callback {
  
    NSString *urlString;
    if (learnBookID && learnBookID.integerValue>0) {
        urlString = [NSString stringWithFormat:@"%@%@/rankingList?id=%@", [DataManager shareDataManager].serverAddress, kStudyPath, learnBookID];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@/rankingList", [DataManager shareDataManager].serverAddress, kStudyPath];
    }
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToRankItemsWithRequest:result callback:^(NSArray *items, BOOL success) {
                NSArray *sortedArray = [NSArray arrayWithArray:items];
                //不排序已经从高到低排序了，怕数据多了影响速度，暂时注释掉
//                NSArray *sortedArray = [items sortedArrayUsingComparator:^NSComparisonResult(RankItem *obj1, RankItem *obj2) {
//                    if (obj1.score.integerValue > obj2.score.integerValue) {
//                        return NSOrderedAscending;
//                    }
//                    if (obj1.score.integerValue < obj2.score.integerValue){
//                        return NSOrderedDescending;
//                    }
//                    return NSOrderedSame;
//                }];
                callback(sortedArray, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

+ (void)convertToRankItemsWithRequest:(DataRequest *)request callback:(void (^)(NSArray *items, BOOL success))callback {
    NSMutableArray *rankItems = [NSMutableArray array];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        for (NSDictionary *itemDic in dic[@"result"][@"data"]) {
            RankItem *item = [[RankItem alloc] init];
            item.sid = @([itemDic[@"id"] integerValue]);
            NSTimeInterval interval = ((NSNumber *)itemDic[@"date"]).doubleValue/1000.0;
            item.date = [NSDate dateWithTimeIntervalSince1970:interval];
            item.userName = [NSString stringWithFormat:@"%@",itemDic[@"userName"]];
            item.score = @([itemDic[@"score"] integerValue]);
            item.usedTime = [NSString stringWithFormat:@"%@",itemDic[@"usedTime"]];
            [rankItems addObject:item];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(rankItems, success);
    }
}

#pragma mark 获取我的排行榜信息
+ (DataRequest *)loadMyRankItemForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(RankItem *rankItem, BOOL success))callback {
    NSAssert(user.sid != nil, @"完成学习单,user.sid不能为空");
    
    NSString *urlString;
    if (learnBookID && learnBookID.integerValue>0) {
        urlString = [NSString stringWithFormat:@"%@%@/myRankingInfo?userId=%@&id=%@", [DataManager shareDataManager].serverAddress, kStudyPath, user.sid, learnBookID];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@/myRankingInfo?userId=%@", [DataManager shareDataManager].serverAddress, kStudyPath, user.sid];
    }
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToMyRankItemWithRequest:result callback:^(RankItem *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

+ (void)convertToMyRankItemWithRequest:(DataRequest *)request callback:(void (^)(RankItem *item, BOOL success))callback {
    RankItem *rankItem = [[RankItem alloc] init];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        NSTimeInterval interval = ((NSNumber *)dic[@"result"][@"date"]).doubleValue/1000.0;
        rankItem.date = [NSDate dateWithTimeIntervalSince1970:interval];
        rankItem.userName = [NSString stringWithFormat:@"%@",dic[@"result"][@"userName"]];
        rankItem.score = @([dic[@"result"][@"score"] integerValue]);
        rankItem.usedTime = [NSString stringWithFormat:@"%@",dic[@"result"][@"usedTime"]];
        rankItem.ranking = @([dic[@"result"][@"ranking"] integerValue]);
        rankItem.isMyRank = YES;
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(rankItem, success);
    }
}

#pragma mark 获取已经排序了的包含我的信息的学习单排行榜(iPhone5最多取19条数据，iPhone4:)
+(DataQueue *)loadAllRankInfoForLearnBookID:(NSNumber *)learnBookID user:(User *)user callback:(void (^)(NSArray *sortedRankItems, NSArray *learnBookItems, BOOL success))callback {
    NSAssert(user.sid != nil, @"获取单个展区的10个题目的耗时和分数以及单个学习单总分数与总时间，user.sid不能为空");

    DataRequest *request1 = [DataManager loadAllRankItemsForLearnBookID:learnBookID callback:^(NSArray *rankItems, BOOL success) {
        
    }];
    request1.showHUD = NO;
    
    DataRequest *request2 = [DataManager loadMyRankItemForLearnBookID:learnBookID user:user callback:^(RankItem *rankItem, BOOL success) {
        
    }];
    request2.showHUD = NO;
    
    DataRequest *request3 = [DataManager loadLearnBookItemsWithUser:user callback:^(NSArray *learnBookItems, BOOL success) {
        
    }];
    request3.showHUD = NO;
    
    NSArray *requests = @[request1, request2, request3];
    DataQueue *queue = [LXDataManager requestWithRequests:requests callback:^(DataQueue *result, BOOL success) {
        __block NSArray *noMineItems = [NSArray array];
        __block RankItem *myRankItem = [[RankItem alloc] init];
        __block NSArray *needLearnBookItems = [NSArray array];
        if (success) {
            DataRequest *request1 = result.requests[0];
            [DataManager convertToRankItemsWithRequest:request1 callback:^(NSArray *items, BOOL success) {
                if (items.count>0 && success) {
                    noMineItems = [NSArray arrayWithArray:items];
                    //不排序已经从高到低排序了，怕数据多了影响速度，暂时注释掉
//                    noMineItems = [items sortedArrayUsingComparator:^NSComparisonResult(RankItem *obj1, RankItem *obj2) {
//                        if (obj1.score.integerValue > obj2.score.integerValue) {
//                            return NSOrderedAscending;
//                        }
//                        if (obj1.score.integerValue < obj2.score.integerValue){
//                            return NSOrderedDescending;
//                        }
//                        return NSOrderedSame;
//                    }];
                }
            }];
            
            DataRequest *request2 = result.requests[1];
            [DataManager convertToMyRankItemWithRequest:request2 callback:^(RankItem *item, BOOL success) {
                if (item && success) {
                    myRankItem = item;
                }
            }];
            
            DataRequest *request3 = result.requests[2];
            [DataManager convertToLearnBookItemsWithRequest:request3 callback:^(NSArray *learnBookItems, BOOL success) {
                needLearnBookItems = [NSArray arrayWithArray:learnBookItems];
            }];
        }
        
        NSInteger count = noMineItems.count;
        NSInteger max = 19;
        if (!iPhone5) {
            max = 15;
        }
        if (count > max) {
            count = max;
        }
        NSMutableArray *sortedArray = [NSMutableArray array];
        BOOL alreadyHasMine = NO;
        for (int i=0; i<count; i++) {
            RankItem *aItem = (RankItem *)noMineItems[i];
            if ([aItem.userName isEqualToString:myRankItem.userName] && [aItem.score isEqualToNumber:myRankItem.score] && [aItem.usedTime isEqualToString:myRankItem.usedTime]) {
                aItem.isMyRank = YES;
                aItem.ranking = @(i+1);
                alreadyHasMine = YES;
            }
            [sortedArray addObject:aItem];
        }
        
        if (!alreadyHasMine) {
            [sortedArray removeLastObject];
            [sortedArray addObject:myRankItem];
        }
        callback(sortedArray, needLearnBookItems, success);
        
    }];
    
    return queue;
}


//dsy add

//获取用户关注的标签详情
+(DataRequest *) getInfoLeftMainPageWithUserId:(NSString *)userId mac:(NSString *)user callback:(void (^)(NSArray *items, BOOL success))callback{
    NSString *urlString;

    urlString = [NSString stringWithFormat:@"%@%@/app/label/interest?userId=%@&mac=%@", [DataManager shareDataManager].serverAddress, @"", userId, user];

    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToInterestLabelItemWithRequest:result callback:^(NSArray *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

//获取一个展区的详细信息
+(DataRequest *) getZhanquRoomDetailWithId:(NSString *)rooomId callback:(void (^)(RoomDetailItem *items, BOOL success))callback{
    NSString *urlString;
    
    urlString = [NSString stringWithFormat:@"%@/app/room/%@", [DataManager shareDataManager].serverAddress,rooomId];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToRoomDetailWithRequest:result callback:^(RoomDetailItem *items, BOOL success) {
                callback(items, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

//展区列表
+(DataRequest *) getZhanquRoomList:(NSString *)everthing callback:(void (^)(NSArray *items, BOOL success))callback{
    NSString *urlString;
    
    urlString = [NSString stringWithFormat:@"%@app/room", [DataManager shareDataManager].serverAddress];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToRoomListlWithRequest:result callback:^(NSArray *items, BOOL success) {
                callback(items, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

//获取展区关联信息
+(DataRequest *) getZhanquRoomRelationList:(NSString *)zhanquId  type:(NSString *)type callback:(void (^)(NSArray *items, BOOL success))callback{
    NSString *urlString;
    
    urlString = [NSString stringWithFormat:@"%@app/room/relation?id=%@&type=%@", [DataManager shareDataManager].serverAddress,zhanquId,type];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToRoomRelationWithRequest:result callback:^(NSArray *items, BOOL success) {
                callback(items, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

+ (void)convertToRoomRelationWithRequest:(DataRequest *)request callback:(void (^)(NSArray *items, BOOL success))
    callback {
    NSMutableArray *items = [NSMutableArray array];
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    //格式错误
    @try {
        //NSTimeInterval interval = ((NSNumber *)dic[@"result"][@"date"]).doubleValue/1000.0;
        //interestLabelItem.date = [NSDate dateWithTimeIntervalSince1970:interval];
        
        
        for (NSDictionary *itemDic in dic[@"result"]) {
            RoomRelationItem *item = [[RoomRelationItem alloc] init];
            item.relId = @([itemDic[@"id"] integerValue]);
            
            item.pics = itemDic[@"pics"];
            item.icon = [NSString stringWithFormat:@"%@",itemDic[@"icon"]];
            item.title = itemDic[@"title"];
//            item.name = [NSString stringWithFormat:@"%@",itemDic[@"name"]];
//            item.address = [NSString stringWithFormat:@"%@",itemDic[@"address"]];
//            item.description = [NSString stringWithFormat:@"%@",itemDic[@"description"]];
//            item.icon = [NSString stringWithFormat:@"%@",itemDic[@"icon"]];
//            item.length = [NSString stringWithFormat:@"%@",itemDic[@"length"]];
            
            [items addObject:item];
        }
        
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(items, success);
    }

}


+ (void)convertToRoomListlWithRequest:(DataRequest *)request callback:(void (^)(NSArray *items, BOOL success))callback {
     NSMutableArray *items = [NSMutableArray array];
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    //格式错误
    @try {
        //NSTimeInterval interval = ((NSNumber *)dic[@"result"][@"date"]).doubleValue/1000.0;
        //interestLabelItem.date = [NSDate dateWithTimeIntervalSince1970:interval];
        
        
        for (NSDictionary *itemDic in dic[@"result"]) {
            RoomDetailItem *item = [[RoomDetailItem alloc] init];
            item.detailId = @([itemDic[@"id"] integerValue]);
            item.name = [NSString stringWithFormat:@"%@",itemDic[@"name"]];
            item.summary = [NSString stringWithFormat:@"%@",itemDic[@"summary"]];
            item.map = [NSString stringWithFormat:@"%@",itemDic[@"map"]];
            item.fid = [NSString stringWithFormat:@"%@",itemDic[@"fid"]];
            item.threshold =@([itemDic[@"threshold"] integerValue]);
            item.titlePic = [NSString stringWithFormat:@"%@",itemDic[@"titlePic"]];
            item.summary = [NSString stringWithFormat:@"%@",itemDic[@"summary"]];
            item.serviceId = [NSString stringWithFormat:@"%@",itemDic[@"serviceId"]];
            item.video = [NSString stringWithFormat:@"%@",itemDic[@"video"]];
            item.audio = [NSString stringWithFormat:@"%@",itemDic[@"audio"]];
            item.summary = [NSString stringWithFormat:@"%@",itemDic[@"summary"]];
            item.englishName = [NSString stringWithFormat:@"%@",itemDic[@"englishName"]];
            item.pics =itemDic[@"pics"];
            [items addObject:item];
        }
        
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(items, success);
    }
    
    
}


+ (void)convertToRoomDetailWithRequest:(DataRequest *)request callback:(void (^)(RoomDetailItem *items, BOOL success))callback {
    RoomDetailItem *items = [[RoomDetailItem alloc] init];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    //格式错误
    @try {
        //NSTimeInterval interval = ((NSNumber *)dic[@"result"][@"date"]).doubleValue/1000.0;
        //interestLabelItem.date = [NSDate dateWithTimeIntervalSince1970:interval];
        
        items.detailId = @([dic[@"result"][@"id"] integerValue]);
        items.name = [NSString stringWithFormat:@"%@",dic[@"result"][@"name"]];
        items.summary = [NSString stringWithFormat:@"%@",dic[@"result"][@"summary"]];
        items.map = [NSString stringWithFormat:@"%@",dic[@"result"][@"map"]];
        items.fid = [NSString stringWithFormat:@"%@",dic[@"result"][@"fid"]];
        items.threshold =@([dic[@"result"][@"threshold"] integerValue]);
        items.titlePic = [NSString stringWithFormat:@"%@",dic[@"result"][@"titlePic"]];
        items.summary = [NSString stringWithFormat:@"%@",dic[@"result"][@"summary"]];
        items.serviceId = [NSString stringWithFormat:@"%@",dic[@"result"][@"serviceId"]];
        items.video = [NSString stringWithFormat:@"%@",dic[@"result"][@"video"]];
        items.audio = [NSString stringWithFormat:@"%@",dic[@"result"][@"audio"]];
        items.summary = [NSString stringWithFormat:@"%@",dic[@"result"][@"summary"]];
        items.englishName = [NSString stringWithFormat:@"%@",dic[@"result"][@"englishName"]];
        items.pics =dic[@"result"][@"pics"];
        
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(items, success);
    }


}


+ (void)convertToInterestLabelItemWithRequest:(DataRequest *)request callback:(void (^)(NSArray *items, BOOL success))callback {
    
    //
    NSMutableArray *labelitems = [NSMutableArray array];
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        //NSTimeInterval interval = ((NSNumber *)dic[@"result"][@"date"]).doubleValue/1000.0;
        //interestLabelItem.date = [NSDate dateWithTimeIntervalSince1970:interval];
        for (NSDictionary *itemDic in dic[@"result"]) {
            InterestLabelItem *interestLabelItem = [[InterestLabelItem alloc] init];
            interestLabelItem.type = [NSString stringWithFormat:@"%@",itemDic[@"type"]];
            interestLabelItem.labelId = @([itemDic[@"labelId"] integerValue]);
            interestLabelItem.entityId = @([itemDic[@"entityId"] integerValue]);
            interestLabelItem.icon = [NSString stringWithFormat:@"%@",itemDic[@"icon"]];
            interestLabelItem.displayName = [NSString stringWithFormat:@"%@",itemDic[@"name"]];
            [labelitems addObject:interestLabelItem];
        }
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [DataManager showMessage:message dur:request.errorDur];
        }
        callback(labelitems, success);
    }
}

//问卷调查
+ (DataRequest *)accountsNaire:(NSString *)userId mac:(NSString *)mac origin:(NSString *) origin age:(NSString *)age gender:(NSString *)gender interest:(NSString *)interest callback:(void (^)(BOOL registed, BOOL success))callback

{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareDataManager].serverAddress, accounts_naire];
    NSURL *url = [NSURL URLWithString:urlString];
    
    DataRequest *request = [DataManager requestWithURL:url callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [DataManager convertToSuccessWithRequest:result callback:^(BOOL found, BOOL success) {
                callback(found, success);
            }];
        }else{
            callback(NO, success);
        }
    }];
    

    //
    [request setPostValue:userId forKey:@"userId"];
    [request setPostValue:mac forKey:@"mac"];
    [request setPostValue:origin forKey:@"origin"];
    [request setPostValue:age forKey:@"age"];
    [request setPostValue:gender forKey:@"gender"];
    [request setPostValue:interest forKey:@"interest"];
    
    
    request.requestMethod = @"POST";
    
    return request;
}


@end
