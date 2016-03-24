//
//  PlayerVC.h
//  ShScience
//
//  Created by qiya on 16/1/31第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GUIPlayerView.h"
#import "BasicNaviVC.h"

@interface PlayerVC : BasicNaviVC

@property UIView *contentView;

@property NSString *videoUrlStr;
@property NSString *titleName;

@property (weak, nonatomic) IBOutlet GUIPlayerView *guiPlayerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
