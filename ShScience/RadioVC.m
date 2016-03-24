//
//  RadioVC.m
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "RadioVC.h"
#import "QyUtils.h"
#import "RadioListVC.h"
#import "StoryboardHelper.h"

@implementation RadioVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavBtnWithTitle:@"语音导览"];
    //self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ScreenWitdh, ScreenHeight)];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_listTable];
    
    _loucengName = [NSArray arrayWithObjects:@"radio_floor_4",@"radio_floor_3",@"radio_floor_2",@"radio_floor_1", nil];
    
    _lou4 = [NSArray arrayWithObjects:@"zhanqu_4_1",@"zhanqu_4_2",@"zhanqu_4_3",@"zhanqu_4_4",nil];
    _lou3 = [NSArray arrayWithObjects:@"zhanqu_3_1",@"zhanqu_3_2",@"zhanqu_3_3",nil];
    _lou2 = [NSArray arrayWithObjects:@"zhanqu_2_1",@"zhanqu_2_2", nil];
    _lou1 = [NSArray arrayWithObjects:@"zhanqu_1_1", nil];
    
    _typeNameList = [NSArray arrayWithObjects:@"起源之谜",@"生态万象",@"演化之道",@"上海故事",@"生存智慧",
                     @"缤纷生命",@"人地之缘",@"大地探珍",@"探索中心",@"起源之谜",nil];
    
    _allLou = [NSMutableArray array];
    [_allLou addObject:_lou4];
    [_allLou addObject:_lou3];
    [_allLou addObject:_lou2];
    [_allLou addObject:_lou1];
    _count = 1000;
}

#pragma mark - 表格相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
//    return 4;
    return [_allLou count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell1;
    
    if (cell1 == nil)
        
    {
        
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:@"learnTableCell"];
        
    }
    

        UIImageView *floorImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 53, 36)];
        floorImage.image = [UIImage imageNamed:[_loucengName objectAtIndex:indexPath.section]];
        [cell1 addSubview:floorImage];
        
        for(int i=0;i<[[_allLou objectAtIndex:indexPath.section] count];i++){
            
            CGFloat diffWidth = 100*(i%3);
            CGFloat diffHeight = 120*(i/3);
            //放置两个圆形的按钮
            UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(80+diffWidth, 20 +diffHeight, 85, 108)];
            [btn1 setBackgroundImage:[UIImage imageNamed:[[_allLou objectAtIndex:indexPath.section] objectAtIndex:i]] forState:UIControlStateNormal];
            [btn1 addTarget:nil action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn1.tag = _count;
            _count++;
            
            [cell1 addSubview:btn1];
            
        }
    //[cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int count = [[_allLou objectAtIndex:indexPath.section] count];
    int n = count/4;
    return 150+ 130 *n;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section!=0){
    return 20.; // you can have your own choice, of course
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section!=0){
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = RGB(222, 222, 222);
        return headerView;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"radioVC didSelectRowAtIndexPath=%li",(long)indexPath.row);
}


#pragma mark - 展区的按钮

-(void) oneBtnClick:(UIButton *) sender{
    NSLog(@"Button Click...");
            RadioListVC *vc = (RadioListVC *)[StoryboardHelper getVCByVCName:@"radioListVC"];
    vc.typeName = _typeNameList[sender.tag-1000];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];

}

@end
