//
//  QiyaRequestAccessory.m
//  ShScience
//
//  Created by qiya on 15/12/30第1周.
//  Copyright © 2015年 qiya. All rights reserved.
//

#import "QiyaRequestAccessory.h"
#import "SVProgressHUD.h"


@implementation QiyaRequestAccessory{
    NSUInteger _type;
    NSString *_message;
}

- (id)initWithHUDType:(NSUInteger )type message:(NSString *)message {
    self =[super init];
    if(self){
        _type = type;
        message = message;
    }
    return self;
}

+ (id)accessoryWithType:(NSUInteger )type message:(NSString *)message {
    return [[self alloc]initWithHUDType:type message:message];
}

+ (id)accessoryWithDefault {
    return [[self alloc]initWithHUDType:SVProgressHUDMaskTypeBlack message:nil];
}

- (void)requestDidStop:(id)request{

    [SVProgressHUD  dismiss];
}
- (void)requestWillStart:(id)request{
    NSLog(@"QiyaRequestAccessory requestWillStart, begin to show HUD");
    if(_type == SVProgressHUDMaskTypeBlack){
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    else {
        [SVProgressHUD show];
    }
    
   
}
@end
