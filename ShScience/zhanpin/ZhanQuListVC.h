//
//  ZhanQuListVC.h
//  ShScience
//
//  Created by qiya on 16/2/3第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIImagePager.h"
#import "RoomDetailItem.h"


@interface ZhanQuListVC : UIViewController<KIImagePagerDelegate,KIImagePagerImageSource,KIImagePagerDataSource,UITableViewDelegate,UITableViewDataSource>
@property UITableView *zhanquTableView;

@property (strong, nonatomic) NSArray *sampleData;

@property NSArray *arrayChronologicalOrder;

@property KIImagePager *slideShow;


@property RoomDetailItem *roomItem;

@property NSArray *zhanquRelationArr;
@end
