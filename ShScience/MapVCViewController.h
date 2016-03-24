//
//  MapVCViewController.h
//  ShScience
//
//  Created by qiya on 16/1/12第3周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "PathView.h"
#import "SXWaveView.h"
#import "DGActivityIndicatorView.h"
#import "LocateItem.h"

@interface MapVCViewController : UIViewController<RKTabViewDelegate>

@property PathView *pathView ;

@property DGActivityIndicatorView *activityIndicatorView ;

@property UILabel *displayLable;

@property CGFloat lastx;
@property CGFloat lasty;
@property LocateItem *lastLocateItem;

@property(nonatomic,strong)SXWaveView *animateView1;

@property NSArray *infosArra;//InfoItem.h


//默认选择的一些参数设置
@property NSString *selectMapName;
@property CGFloat selectScale;
@property CGPoint selectCenterPoint;


@end
