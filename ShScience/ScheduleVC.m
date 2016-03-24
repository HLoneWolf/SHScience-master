//
//  ScheduleVC.m
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ScheduleVC.h"
#import "QyUtils.h"
#import "DateTools.h"
#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"
#import "DLRadioButton.h"
#import "AttenceTimelineCell.h"
#import "NkContainerCellView.h"
#import "NKContainerCellTableViewCell.h"
#import "DataManager.h"
#import "FilmItem.h"
#import "ActivityItem.h"
#import "QyDataManger.h"
#import "ScheduleItem.h"
#import "StoryboardHelper.h"
#import "LoginVC.h"

#define dataSourceArr @[@"06-13 16:31 提交至店长 shopmanagerA, 确认完毕", @"06-13 16:31 上班考勤 提交成功", @"06-13 16:31 提交至店长 shopmanagerA, 确认完毕", @"06-13 16:31 上班考勤 提交成功", @"06-13 16:31 提交至店长 shopmanagerA, 确认完毕", @"06-13 16:31 上班考勤 提交成功"]


@implementation ScheduleVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    _defaultSelectDate = [NSDate date];//初始化选择日期
    
    [self initliazeUser];//注册消息
    
    CGRect aRect = CGRectMake(-12, 20, ScreenWitdh+24, 60);

    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:aRect items:@[@"展项",@"教育活动",@"我的预约"]];
    //segmentView.backgroundColor = [UIColor redColor];
    segmentView.tintColor       = [UIColor clearColor];
    segmentView.itemHeight      = 44.0f;
    segmentView.leftRightMargin = 0.f;
    segmentView.segementItemNorColor = RGB(39, 127, 195);
    segmentView.segementItemSelColor = [UIColor whiteColor];
    
    segmentView.handlder        = ^ (RFSegmentView * __nullable view, NSInteger selectedIndex) {
        // doSomething
        if(selectedIndex==1){//教育活动
            //预约表格
//            [self setupHuodong];
            [self requestHuodong];//网络请求--教育活动列表
        }
        else if(selectedIndex==2){//我的预约
            [self removeOtherView];
            [self requestGetMySchedule];
            _myScheduleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, ScreenWitdh, ScreenHeight)];
            _myScheduleView.dataSource = self;
            _myScheduleView.delegate = self;
            _myScheduleView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [_myScheduleView setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:_myScheduleView];
        }
        else if(selectedIndex == 0){//展项
            //预约表格
//            [self setupHuodong];
//            [self requestHuodong];//网络请求--教育活动列表
            
        }
    };
    
    segmentView.selectedIndex = 1;
    [self.view addSubview:segmentView];
    
    [SKSTableViewCellIndicator setIndicatorColor:[UIColor whiteColor]];
    CGRect tableRect = CGRectMake(0, 80, ScreenWitdh, ScreenHeight-90);
    _tableView = [[SKSTableView alloc]initWithFrame:tableRect];
    _tableView.SKSTableViewDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    [self requestHuodong];//网络请求--教育活动列表
}

-(void)setupHuodong {
    [self removeOtherView];
    [SKSTableViewCellIndicator setIndicatorColor:[UIColor whiteColor]];
    CGRect tableRect = CGRectMake(0, 80, ScreenWitdh, ScreenHeight-90);
    _tableView = [[SKSTableView alloc]initWithFrame:tableRect];
    _tableView.SKSTableViewDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)removeOtherView{
    for (UIView *view in self.view.subviews) {
        if (![view isKindOfClass:[RFSegmentView class]]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - FSCalendar相关的操作

//今天之前的日期不能选择
//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
//{
//    NSDate * date = [NSDate date];
//    return date;
//}

//今天之后3个月的日期不能选择
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    NSDate * date = [NSDate date];
    NSDate *newDate = [date dateByAddingMonths:3];
    return newDate;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    _defaultSelectDate = date;
    //发送一消息
    [[NSNotificationCenter defaultCenter ]postNotificationName:@"CalendarSelectDate" object:nil userInfo:@{@"selectDate":date}];
}

-(void) initliazeUser {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reGetHuoDong:) name:@"CalendarSelectDate" object:nil];
}

