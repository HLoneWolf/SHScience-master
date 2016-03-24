//
//  User.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/22.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///用户类型
typedef enum {
    UserCommon = 0,     //普通用户
    UserExpert = 1,     //专家
} UserType;

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pwd;
///第二次输入的验证密码
@property (nonatomic, strong) NSString *pwd2;
@property (nonatomic, strong) NSString *nickname;
///下载URL
@property (nonatomic, strong) NSString *portraitPath;
///上传用的image
@property (nonatomic, strong) UIImage *portraitImage;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *mac;
///社区积分
@property (nonatomic, strong) NSNumber *score;
///是否自动登录
@property (nonatomic, assign) BOOL isAutoLogin;
///用户类型
@property (nonatomic, assign) UserType userType;

///生成mac地址
- (void)generateMAC;

///验证账号
+ (BOOL)conformAccount:(NSString *)account;

///用户有效性验证
+ (NSString *)confirmUser:(User *)user needPwd:(BOOL)need;

@end
