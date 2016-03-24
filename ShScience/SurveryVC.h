//
//  SurveryVC.h
//  ShScience
//
//  Created by qiya on 16/1/3第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LaunchScreenViewController.h"
#import "EFAnimationViewController.h"
#import "CNPPopupController.h"
#import "AKPickerView.h"


//@interface SurveryVC : LaunchScreenViewController
@interface SurveryVC : UIViewController<CNPPopupControllerDelegate,EFItemViewDelegate,EFAnimationViewDelegate,AKPickerViewDelegate,AKPickerViewDataSource>

@property NSString *needBack;

@property NSArray *agearr;
@property NSArray *birtharr;
@property NSArray *timesarr;
@property NSArray *likearr;

@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (weak, nonatomic) IBOutlet UIButton *manBtn;


@property NSString *gender;
@property NSString *comeTimes;
@property NSString *ages;
@property NSString *origin;
@property NSString *interest;


@end