- (void)reGetHuoDong:(NSNotification *)notification{
    NSDate *date = notification.userInfo[@"selectDate"];
    [self requestHuodong];
}

#pragma mark - UITableViewDataSource 表格DataSource Delegator

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //我的预约表格
    if(tableView==_myScheduleView){
        return [_myOrderList count];
    }
    
    if(tableView == _tableView){
        if(_huodongArray!=nil&& [_huodongArray count]>0){
            NSLog(@"[_huodongArray count] + 1==%i",[_huodongArray count] + 1);
            return [_huodongArray count] + 1;
        }
        else {
            return 1;
        }
    }

    return 4;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        return NO;
    }
    return NO;
}

#define TableViewCellID @"TableViewCellID"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_myScheduleView){
        return [self setUpMyScheduleCell:tableView cellForRowAtIndexPath:indexPath];
        
    }//end return _mySchedule tableview
    
    return [self setupHuodongCell:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - 教育活动的单元表格绘制
- (UITableViewCell *)setupHuodongCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"SKSTableViewScheduleCell";
    
//    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SKSTableViewCell *cell =nil;
    if (!cell)
        if(indexPath.row!=0){
            cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        else {
            cell =[[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.expandable=NO;
        }
    
    if(indexPath.row!=0){
        NSLog(@"set expandImage %i",indexPath.row);
        cell.expandImage = [UIImage imageNamed:@"expandImage_white"];
    }
    NSLog(@"setupHuodongCell ===%@",cell);
    if(indexPath.row == 0 && indexPath.section == 0){
        [self setupCalendar:cell];//设置日历
    }
    else {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 20)];
//
        if(_huodongArray&&[_huodongArray count]>0){
            ActivityItem * item =(ActivityItem *)_huodongArray[indexPath.row -1];
            label.text = item.name;
        }
        else{
            //label.text = @"科技小知识专题活动";
        }
        
        label.textColor = [UIColor whiteColor];
        [cell addSubview:label];
        [self addSepatorLine:cell frame:[self getRectOfCellSection:indexPath.section row:indexPath.row]];
    }
    
    //单元格被选中的风格无变色
    cell.opaque = NO;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - 我的预约单元表格绘制
-(UITableViewCell *) setUpMyScheduleCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell1;
    OrderItem *orderItem = nil;
    if(_myOrderList && [_myOrderList count]>0){
        orderItem = [_myOrderList objectAtIndex:indexPath.row -1];
    }
    
    if (cell1 == nil)
        
    {
        
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:TableViewCellID];
        
    }
    UIImageView *bigCircleView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 30, 30)];
    bigCircleView.image = [UIImage imageNamed:@"my_sche_big_cirl"];
    
    UIView *verline1 = [[UIView alloc] initWithFrame:CGRectMake(22, 10, 1, 65)];
    verline1.backgroundColor = [UIColor whiteColor];
    
    UIView *verline2 = [[UIView alloc] initWithFrame:CGRectMake(22, 75, 1, 150)];
    verline2.backgroundColor = [UIColor whiteColor];
    
    UIImageView *smallCircleView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 70, 20, 20)];
    smallCircleView.image = [UIImage imageNamed:@"my_sche_small_cirl"];
    
    UIImageView *zoneView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 55, ScreenWitdh-40, 120)];
    zoneView.image = [UIImage imageNamed:@"mysche_zone"];
    
    //文字
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 150, 20)];
    label1.textColor = [UIColor whiteColor];
    label1.text = @"2016-02-01";
    if(orderItem){
        label1.text = orderItem.bookDate;
    }
    label1.font = [UIFont systemFontOfSize:20.0f];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(45, 60, 150, 20)];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"13:00-14:00";
    if(orderItem){
        label2.text = orderItem.beginTime;
    }
    label2.font = [UIFont systemFontOfSize:24.0f];
    
    
    UILabel *label2_2 = [[UILabel alloc]initWithFrame:CGRectMake(45, 80, 160, 80)];
    label2_2.textColor = [UIColor whiteColor];
    label2_2.text = @"巨幕电影 功夫熊猫  \n预约验证码:1882222";
    if(orderItem){
        NSString *text = [NSString stringWithFormat:@"%@  \n预约验证码:%@",orderItem.name,orderItem.bookCode];
        label2_2.text = text;
    }
    label2_2.lineBreakMode = NSLineBreakByWordWrapping;
    label2_2.numberOfLines = 0;
    label2_2.font = [UIFont systemFontOfSize:17.0f];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWitdh-113, 95, 150, 40)];
    label3.textColor = [UIColor whiteColor];
    label3.text = @"即将开始";
    if(orderItem){
        NSString *text = [NSString stringWithFormat:@"%@ %@",orderItem.bookDate,orderItem.beginTime];
        NSDate *d1 = [QyUtils dateFromString:text foramtStr:@"yyyy-MM-dd HH:mm"];
        NSDate *d2 = [NSDate date];
        switch ([d1 compare:d2]){
            case NSOrderedAscending:
                break;
            case NSOrderedSame:
                break;
            case NSOrderedDescending:
                label3.text = @"已结束";
                break;
        }
    }
    label3.font = [UIFont systemFontOfSize:24.0f];
    
    
    [cell1 addSubview:bigCircleView];
    [cell1 addSubview:zoneView];
    [cell1 addSubview:smallCircleView];
    [cell1 addSubview:verline1];
    [cell1 addSubview:verline2];
    [cell1 addSubview:label1];
    [cell1 addSubview:label2];
    [cell1 addSubview:label2_2];
    [cell1 addSubview:label3];
    
    [cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell1;

}

