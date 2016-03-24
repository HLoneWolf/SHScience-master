//
//  LearnVC.m
//  ShScience
//
//  Created by qiya on 16/2/4第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "LearnVC.h"
#import "QyUtils.h"
#import "UINavigationBar+Awesome.h"
#import "HelpVC.h"
#import "AnswerVC.h"
#import "StoryboardHelper.h"
#import "DataManager.h"
#import "User.h"
#import "LearnBookItem.h"
#import "RFSegmentView.h"

@interface LearnVC ()

@end

@implementation LearnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitle:@"学习单"];
    [self setupHeadNav];
    [self setupLearnListTable];
}

//
-(void)setupHeadNav {
    CGRect aRect = CGRectMake(-12, 45, ScreenWitdh+24, 35);
    
    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:aRect items:@[@"全部",@"已完成",@"未完成",@"全部"]];
    //segmentView.backgroundColor = [UIColor redColor];
    segmentView.tintColor       = [UIColor clearColor];
    segmentView.itemHeight      = 35.0f;
    segmentView.leftRightMargin = 0.f;
    segmentView.segementItemNorColor = RGB(39, 127, 195);
    segmentView.segementItemSelColor = [UIColor whiteColor];
    
    segmentView.handlder        = ^ (RFSegmentView * __nullable view, NSInteger selectedIndex) {
        // doSomething
        if(selectedIndex==0){//全部
            [self removeOtherView];
            [self setupLearnListTable];
        }
        else if(selectedIndex==1){//已完成
            [self removeOtherView];
        }
        else if(selectedIndex == 2){//未完成
            [self removeOtherView];
            [self setupLearnListTable];
            
        }
        else if(selectedIndex == 3){//排名
            [self removeOtherView];
            [self setupRankListTable];
        }
    };
    
    segmentView.selectedIndex = 0;
    [self.view addSubview:segmentView];
}

-(void)setupLearnListTable {
    _learnListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, ScreenWitdh, ScreenHeight)];
    _learnListTable.dataSource = self;
    _learnListTable.delegate = self;
    _learnListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_learnListTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_learnListTable];
    
    [self requestLearnList];
}

-(void)setupRankListTable {
    _rankListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, ScreenWitdh, ScreenHeight)];
    _rankListTable.dataSource = self;
    _rankListTable.delegate = self;
    _rankListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_rankListTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_rankListTable];
}

-(void)removeOtherView{
    for (UIView *view in self.view.subviews) {
        if (![view isKindOfClass:[RFSegmentView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 表格相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _learnListTable){
        if(_learnItemList){
            return [_learnItemList count];
        }
        return 9;
    }
    else if(tableView == _rankListTable){
        return 10;
    }
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if(tableView==_learnListTable){
        return [self buildLearnListCell:tableView cellForRowAtIndexPath:indexPath];
    }
    
    else if(tableView == _rankListTable){
        return [self buildRankListCell:tableView cellForRowAtIndexPath:indexPath];
    }
        
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_learnListTable == tableView){
        return 100;
    }
    else if(tableView = _rankListTable){
        return 100;
    }
    
    return 100;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"learnVC didSelectRowAtIndexPath=%li",(long)indexPath.row);
    
    if(tableView == _learnListTable){
        AnswerVC *vc = (AnswerVC *)[StoryboardHelper getVCByVCName:@"answerVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if(tableView == _rankListTable){
        //
    }
    
}

#pragma mark -Cell 绘制

-(UITableViewCell *) buildLearnListCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;
    if (cell1 == nil){
        
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:@"radioTableCell"];
    }
    
    LearnBookItem *learnItem = nil;
    NSLog(@"table indexPath.row =%i",indexPath.row);
    if(_learnItemList!=nil && [_learnItemList count]>0){
        learnItem = _learnItemList[indexPath.row];
    }
    
    
    UIImageView *verImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWitdh/2-12, 0, 20, 100)];
    verImgView.image = [UIImage imageNamed:@"learn_center"];
    [cell1 addSubview:verImgView];
    if(indexPath.row%2==0){
        UIImageView *left1Image = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, ScreenWitdh/2-20, 50)];
        left1Image.image = [UIImage imageNamed:@"learn_left1"];
        [cell1 addSubview:left1Image];
        UILabel *label3 =
        [[UILabel alloc] initWithFrame:CGRectMake(60, 70, 80, 20)];
        label3.textColor = [UIColor whiteColor];
        label3.text = @"信息时代";
        if(learnItem){
            label3.text = learnItem.name;
        }
        label3.font = [UIFont systemFontOfSize:18.0f];
        [cell1 addSubview:label3];
    }
    if(indexPath.row%2==1){
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWitdh/2-16, 10, ScreenWitdh/2-20, 50)];
        rightImage.image = [UIImage imageNamed:@"learn_right1"];
        [cell1 addSubview:rightImage];
        UILabel *label3 =
        [[UILabel alloc] initWithFrame:CGRectMake(ScreenWitdh/2+50, 70, 80, 20)];
        label3.textColor = [UIColor whiteColor];
        label3.text = @"信息时代";
        if(learnItem){
            label3.text = learnItem.name;
        }
        label3.font = [UIFont systemFontOfSize:18.0f];
        [cell1 addSubview:label3];
    }
    [cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
}


- (UITableViewCell *)buildRankListCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell1;
    if (cell1 == nil){
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWitdh, 100)
                                       reuseIdentifier:@"LearnRankTableCell"];
    }
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LearnRankTableCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell1 = [nib objectAtIndex:0];
    
    return cell1;
}

#pragma mark - 网络请求
-(void)requestLearnList {

    User *user = [DataManager getUser];
    if(user!=nil){
        DataRequest *request = [DataManager loadLearnBookItemsWithUser:user callback:^(NSArray *learnBookItems, BOOL success) {
            //
            _learnItemList = learnBookItems;
            NSLog(@"leanrBookItems %@",learnBookItems);
            [_learnListTable reloadData];
        }];
        
        [request startAsynchronous];
    }
    else {
        //登录页面
    }
}
@end
