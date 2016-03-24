//
//  ZhanXiangHudongVC.m
//  ShScience
//
//  Created by qiya on 16/3/17第12周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ZhanXiangHudongVC.h"
#import "QyUtils.h"

@interface ZhanXiangHudongVC ()

@end

@implementation ZhanXiangHudongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitle:@"展项互动"];
    [self setupHudongTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 表格的delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _hudongListTable){
        return 4;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;
    if(tableView == _hudongListTable){
        cell1 = [self buildZhanXiangHuDongCell:tableView cellForRowAtIndexPath:indexPath];//setup 兴趣小组的单元格
    }
    
    //[cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _hudongListTable){
        return 150;
    }
    return 215;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView click %li",(long)indexPath.row);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 绘制单元格
- (UITableViewCell *)buildZhanXiangHuDongCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell1;
    if (cell1 == nil){
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWitdh, 215)
                                       reuseIdentifier:@"XinquListTableCell"];
    }
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ZhanXiangHuDongTableCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell1 = [nib objectAtIndex:0];
    
    return cell1;
}

#pragma mark - 建立互动表格
-(void) setupHudongTable{
    _hudongListTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, ScreenWitdh-20, ScreenHeight)];
    //_hudongListTable=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _hudongListTable.dataSource = self;
    _hudongListTable.delegate = self;
    _hudongListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_hudongListTable setBackgroundColor:[UIColor clearColor]];
    _hudongListTable.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //[_hudongListTable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:_hudongListTable];
}

@end
