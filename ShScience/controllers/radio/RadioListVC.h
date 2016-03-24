//
//  RadioListVC.h
//  ShScience
//
//  Created by qiya on 16/3/8第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicNaviVC.h"
#import <AVFoundation/AVFoundation.h>
#import "STKAudioPlayer.h"


@interface RadioListVC : BasicNaviVC<UITableViewDelegate,UITableViewDataSource>

@property UITableView *listTable;
@property (weak, nonatomic) IBOutlet UIView *grayView;

@property NSMutableArray *radioList;

@property NSMutableArray *playButtonList;

@property NSString *typeName;
@property STKAudioPlayer *audioPlayer;

@property NSInteger currentIdex;
@end
