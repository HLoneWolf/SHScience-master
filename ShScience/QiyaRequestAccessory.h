//
//  QiyaRequestAccessory.h
//  ShScience
//
//  Created by qiya on 15/12/30第1周.
//  Copyright © 2015年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"
//请求网络时的提示信息
@interface QiyaRequestAccessory : NSObject<YTKRequestAccessory>

- (id)initWithHUDType:(NSUInteger )type message:(NSString *)message;

- (void)requestDidStop:(id)request;

- (void)requestWillStart:(id)request;

+ (id)accessoryWithType:(NSUInteger )type message:(NSString *)message;

+ (id)accessoryWithDefault;

@end
