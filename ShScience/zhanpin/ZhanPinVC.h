//
//  ZhanPinVC.h
//  ShScience
//
//  Created by qiya on 16/1/30第5周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "InterestLabelItem.h"
#import "RoomDetailItem.h"
#import "TTTAttributedLabel.h"
#import "TemporaryDisplay.h"
#import "FilmItem.h"
#import "NewFilm4DItem.h"
#import "ActivityItem.h"

@interface ZhanPinVC : UIViewController<RKTabViewDelegate>

//@property UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *grayView;


@property InterestLabelItem *selectItem;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zhanPinImageView;

@property TTTAttributedLabel *detailDes;

@property RoomDetailItem *roomDetailItem;

@property NSString *needHiddenNavBar;


@property NSString *type;
@property TemporaryDisplayData *lizhanItem;
@property ActivityItem *huodongItem;
@property SubFilmItem *siweiItem;

@end
