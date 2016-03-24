//
//  User.m
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/22.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import "User.h"
#import "KeychainItemWrapper.h"

@implementation User

- (id)init
{
    if (self) {
        //        //mac
        //        //获取固定uuid
        //        KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
        //        NSString *uuidString = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
        //
        //        //没有uuid, 第一次生成
        //        if ([uuidString isEqualToString:@""] || uuidString == nil) {
        //            [wrapper setObject:[[NSUUID UUID] UUIDString] forKey:(__bridge id)kSecAttrAccount];
        //            uuidString = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
        //        }
        //        //
        //        self.mac = uuidString;
    }
    
    return self;
}

- (void)generateMAC
{
    if (self.mac != nil) {
        return;
    }
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
    NSString *uuidString = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
    
    //没有uuid, 第一次生成
    if ([uuidString isEqualToString:@""] || uuidString == nil) {
        [wrapper setObject:[[NSUUID UUID] UUIDString] forKey:(__bridge id)kSecAttrAccount];
        uuidString = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
    }
    //
    self.mac = uuidString;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.sid = [aDecoder decodeObjectForKey:@"sid"];
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.portraitPath = [aDecoder decodeObjectForKey:@"portraitPath"];
        self.portraitImage = [aDecoder decodeObjectForKey:@"portraitImage"];
        self.mail = [aDecoder decodeObjectForKey:@"mail"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.mac = [aDecoder decodeObjectForKey:@"mac"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        
        self.isAutoLogin = [aDecoder decodeBoolForKey:@"isAutoLogin"];
        self.userType = [aDecoder decodeIntegerForKey:@"userType"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sid forKey:@"sid"];
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.portraitPath forKey:@"portraitPath"];
    [aCoder encodeObject:self.portraitImage forKey:@"portraitImage"];
    [aCoder encodeObject:self.mail forKey:@"mail"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.mac forKey:@"mac"];
    [aCoder encodeObject:self.score forKey:@"score"];
    
    [aCoder encodeBool:self.isAutoLogin forKey:@"isAutoLogin"];
    [aCoder encodeInteger:self.userType forKey:@"userType"];
}

+ (NSString *)confirmUser:(User *)user needPwd:(BOOL)need
{
    NSString *message = nil;
    if (![User conformAccount:user.account]) {
        message = @"请输入有效的用户名";
    }
    if (user.pwd.length <= 0 && need) {
        message = @"请输入密码";
    }
    if (![user.pwd isEqualToString:user.pwd2]  && need){
        message = @"两次输入密码不一致";
    }
    if (user.nickname.length <= 0) {
        message = @"请输入昵称";
    }
    if (user.mail <= 0) {
        message = @"请输入Email";
    }else if (![User confirmEmail:user.mail]) {
        message= @"请输入有效的Email";
    }
    if (user.mobile <=0) {
        message = @"请输入手机号码";
    }else if (![User confirmMobile:user.mobile]){
        message = @"请输入有效手机号码";
    }
    
    return message;
}


#pragma mark - 验证手机、eMail
+ (BOOL)conformAccount:(NSString *)account
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-zA-Z]+[a-zA-Z0-9@\\._-]{1,254}" options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:account options:0 range:NSMakeRange(0, account.length)];
    if (matches.count == 0) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)confirmMobile:(NSString *)mobile
{
    NSError *error;
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(1(([35][0-9])|(47)|[8][01236789]))\\d{8}$" options:0 error:&error];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(1([34578][0-9]))\\d{8}$" options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:mobile options:0 range:NSMakeRange(0, mobile.length)];
    if (matches.count == 0) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)confirmEmail:(NSString *)email
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:email options:0 range:NSMakeRange(0, email.length)];
    if (matches.count == 0) {
        return NO;
    }
    return YES;
}


@end
