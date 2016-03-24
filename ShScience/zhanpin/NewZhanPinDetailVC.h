//
//  NewZhanPinDetailVC.h
//  ShScience
//
//  Created by qiya on 16/3/22第13周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicNaviVC.h"
#import "InterestLabelItem.h"
#import "TTTAttributedLabel.h"
#import "RKTabView.h"
#import "MyZhanPinDetail.h"

@interface NewZhanPinDetailVC : BasicNaviVC<RKTabViewDelegate>
@property InterestLabelItem *selectItem;
@property TTTAttributedLabel *detailDes;

@property MyZhanPinDetail *itemData;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhanquShijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *name2Label;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *grayView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@end