#pragma mark - 子表格属性

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    CGRect frame = [self getRectOfCellSection:0 row:1];
    [self setupSubCellSchedule:cell withFrame:frame  tableView:tableView indexPath:indexPath];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -预约时间选择框
- (void)logSelectedButton:(DLRadioButton *)radiobutton {
    if (radiobutton.isMultipleSelectionEnabled) {
        for (DLRadioButton *button in radiobutton.selectedButtons) {
            NSLog(@"%@ is selected.\n", button.titleLabel.text);
        }
    } else {
        
        NSLog(@"%@ is selected tag=%i.\n", radiobutton.selectedButton.titleLabel.text,radiobutton.selectedButton.tag);

        _scheduleItemSelected = [_detailScheduleList objectAtIndex:radiobutton.selectedButton.tag-400];
    }
}

#pragma mark -SKSTableView的对应方法

//需要 把SKSTableView的对应方法打开
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==_myScheduleView){
        return;
    }
    [cell setBackgroundColor:[UIColor clearColor]];
}


- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _myScheduleView){
        return 200;
    }
    
    if(indexPath.section==0 &&indexPath.row ==0){
        return 300.0f;
    }
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _nsIndexPath = indexPath;
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
    
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

#pragma mark -得到单元格的大小
-(CGRect) getRectOfCellSection:(NSInteger) section row:(NSInteger) row {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    CGRect frame = [self.tableView rectForRowAtIndexPath:indexPath];
    //NSLog(@"cell size height=%f width=%f",frame.size.height,frame.size.width);
    return frame;
}
//单元格分割线
-(void) addSepatorLine:(SKSTableViewCell *)cell frame:(CGRect) frame {
    UIView *sepatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 1)];
    sepatorLine.backgroundColor = RGB(67, 123, 168);
    [cell addSubview:sepatorLine];
}

//键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //[_searchTextField endEditing:YES];
}

