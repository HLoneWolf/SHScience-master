//
//  RecommandMapVC.h
//  ShScience
//
//  Created by qiya on 16/1/3第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"
#import "PopSelectVC.h"

@interface RecommandMapVC : UIViewController<WYPopoverControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property UIButton *hiddenBtn ;
@property PopSelectVC *vc;
@property WYPopoverController *popover;



@property UITableView *hotPath;
@property UITableView *recommandPath;

//自定义路径
@property UITableView *customPath;
@property NSMutableArray *itemarray;
@property NSInteger currentIdex;



-(void) done:(NSString*) select;
@end
