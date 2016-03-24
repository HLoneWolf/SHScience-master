//
//  PopSelectVC.h
//  ShScience
//
//  Created by qiya on 16/3/2第10周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompletionTableView.h"

@protocol AutocompletionTableViewDelegate;


@interface PopSelectVC : UIViewController<AutocompletionTableViewDelegate>

@property NSString *selectId;

@property UIButton  *callBtn;

@property (nonatomic, retain) id delgate;

@end