#pragma mark - setup 页面中的视图
-(void)setupCalendar:(SKSTableViewCell *) cell {
    //日历框
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, ScreenWitdh, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = NO;
    self.calendar = calendar;
    _calendar.appearance.headerTitleColor = [UIColor whiteColor];
    _calendar.appearance.weekdayTextColor = [UIColor whiteColor];
    _calendar.appearance.titleDefaultColor = [UIColor whiteColor];
    //_calendar.allowsMultipleSelection = NO;
    //隐藏左右两边的月份
    _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
    
    [cell addSubview:_calendar];
}

#pragma mark - 子表格内容设置
-(void) setupSubCellSchedule:(UITableViewCell *) cell withFrame:(CGRect) frame tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    //网络请求--预约表格的数据
    [self requestHuodongDetail];
    
    CGFloat fontSize = 15.0f;
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, frame.size.width -10, 60)];
    descLabel.text = @"  要实现自动调整字体大小功能，就没有可以自适应的系统方法可以使用，只有自己用代码实现，在设计时因为要考虑到手机屏幕的实际大小有限。要实现自动调整字体大小功能，就没有可以自适应的系统方法可以使用，只有自己用代码实现，在设计时因为要考虑到手机屏幕的实际大小有限";
    descLabel.text = _shiyanItem.contents;
    descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    descLabel.numberOfLines = 4;
    descLabel.textColor = [UIColor whiteColor];
    descLabel.font =font;
    [descLabel sizeToFit];
    cell.opaque = NO;
    [SKSTableViewCellIndicator setIndicatorColor:[UIColor clearColor]];
    
    
    //第二行 人数
    CGFloat descLabelHeightAdd10 = descLabel.frame.size.height+20;
    UILabel *scheduleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, descLabelHeightAdd10, 60, 20)];
    scheduleLabel.text = @"预约人数";
    scheduleLabel.textColor = [UIColor whiteColor];
    scheduleLabel.font = font;
    
    UIButton *subBtb = [[UIButton alloc]initWithFrame:CGRectMake(100, descLabelHeightAdd10, 20, 20)];
    subBtb.backgroundColor =RGB(39, 127, 195);
    [subBtb setBackgroundImage:[UIImage imageNamed:@"subBtn1"] forState:UIControlStateNormal];
    [subBtb addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _peopleCountTxt = [[UITextField alloc]initWithFrame:CGRectMake(120, descLabelHeightAdd10, 40, 20)];
    _peopleCountTxt.backgroundColor = [UIColor whiteColor];
    _peopleCountTxt.text = @"1";
    _peopleCountTxt.textAlignment = NSTextAlignmentCenter;
    
    UIButton *addBtb = [[UIButton alloc]initWithFrame:CGRectMake(160, descLabelHeightAdd10, 20, 20)];
    addBtb.backgroundColor =RGB(39, 127, 195);
    [addBtb setBackgroundImage:[UIImage imageNamed:@"addBtn1"] forState:UIControlStateNormal];
    [addBtb addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *freeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+200, descLabelHeightAdd10, 60, 20)];
    freeLabel.text = @"免费预约";
    if([@"1" isEqualToString:_shiyanItem.type]){
        freeLabel.text = @"支付预约";
    }
    freeLabel.textColor = [UIColor whiteColor];
    freeLabel.font = font;
    
    //第三行场地
    CGFloat row3Heigh = descLabelHeightAdd10 + 40;
    UILabel *localLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, row3Heigh, 60, 20)];
    localLabel.text = @"地点";
    localLabel.textColor = [UIColor whiteColor];
    localLabel.font = font;
    
    UILabel *tkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+100, row3Heigh, 60, 20)];
    tkLabel.text = @"太空影院";
    tkLabel.text = _shiyanItem.scientist;
    tkLabel.textColor = [UIColor whiteColor];
    tkLabel.font = font;
    
    //第四行 场次
    CGFloat row4Heigh = descLabelHeightAdd10 + 70;
    UILabel *changciLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, row4Heigh, 60, 20)];
    changciLabel.text = @"选择场次";
    changciLabel.textColor = [UIColor whiteColor];
    changciLabel.font = font;
    
    //--排片 安排  信息
    NSDate *date = [QyUtils dateFromString:@"2016-03-08" foramtStr:@"yyyy-MM-dd"];
    ActivityItem *item =(ActivityItem *)_huodongArray[indexPath.row -1];
    [self requestHuoDongDetailSchedule:item date:date];
    
    
    ScheduleItem *firstItem = nil;
    int otherCount = 0;
    if([_detailScheduleList count]>0){
        firstItem = [_detailScheduleList objectAtIndex:0];
        otherCount = [_detailScheduleList count] -1;
    }
    

    // first button
    CGFloat indicatorSize = 10;
    CGFloat iconSize = 20;
    CGFloat  marginWidth = 30;
    CGFloat   iconStrokeWidth= 1;
    CGFloat radioHeight = 60;
    
    
    
    CGFloat row5Height = descLabelHeightAdd10 + 80;
    DLRadioButton *firstRadioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(10, row5Height,200, radioHeight)];
    firstRadioButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [firstRadioButton setTitle:@"08:30-09:30" forState:UIControlStateNormal];
    if(firstItem){
        NSString *timeStr = [NSString stringWithFormat:@"%@",firstItem.beginTime];
        [firstRadioButton setTitle:timeStr forState:UIControlStateNormal];
        firstRadioButton.tag = 400;
    }
    [firstRadioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    firstRadioButton.iconColor = [UIColor whiteColor];
    firstRadioButton.indicatorColor = [UIColor whiteColor];
    firstRadioButton.indicatorSize = indicatorSize;
    firstRadioButton.iconSize = iconSize;
    firstRadioButton.marginWidth = marginWidth;
    firstRadioButton.iconStrokeWidth = iconStrokeWidth;
    firstRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstRadioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *leftmanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+50, row5Height+radioHeight-15, 200, 10)];
    leftmanLabel.text = @"还有5个名额";
    if(firstItem){
        NSString *leftStr = [NSString stringWithFormat:@"还有%@个名额",firstItem.bookNum];
        leftmanLabel.text = leftStr;
    }
    leftmanLabel.textColor=[UIColor grayColor];
    leftmanLabel.font = [UIFont systemFontOfSize:12];
    
    
    // other buttons
