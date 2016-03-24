//
//  ProfileVC.m
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ProfileVC.h"
#import "SKSTableViewCell.h"
#import "QyUtils.h"
#import "ProfileFileOwner.h"
#import "LoginVC.h"
#import "StoryboardHelper.h"
#import "Constant.h"
#import "User.h"
@implementation ProfileVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    
    self.tableView.SKSTableViewDelegate = self;
    
    //设置表格背景颜色和透明度
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setShowsVerticalScrollIndicator:NO];
    _owner = [ProfileFileOwner fileOwnerFromNibNamed];
    
}

- (NSArray *)contents
{
    if (!_contents)
    {
        _contents = @[
                      @[
                          @[@""],
                          @[@""],
                          @[@"",@""],
                          @[@""],
                          @[@""],
                          @[@""],
                          @[@""]]
                      ];
    }
    
    return _contents;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"count=%lu",(unsigned long)[self.contents count]);
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"section=%li,count=%lu",(long)section,(unsigned long)[self.contents[section] count]);
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    //默认打开的表格
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        return YES;
    }
    
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    

        cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];

    
    //设置透明度
    cell.expandImage = [UIImage imageNamed:@"expandableImage"];
    cell.opaque = NO;
    cell.backgroundColor =RGBA(176, 176, 176, 0.4);//表格的背景颜色
    
    
    if(indexPath.section==0 && indexPath.row == 0){
        [self setRow0:cell];
    }
    if(indexPath.section==0 && indexPath.row == 1){
        [self setRow1:cell];
    }
    if(indexPath.section==0 && indexPath.row == 2){
        [self setRow2:cell];
    }
    if(indexPath.section==0 && indexPath.row == 3){
        [self setRow3:cell];
    }
    if(indexPath.section==0 && indexPath.row == 4){
        [self setRow4:cell];
    }
    if(indexPath.section==0 && indexPath.row == 5){
        [self setRow5:cell];
    }
    if(indexPath.section==0 && indexPath.row == 6){
        [self setRow6:cell];
    }
    
    //带打开按钮的cell
    if  (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row ==1) )
        cell.expandable = NO;
    else
        cell.expandable = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    CGRect frame = [self getRectOfCellSection:0 row:1];
    NSLog(@"cell size height=%f width=%f",frame.size.height,frame.size.width);

    _owner.pathView.frame = CGRectMake(0, 15, frame.size.width,60 );
    _owner.pathView.backgroundColor = [UIColor clearColor];
    [cell addSubview: _owner.pathView];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105.0f;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0 &&indexPath.row ==0){
        return 115.0f;
    }
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}


#pragma mark -第一行三个按钮
-(void)setRow0:(SKSTableViewCell*)cell {
    
    CGRect frame = [self getRectOfCellSection:0 row:0];
    CGFloat leadingSpace = 35.0f;
    _owner.commentView.frame = CGRectMake(leadingSpace, 40, 60, 60);
    _owner.commentView.backgroundColor = [UIColor clearColor];
    
    
    _owner.likeView.frame = CGRectMake(frame.size.width/2-30, 40, 60, 60);
    _owner.likeView.backgroundColor = [UIColor clearColor];
    
    _owner.settingView.frame = CGRectMake(frame.size.width-leadingSpace-60, 40, 60, 60);
    _owner.settingView.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:_owner.commentView];
    [cell addSubview:_owner.likeView];
    [cell addSubview:_owner.settingView];
    [cell bringSubviewToFront:_owner.commentBtn];
    [cell bringSubviewToFront:_owner.likeBtn];
    [cell bringSubviewToFront:_owner.settingBtn];
    //添加按钮响应事件
    [_owner.commentBtn addTarget:self action:@selector(commentBtn) forControlEvents:UIControlEventTouchUpInside];
    [_owner.likeBtn addTarget:self action:@selector(likeBtn) forControlEvents:UIControlEventTouchUpInside];
    [_owner.settingBtn addTarget:self action:@selector(settingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSepatorLine:cell frame:frame];
}

