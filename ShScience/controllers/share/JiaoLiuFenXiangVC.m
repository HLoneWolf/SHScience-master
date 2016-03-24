//
//  JiaoLiuFenXiangVC.m
//  ShScience
//
//  Created by qiya on 16/3/16第12周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "JiaoLiuFenXiangVC.h"
#import "RFSegmentView.h"
#import "QyUtils.h"
#import "PureLayout.h"


@interface JiaoLiuFenXiangVC ()

@end

@implementation JiaoLiuFenXiangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitle:@"分享交流"];
    [self setupThreeTopTab];
    self.view.autoresizesSubviews = NO;
    
    [self setupXinquXiaoZu];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidAppear:(BOOL)animated {
//    [self.view layoutIfNeeded];
//    [_xinquTableView layoutIfNeeded];
//}
//
//-(void) viewDidLayoutSubviews {
//    [self.view layoutIfNeeded];
//    [_xinquTableView layoutIfNeeded];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 表格的delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _xinquTableView){
        return 4;
    }
    if(tableView == _zhuanJiaTableView){
        return 4;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;
    if(tableView == _xinquTableView){
        cell1 = [self buildXinquXiaoZuCell:tableView cellForRowAtIndexPath:indexPath];//setup 兴趣小组的单元格
    }
    if(tableView == _zhuanJiaTableView){
        cell1 = [self buildZhuanJiaCell:tableView cellForRowAtIndexPath:indexPath];
    }
    
    //[cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _xinquTableView){
        return 215;
    }
    else if(tableView == _zhuanJiaTableView){
        return 160;
    }
    return 215;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView click %li",(long)indexPath.row);
}

#pragma mark - 三个单元格绘制
- (UITableViewCell *)buildXinquXiaoZuCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell1;
    if (cell1 == nil){
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWitdh, 215)
                                       reuseIdentifier:@"XinquListTableCell"];
    }
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"XinQuTableCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell1 = [nib objectAtIndex:0];

    return cell1;
}

- (UITableViewCell *)buildZhuanJiaCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell1;
    if (cell1 == nil){
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWitdh, 215)
                                       reuseIdentifier:@"ZhuanJiaListTableCell"];
    }
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ZhuanJiaTableCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell1 = [nib objectAtIndex:0];
    
    return cell1;
}

#pragma mark - 三个表格的创建
-(void) setupXinquXiaoZu {
    _xinquTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 120, ScreenWitdh-20, ScreenHeight)];
    //_xinquTableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _xinquTableView.dataSource = self;
    _xinquTableView.delegate = self;
    _xinquTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_xinquTableView setBackgroundColor:[UIColor clearColor]];
    _xinquTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    //[_xinquTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:_xinquTableView];
}

-(void) setupZhuaJia {
    _zhuanJiaTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 120, ScreenWitdh-20, ScreenHeight)];
    //_zhuanJiaTableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _zhuanJiaTableView.dataSource = self;
    _zhuanJiaTableView.delegate = self;
    _zhuanJiaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_zhuanJiaTableView setBackgroundColor:[UIColor clearColor]];
    _zhuanJiaTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //[_zhuanJiaTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:_zhuanJiaTableView];
}


#pragma mark - 中间三段内容

-(void) setupThreeTopTab {
    CGRect aRect = CGRectMake(-12, 20+40, ScreenWitdh+24, 60);
    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:aRect items:@[@"兴趣小组",@"专家解说",@"互动论坛"]];
    //segmentView.backgroundColor = [UIColor redColor];
    segmentView.tintColor       = [UIColor clearColor];
    segmentView.itemHeight      = 44.0f;
    segmentView.leftRightMargin = 0.f;
    segmentView.segementItemNorColor = RGB(39, 127, 195);
    segmentView.segementItemSelColor = [UIColor whiteColor];
    
    segmentView.handlder        = ^ (RFSegmentView * __nullable view, NSInteger selectedIndex) {
        // doSomething
        NSLog(@"segment selected index is:%lu",(unsigned long)selectedIndex);
        if(selectedIndex==0){//兴趣小组
            [self removeOtherView];
            [self setupXinquXiaoZu];
            
        }
        else if(selectedIndex==1){//专家解说
            [self removeOtherView];
            [self setupZhuaJia];
            
        }
        else if(selectedIndex == 2){//互动论坛
            [self removeOtherView];
            [self setupZhuaJia];
        }
    };
    
    segmentView.selectedIndex = 0;
    [self.view addSubview:segmentView];
}

-(void)removeOtherView{
    for (UIView *view in self.view.subviews) {
        if (![view isKindOfClass:[RFSegmentView class]]) {
            [view removeFromSuperview];
        }
    }
}
@end
