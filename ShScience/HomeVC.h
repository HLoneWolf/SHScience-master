//
//  HomeVC.h
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/3.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBasicVC.h"
#import "iCarousel.h"
#import "MZTimerLabel.h"
#import "JCAutocompletingSearchViewController.h"
#import "NHMainHeader.h"
#import "DemoDataManager.h"
#import "TemporaryDisplay.h"
#import "JDFlipNumberView.h"
#import "JDFlipClockView.h"
#import "JDDateCountdownFlipView.h"

@interface HomeVC :NavBasicVC <iCarouselDataSource, iCarouselDelegate,MZTimerLabelDelegate>{
    MZTimerLabel *timerExample3;
    
    NHAutoCompleteTextField *autoCompleteTextField;
    DemoDataManager *manager;
    NSArray *inUseDataSource;
    
    
    
}

@property NSString *rightType; //linzhan,huodong,siwei
@property NSArray *linzhanArr;
@property NSArray *huodongArr;
@property NSArray *siweiArr;

@property (weak, nonatomic) IBOutlet UILabel *julifangyinLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageHour0;
@property (weak, nonatomic) IBOutlet UIImageView *imageHour1;
@property (weak, nonatomic) IBOutlet UIImageView *imageHour2;
@property (weak, nonatomic) IBOutlet UIImageView *imageHour5;
@property JDFlipNumberView *flipNumberView;

@property JDDateCountdownFlipView *filpClockView;


@property (weak, nonatomic) IBOutlet UIImageView *redPoint1;
@property (weak, nonatomic) IBOutlet UIImageView *redPoint2;
@property (weak, nonatomic) IBOutlet UIImageView *redPoint3;

@end
