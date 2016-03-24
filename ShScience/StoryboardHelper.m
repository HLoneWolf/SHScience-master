//
//  StoryboardHelper.m
//  ShScience
//
//  Created by qiya on 16/1/3第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "StoryboardHelper.h"

@implementation StoryboardHelper


+ (UIViewController *)getVCByName:(NSString *)storyboardName vcName:(NSString *)vcName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:vcName bundle:nil];//加载Main.storyboard不需要加上.storyboard
    UIViewController *vc1 = [storyboard instantiateViewControllerWithIdentifier:vcName];
    return vc1;
}

+ (UIViewController *)getVCByVCName:(NSString *)vcName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//加载Main.storyboard不需要加上.storyboard
    UIViewController *vc1 = [storyboard instantiateViewControllerWithIdentifier:vcName];
    return vc1;
}

@end