//第二行积分
-(void)setRow1:(SKSTableViewCell*)cell {
    CGRect frame = [self getRectOfCellSection:0 row:1];
    _owner.pointView.frame = CGRectMake(0, 15, frame.size.width,60 );
    _owner.pointView.backgroundColor = [UIColor clearColor];
    NSNumber *score =(NSNumber *)[QyUtils getDefaultValueObject:USER_SCORE];
    if(score!=nil){
        NSString *str = [NSString stringWithFormat:@"%@",score ];
        _owner.pointLabel.text = str;
    }
    
    [cell addSubview: _owner.pointView];
    [self addSepatorLine:cell frame:frame];
}

//第三行我喜欢的
-(void)setRow2:(SKSTableViewCell*)cell {
    CGRect frame = [self getRectOfCellSection:0 row:1];
    _owner.loveView.frame = CGRectMake(0, 15, frame.size.width,60 );
    _owner.loveView.backgroundColor = [UIColor clearColor];
    [cell addSubview: _owner.loveView];
    [self addSepatorLine:cell frame:frame];
}

//第四行我的分享
-(void)setRow3:(SKSTableViewCell*)cell {
    CGRect frame = [self getRectOfCellSection:0 row:1];
    _owner.shareView.frame = CGRectMake(0, 15, frame.size.width,60 );
    _owner.shareView.backgroundColor = [UIColor clearColor];
    [cell addSubview: _owner.shareView];
    [self addSepatorLine:cell frame:frame];
}

//第五行浏览路线
-(void)setRow4:(SKSTableViewCell*)cell {
    CGRect frame = [self getRectOfCellSection:0 row:1];
    _owner.feiChuanDetailCellView.frame = CGRectMake(0, 15, frame.size.width,60 );
    _owner.feiChuanDetailCellView.backgroundColor = [UIColor clearColor];
    [cell addSubview: _owner.feiChuanDetailCellView];
    [self addSepatorLine:cell frame:frame];
}

//第六行消息提醒
-(void)setRow5:(SKSTableViewCell*)cell {
    CGRect frame = [self getRectOfCellSection:0 row:1];
    _owner.msgView.frame = CGRectMake(0, 15, frame.size.width,60 );
    _owner.msgView.backgroundColor = [UIColor clearColor];
    [cell addSubview: _owner.msgView];
    [self addSepatorLine:cell frame:frame];
}

//第六行意见反馈
-(void)setRow6:(SKSTableViewCell*)cell {
    CGRect frame = [self getRectOfCellSection:0 row:1];
    _owner.suggestView.frame = CGRectMake(0, 15, frame.size.width,60 );
    _owner.suggestView.backgroundColor = [UIColor clearColor];
    [cell addSubview: _owner.suggestView];
    [self addSepatorLine:cell frame:frame];
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
    sepatorLine.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:sepatorLine];
}

#pragma mark - 三个按钮的响应事件

-(void) commentBtn {
    NSLog(@"comment Btn Click");
}

-(void) likeBtn {
    NSLog(@"like Btn Click");
}

-(void) settingBtn {
    NSLog(@"setting Btn Click");
}


#pragma mark - 登录注销按钮的相应事件

//
- (IBAction)logoutClick:(id)sender {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定注销吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注销", nil];
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {//用户点击了确认注销
        NSLog(@"logout click after alert");
        [QyUtils delDefaultValue:KJG_USER];
        [QyUtils delDefaultValue:ALL_USER_KJG];
        [self reloadData];
    }
}
//登录按钮
- (IBAction)loginClick:(id)sender {
    LoginVC *vc = (LoginVC *)[StoryboardHelper getVCByVCName:@"loginVC"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 展示前显示数据
-(void)viewWillAppear:(BOOL)animated{
    [self reloadData];
}

-(void) reloadData {
    NSString *user = [QyUtils getDefaultValue:KJG_USER];
    if (user != nil) {//如果用户已经登录
        //update data and table data;
        //隐藏登录按钮
        _loginButton.hidden = YES;
        _logoutBtn.hidden = NO;
        
        NSString *str = [QyUtils getDefaultValue:KJG_USER];
        User *user = (User *)[QyUtils getDefaultValue:ALL_USER_KJG];//用户的所有信息缓存了
        _userNameLabel.text = str;
        [_tableView reloadData];
    }
    else{
        //如果用户没有登录，暂时什么都不做
        _loginButton.hidden = NO;
        _logoutBtn.hidden = YES;
        _userNameLabel.text = @"用户未登录";
        [_tableView reloadData];
        
    }

}








@end
