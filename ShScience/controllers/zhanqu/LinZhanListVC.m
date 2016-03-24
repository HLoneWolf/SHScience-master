//
//  LinZhanListVC.m
//  ShScience
//
//  Created by qiya on 16/3/20第13周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "LinZhanListVC.h"
#import "QyUtils.h"

@interface LinZhanListVC ()

@end

@implementation LinZhanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitleNoHidden:@"临展"];

    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, ScreenWitdh, ScreenHeight)];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_listTable];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;
    if (cell1 == nil){
        
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:@"LinZhanListTableCell"];
    }
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LinZhanListTableCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell1 = [nib objectAtIndex:0];
    
    [cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"learnVC didSelectRowAtIndexPath=%li",(long)indexPath.row);
//    AnswerVC *vc = (AnswerVC *)[StoryboardHelper getVCByVCName:@"answerVC"];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
