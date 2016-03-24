//
//  UserApi.m
//  ShScience
//
//  Created by qiya on 15/12/30第1周.
//  Copyright © 2015年 qiya. All rights reserved.
//

#import "UserApi.h"
#import "SVProgressHUD.h"
#import "QiyaRequestAccessory.h"

@implementation UserApi{
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password{
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    //加载转动符号提示
    [self addAccessory:[QiyaRequestAccessory accessoryWithDefault]];

    return self;
}

- (NSString *)requestUrl {
    //在 APPDelegate YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
  return @{ @"username" : _username, @"password" : _password };
}

/// 用于检查JSON是否合法的对象
- (id)jsonValidator {
  return @{ @"code" : [NSString class], @"message" : [NSString class] };
}

- (NSString *) getResult {
    return [[self responseJSONObject] objectForKey:@"code"];
}




@end
