//
//  RadioListVC.m
//  ShScience
//
//  Created by qiya on 16/3/8第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "RadioListVC.h"
#import "QyUtils.h"
#import "RadioDetailVC.h"
#import "StoryboardHelper.h"
#import "QyDataManger.h"
#import "RadioItem.h"
#import "STKAudioPlayer.h"

@interface RadioListVC ()

@end

@implementation RadioListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitleNoHidden:_typeName];
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, ScreenWitdh-20, ScreenHeight)];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTable setBackgroundColor:[UIColor clearColor]];
    //[_grayView addSubview:_listTable];
    [self.view addSubview:_listTable];
    [self requestRadioList];
    
    _playButtonList = [NSMutableArray array];//初始化
    _currentIdex = -100;
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
    if(_radioList!=nil&&[_radioList count]>0){
        return [_radioList count];
    }
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;
    if (cell1 == nil){
        
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:@"radioListTableCell"];
    }
    
    RadioItem *radio = nil;
    if(_radioList!=nil&&[_radioList count]>0){
        radio = _radioList[indexPath.row];
    }
    
    CGFloat cellWidth = _listTable.frame.size.width;
    CGFloat cellHeight = 80;
    UIImageView *verImgView = [[UIImageView alloc]initWithFrame:CGRectMake(cellWidth-50, 10, 40, 40)];
    
    verImgView.image = [UIImage imageNamed:@"radio_play"];
    if(indexPath.row==_currentIdex){
        verImgView.image = [UIImage imageNamed:@"radio_stop"];
    }
    [cell1 addSubview:verImgView];
    [_playButtonList addObject:verImgView];
    
    UILabel *labe1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 30, 40)];
    labe1.font = [UIFont systemFontOfSize:20];
    labe1.textColor = RGB(39, 127, 195);
    NSString *str = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    labe1.text = str;
    [cell1 addSubview:labe1];
    
    
    UILabel *labe2 = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, cellWidth-100, 40)];
    labe2.font = [UIFont systemFontOfSize:18];
    labe2.textColor = RGB(39, 127, 195);
    labe2.text = @"生物万象展区简介";
    if(radio){
        labe2.text = radio.name;
    }
    [cell1 addSubview:labe2];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, cellHeight-1, cellWidth, 1)];
    [line setBackgroundColor:RGB(222, 222, 222)];
    [cell1 addSubview:line];
    
    
    //[cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0; // you can have your own choice, of course
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = RGB(222, 222, 222);
//    return headerView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",@"http://www.snhm.org.cn/museum/",((RadioItem *)[_radioList objectAtIndex:indexPath.row]).audio];

    NSURL *url=[NSURL URLWithString:urlstr];
    
    if(_currentIdex==indexPath.row){
        if(_audioPlayer){
            [_audioPlayer stop];
        }
        _currentIdex = -100;
        [_listTable reloadData];
        return;
    }
    
    _currentIdex = indexPath.row;
    
    if(_audioPlayer){
        [_audioPlayer stop];
    }
     _audioPlayer = [[STKAudioPlayer alloc]init];
    [_audioPlayer play:urlstr];

    //    RadioDetailVC *vc = (RadioDetailVC *)[StoryboardHelper getVCByVCName:@"radioDetailVC"];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    [_listTable reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    if(_audioPlayer){
        [_audioPlayer stop];
    }
}

#pragma mark -  网络数据请求
-(void) requestRadioList {
    DataRequest * r = [QyDataManger getAllRadio:@"" callback:^(NSArray *items, BOOL success) {
        //
        _radioList = [NSMutableArray array];
        for(RadioItem *radio in items){
            if([_typeName isEqualToString:radio.eRoomName]){
                [_radioList addObject:radio];
            }
        }
        [_listTable reloadData];
    }];
    [r startAsynchronous];
}

@end
