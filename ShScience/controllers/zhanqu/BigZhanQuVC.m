//
//  BigZhanQuVC.m
//  ShScience
//
//  Created by qiya on 16/3/7第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "BigZhanQuVC.h"
#import "QyUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataManager.h"
#import "ZhanQuListVC.h"
#import "StoryboardHelper.h"

@interface BigZhanQuVC ()

@end

@implementation BigZhanQuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitle:@"展区"];
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ScreenWitdh, ScreenHeight)];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_listTable];

    //加载网络数据
    [self readFromNet];
}
//
-(void)readFromNet{
    DataRequest *request = [DataManager getZhanquRoomList:@"" callback:^(NSArray *items, BOOL success) {
        //
        NSLog(@"log log %lu",(unsigned long)[items count]);
        _roomArray = items;
        [_listTable reloadData];
    }];

    [request startAsynchronous];

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
    if(_roomArray){
        return [_roomArray count];
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell1;
    
    if (cell1 == nil)
        
    {
        
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:@"bigZhanQuTableCell"];
        
    }
    
    
    UIImageView *verImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWitdh-5, 170)];
    if(_roomArray){
        NSArray *pics = ((RoomDetailItem *)_roomArray[indexPath.row]).pics;
        NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,(NSString *)pics[0]];//1==>0
        [verImgView sd_setImageWithURL:[NSURL URLWithString:url]];
    
        [cell1 addSubview:verImgView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, ScreenWitdh-50, 25)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text= ((RoomDetailItem *)_roomArray[indexPath.row]).name;
        [cell1 addSubview:label];

    }
    else {
        verImgView.image = [UIImage imageNamed:@"big_zhanqu_example"];
        [cell1 addSubview:verImgView];
    }
    
    
    
    [cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"learnVC didSelectRowAtIndexPath=%li",(long)indexPath.row);
    
    ZhanQuListVC *viewController = (ZhanQuListVC *)[StoryboardHelper getVCByVCName:@"zhanQuListVC"];
    viewController.roomItem = _roomArray[indexPath.row];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];

}

@end
