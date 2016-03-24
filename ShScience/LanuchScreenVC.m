//
//  LanuchScreenVC.m
//  ShScience
//
//  Created by qiya on 16/1/4第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "LanuchScreenVC.h"
#import "StoryboardHelper.h"
#import "SurveryVC.h"
#import "QyUtils.h"
#import "Constant.h"
@implementation LanuchScreenVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[NSThread sleepForTimeInterval:3];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[NSThread sleepForTimeInterval:10];

    if([@"N" isEqualToString: [QyUtils getDefaultValue:@"FIRST_SURVEY"]]){//不是首次进入
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:NO completion:nil];
        });
    }
    else {//是首次进入
        [QyUtils setDefaultValue:@"N" WithKey:@"FIRST_SURVEY"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self dismissViewControllerAnimated:NO completion:nil];
        });
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self dismissViewControllerAnimated:NO completion:nil];//消失启动页面

            [self performSegueWithIdentifier:@"segue_survey" sender:nil];
        });
        

    }
    

}

@end
