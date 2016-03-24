//
//  ProfileVC.h
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "ProfileFileOwner.h"

@interface ProfileVC : UIViewController<SKSTableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet SKSTableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (nonatomic, strong) NSArray *contents;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@property ProfileFileOwner *owner;

@end
