//
//  TabBarVC.m
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "TabBarVC.h"
#import "HomeVC.h"
#import "ScheduleVC.h"
#import "RadioVC.h"
#import "ProfileVC.h"
#import "MoreVC.h"
#import "QyUtils.h"
#import "RecommandMapVC.h"

@implementation TabBarVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //首页菜单加载
    //HomeVC *vc1 = [[HomeVC alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//加载Main.storyboard不需要加上.storyboard
    HomeVC *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"newhomeVC"];
    
    vc1.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tab_photo"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_photo_sel"];
    
    ScheduleVC *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"scheduleVC"];
    vc2.title = @"预约";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tab_schedule"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_schedule_sel"];
    
//    RadioVC *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"radioVC"];
//    vc3.title = @"帮助";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tab_radio"];
//    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_radio_sel"];


    RecommandMapVC *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"recommandMapVC"];
    vc3.title = @"参观线路";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tab_guide"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_guide_sel"];
    

    ProfileVC *vc4 = [storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
    
    vc4.title = @"我的科技馆";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tab_profile"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_profile_sel"];
    //vc4.tabBarItem.badgeValue=@"2";
    
    MoreVC *vc5 = [storyboard instantiateViewControllerWithIdentifier:@"moreVC"];
    
    vc5.title = @"更多";
    vc5.tabBarItem.image = [UIImage imageNamed:@"tab_more"];
    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_more_sel"];
    
    
    UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *navC4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    UINavigationController *navC5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    //LCTabBarController *tabBarC = [[LCTabBarController alloc] init];
    LCTabBarController *tabBarC = self;
    
    tabBarC.viewControllers = @[navC1, navC2, navC3, navC4,navC5];
    [tabBarC.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_background"]];
//    tabBarC.tabBar.frame =  CGRectMake(0, ScreenHeight-40, ScreenWitdh, 40);
//    UIView * transitionView = [[tabBarC.view subviews] objectAtIndex:0];
//    transitionView.height = ScreenHeight-40;
    [[UIApplication sharedApplication].keyWindow setRootViewController:tabBarC];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

}
@end
