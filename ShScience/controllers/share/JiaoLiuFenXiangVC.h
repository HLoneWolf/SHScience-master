//
//  JiaoLiuFenXiangVC.h
//  ShScience
//
//  Created by qiya on 16/3/16第12周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicNaviVC.h"

@interface JiaoLiuFenXiangVC : BasicNaviVC<UITableViewDelegate,UITableViewDataSource>

@property UITableView *xinquTableView;

@property UITableView *zhuanJiaTableView;

@end
