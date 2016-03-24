//
//  BigZhanQuVC.h
//  ShScience
//
//  Created by qiya on 16/3/7第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicNaviVC.h"

@interface BigZhanQuVC : BasicNaviVC<UITableViewDelegate,UITableViewDataSource>

@property UITableView *listTable;//表格

@property NSArray *roomArray;

@end
