//
//  AppDelegate.m
//  ShScience
//
//  Created by qiya on 15/12/29第1周.
//  Copyright © 2015年 qiya. All rights reserved.
//

#import "AppDelegate.h"
#import "YTKNetworkConfig.h"
#import "Constant.h"
#import "LCTabBarController.h"
#import "HomeVC.h"
#import "DataManager.h"
#import "Constant.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupYTKNetworkConfig];
    [self setupStatusBar];
    
    return YES;
}

- (void) setupYTKNetworkConfig{
    //设置网络请求 相关 参数
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = URL;
}

- (void) setupStatusBar{
    //设置信号状态栏背景颜色
    //Info.plist设置隐藏状态栏 Status bar is initially hidden value set to YES
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //启动定位
    [DataManager shareDataManager].wanAddress = kServerAddress;
    [DataManager shareDataManager].serverAddress = kServerAddress;
    //开始定位监听
    NSLog(@"DataManager startLocate");
    [DataManager startLocate:^(NSString *result, BOOL success) {
        //
        NSLog(@"DataManager startLocate result=%@",result);
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
