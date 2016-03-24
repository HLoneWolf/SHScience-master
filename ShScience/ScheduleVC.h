//
//  ScheduleVC.h
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSegmentView.h"
#import "FSCalendar.h"
#import "SKSTableView.h"
#import "ShiyanItem.h"
#import "ScheduleItem.h"


@interface ScheduleVC : UIViewController<RFSegmentViewDelegate,FSCalendarDelegate,FSCalendarDataSource,SKSTableViewDelegate>

@property (weak , nonatomic) FSCalendar *calendar;

@property SKSTableView *tableView;

@property UITextField *peopleCountTxt;

@property UITableView *myScheduleView;


@property NSArray *huodongArray;

@property ShiyanItem *shiyanItem;

//@property NSIndexPath *nsIndexPath;

@property NSArray *detailScheduleList;

@property NSDate *defaultSelectDate;

@property ScheduleItem *scheduleItemSelected;



@property NSArray *myOrderList;
@end
