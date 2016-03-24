//
//  RadioVC.h
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicNaviVC.h"

@interface RadioVC : BasicNaviVC<UITableViewDelegate,UITableViewDataSource>


@property UITableView *listTable;


@property NSArray *loucengName;

@property NSMutableArray *allLou;

@property NSArray *typeNameList;

@property NSInteger count;

@property NSArray *lou4;
@property NSArray *lou3;
@property NSArray *lou2;
@property NSArray *lou1;

@end
