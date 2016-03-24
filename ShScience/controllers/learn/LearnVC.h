//
//  LearnVC.h
//  ShScience
//
//  Created by qiya on 16/2/4第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicNaviVC.h"


@interface LearnVC : BasicNaviVC<UITableViewDelegate,UITableViewDataSource>

@property UITableView *learnListTable;//学习单表格

@property NSArray *learnItemList;

@property UITableView *rankListTable;//排行表格

@end
