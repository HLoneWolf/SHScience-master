//
//  HelpVC.h
//  ShScience
//
//  Created by qiya on 16/2/25第9周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicNaviVC.h"
#import "HelpItem.h"

@interface HelpVC : BasicNaviVC<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *gravyView;

@property UITableView * listTable;


@property NSArray *helpList;
@property HelpItem *helpItem;
@end
