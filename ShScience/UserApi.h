//
//  UserApi.h
//  ShScience
//
//  Created by qiya on 15/12/30第1周.
//  Copyright © 2015年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"

//参考文档 https://github.com/yuantiku/YTKNetwork/blob/master/BasicGuide.md
//关于RequestAccessory的内容参考 https://github.com/yuantiku/YTKNetwork/issues/12

@interface UserApi : YTKRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

- (NSString *) getResult;
@end
