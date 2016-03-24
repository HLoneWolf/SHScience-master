//
//  StoryboardHelper.h
//  ShScience
//
//  Created by qiya on 16/1/3第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//简化StoryBoard ViewController的使用工具
@interface StoryboardHelper : NSObject



+ (UIViewController *)getVCByName:(NSString *)storyboardName vcName:(NSString *)vcName;

+ (UIViewController *)getVCByVCName:(NSString *)vcName;

@end