//    NSArray *colorNames = @[@"10:00-11:00", @"11:00-12:30"];
//    NSArray *buttonColors = @[[UIColor whiteColor], [UIColor whiteColor]];
    
    
    NSInteger i = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];
    //for (UIColor *buttonColor in buttonColors) {
    for (ScheduleItem *sc in _detailScheduleList) {
        if(i!=0){
    // customize button
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(10, row5Height+radioHeight+radioHeight * i, 200,40)];
        radioButton.titleLabel.font = [UIFont systemFontOfSize:20];
            radioButton.tag = 400+i;
        [radioButton setTitle:sc.beginTime forState:UIControlStateNormal];
        [radioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        radioButton.iconColor = [UIColor whiteColor];
        radioButton.indicatorColor = [UIColor whiteColor];
        radioButton.indicatorSize = indicatorSize;
        radioButton.iconSize = iconSize;
        radioButton.marginWidth = marginWidth;
        radioButton.iconStrokeWidth = iconStrokeWidth;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [otherButtons addObject:radioButton];
        [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:radioButton];
             }
        i++;
    }
    
    firstRadioButton.otherButtons = otherButtons;
    
        
    //预约按钮
    UIButton *checkScheduleBut = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh-50-radioHeight, row5Height, radioHeight, radioHeight)];
    [checkScheduleBut setBackgroundImage:[UIImage imageNamed:@"schedule_btn"] forState:UIControlStateNormal];
    [checkScheduleBut setTitle:@"预约" forState:UIControlStateNormal];
    [checkScheduleBut addTarget:nil action:@selector(scheduleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:subBtb];
    [cell addSubview:addBtb];
    [cell addSubview:_peopleCountTxt];
    [cell addSubview:freeLabel];
    [cell addSubview:firstRadioButton];
    [cell addSubview:leftmanLabel];
    [cell addSubview: checkScheduleBut];
    
    [cell addSubview:localLabel];
    [cell addSubview:tkLabel];
    
    [cell addSubview:changciLabel];
    
    [cell addSubview:scheduleLabel];
    [cell addSubview:descLabel];

}

#pragma mark - 人数加减按钮响应事件
-(void)addBtnClick:(UIButton* )btn{
    NSString *text = _peopleCountTxt.text;
    if([text isEqualToString:@"10"]){
        return;
    }
    NSInteger newValue = [text integerValue] + 1;
    _peopleCountTxt.text = [NSString stringWithFormat: @"%ld", (long)newValue];
}

-(void)subBtnClick:(UIButton* )btn{
    NSString *text = _peopleCountTxt.text;
    if([text isEqualToString:@"1"]){
        return;
    }
    NSInteger newValue = [text integerValue] - 1;
    _peopleCountTxt.text = [NSString stringWithFormat: @"%ld", (long)newValue];
}
#pragma mark - 预约按钮
-(void)scheduleBtnClick{
    
    NSString *people = _peopleCountTxt.text;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:people];
    User *user = [DataManager getUser];
    //_scheduleItemSelected
    //_defaultSelectDate
    if(user==nil){
        //登录调入
        LoginVC *vc = (LoginVC *)[StoryboardHelper getVCByVCName:@"loginVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        DataRequest *r = [DataManager loadPreorderWithScheduleItem:_scheduleItemSelected user:user num:myNumber playDate:_defaultSelectDate callback:^(NSString *code, BOOL success) {
            //
            if(success){
                //预约成功
                [QyUtils navbarInfoToast:@"恭喜您，预约成功"];
            }
        }];
        [r startAsynchronous];
    }
}

#pragma mark - 网络请求

-(void) requestHuodong {
    //NSDate *date = [QyUtils dateFromString:@"2016-03-08" foramtStr:@"yyyy-MM-dd"];
    NSDate *date = _defaultSelectDate;
    if(_defaultSelectDate==nil){
        _defaultSelectDate=[QyUtils dateFromString:@"2016-03-08" foramtStr:@"yyyy-MM-dd"];
    }
    DataRequest *r =[DataManager loadFilmsOrActivitysForType:OrderTypeActivity currentpage:1 countOfOnePage:3 date:date callback:^(NSArray *filmsOrActivitys, BOOL success) {
        //filmsOr--
        _huodongArray = filmsOrActivitys;
        [self setupHuodong];
        
    }];
    
    [r startSynchronous];
    
}


-(void) requestHuodongDetail {
    
    DataRequest *r =[QyDataManger getShiyanInfoWithStartdate:@"" callback:^(ShiyanItem *item, BOOL success) {
        //
        _shiyanItem = item;
    }];
    [r startSynchronous];
}

-(void) requestHuoDongDetailSchedule :(NSObject *)item date:(NSDate *)date{
    //(DataRequest *)newLoadSchedulesWithItem:(NSObject *)item date:(NSDate *)date callback:(void (^)(NSArray *schudules, BOOL success))callback
    
    DataRequest *r = [DataManager newLoadSchedulesWithItem:item date:date callback:^(NSArray *schudules, BOOL success) {
        //
        _detailScheduleList = schudules;
    }];
    [r startSynchronous];
}

-(void) requestGetMySchedule {
    User *user = [DataManager getUser];
    //_scheduleItemSelected
    //_defaultSelectDate
    if(user==nil){
        //登录调入
        LoginVC *vc = (LoginVC *)[StoryboardHelper getVCByVCName:@"loginVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        DataRequest *r = [DataManager loadAppointmentWithUser:user callback:^(NSArray *orders, BOOL success) {
            _myOrderList = orders;
        }];
        [r startSynchronous];
    }

}

@end
