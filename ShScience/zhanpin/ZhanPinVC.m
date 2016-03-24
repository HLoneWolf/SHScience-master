//
//  ZhanPinVC.m
//  ShScience
//
//  Created by qiya on 16/1/30第5周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ZhanPinVC.h"
#import "UINavigationBar+Awesome.h"
#import "QyUtils.h"
#import "PlayerVC.h"
#import "StoryboardHelper.h"
#import "RKTabView.h"
#import "DataManager.h"
#import "RoomDetailItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LinZhanListVC.h"
#import "QyDataManger.h"
#import "NewFilmDetail.h"
#import "TemporaryDisplay.h"
#import "MyZhanPinDetail.h"

@interface ZhanPinVC ()

@end



@implementation ZhanPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWitdh, self.view.frame.size.height)];
//    [self.view addSubview:_contentView];
    
    self.navigationController.navigationBarHidden = NO;//打开顶部Tab
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//导航字体颜色
    
    UIImage* image3 = [UIImage imageNamed:@"map_louceng_btn"];
    CGRect frameimg = CGRectMake(ScreenWitdh-15,5, 25,25);
    
    UIButton *loucengButton = [[UIButton alloc] initWithFrame:frameimg];
    [loucengButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [loucengButton addTarget:self action:@selector(Back_btn:)
            forControlEvents:UIControlEventTouchUpInside];
    [loucengButton setShowsTouchWhenHighlighted:YES];
    
    
    UIImage* image4 = [UIImage imageNamed:@"map_louceng_back"];
    CGRect frameimg2 = CGRectMake(15,5, 25,25);
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg2];
    [backButton setBackgroundImage:image4 forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(Back_btn:)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setShowsTouchWhenHighlighted:YES];
    
    //左右两个按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:loucengButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *backBtttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBtttonItem;
    
    //设置标题及颜色
    self.navigationItem.title=@"展品";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    [self.view bringSubviewToFront:_playBtn];
    [self.view bringSubviewToFront:_favBtn];
    [self.view bringSubviewToFront:_commentBtn];
    [self.view bringSubviewToFront:_shareBtn];
    
    UIImage *videoBtn = [UIImage imageNamed:@"zp_item_video"];
    UIImage *videoBtnSel = [UIImage imageNamed:@"zp_item_video_sel"];
    UIImage *locBtn = [UIImage imageNamed:@"zp_item_loc"];
    UIImage *locaBtnSel = [UIImage imageNamed:@"zp_item_loc_sel"];
    UIImage *yongjiBtn = [UIImage imageNamed:@"yongji_btn"];
    UIImage *yongjiBtnSel = [UIImage imageNamed:@"yongji_btn_sel"];
    
    RKTabItem *tabItem1 = [RKTabItem createUsualItemWithImageEnabled:videoBtnSel imageDisabled:videoBtn];
    RKTabItem *tabItem2 = [RKTabItem createUsualItemWithImageEnabled:locaBtnSel imageDisabled:locBtn];
    RKTabItem *tabItem3 = [RKTabItem createUsualItemWithImageEnabled:yongjiBtnSel imageDisabled:yongjiBtn];

    
    RKTabView *tabView = [[RKTabView alloc] initWithFrame:CGRectMake(0, ScreenHeight-35, ScreenWitdh, 55)];
    tabView.tabItems = @[tabItem1, tabItem2,tabItem3];
    tabView.backgroundColor = RGB(23, 45, 89);//背景颜色
    tabView.delegate = self;
    
    [self.view addSubview:tabView];
    [tabView switchTabIndex:0];
    
    _summaryLabel.hidden = YES;
    
    
    _detailDes = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _detailDes.font = [UIFont systemFontOfSize:17];
    _detailDes.lineBreakMode = NSLineBreakByWordWrapping;
    _detailDes.numberOfLines = 0;
    
    NSString *text = @"  广袤的宇宙，繁星闪烁，充满了神秘感，它吸引着我们不断地去探索，宇航是人类永恒的话题。宇航的实现可以说是20世纪科技最伟大的创举。   然而宇航的梦想是怎样实现的呢？为了宇航的实现人类积累了多少科学的  广袤的宇宙，繁星闪烁，充满了神秘感，它吸引着我们不断地去探索，宇航是人类永恒的话题。宇航的实现可以说是20世纪科技最伟大的创举。   然而宇航的梦想是怎样实现的呢？为了宇航的实现人类积累了多少科学的";
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:text
                                                                    attributes:@{
                                                                                 (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                 }];
    _detailDes.text = attString;
    CGSize s =[TTTAttributedLabel sizeThatFitsAttributedString:attString withConstraints:CGSizeMake(ScreenWitdh-30, 1000) limitedToNumberOfLines:0];
    
    _detailDes.frame = CGRectMake(5, 30, s.width, s.height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, ScreenHeight-140, ScreenWitdh-30, 100)];
    //[scrollView setBackgroundColor:[UIColor yellowColor]];
    scrollView.contentSize = _detailDes.frame.size;
    [self.view addSubview:scrollView];
    [scrollView addSubview:_detailDes];

    //临展
    if([_type isEqualToString:@"linzhan"]){
        _nameLabel.text = _lizhanItem.name;
        NSString *filterStr = [QyUtils flattenHTML:_lizhanItem.introduction];
        if(filterStr==nil){
            filterStr=@"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        _secondLabel.text = _lizhanItem.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,_lizhanItem.icon];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    //教育活动
    if([_type isEqualToString:@"huodong"]){
        _nameLabel.text = _huodongItem.name;
        NSString *filterStr = [QyUtils flattenHTML:_huodongItem.contents];
        if(filterStr==nil){
            filterStr=@"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        _secondLabel.text = _huodongItem.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,_huodongItem.titlePic];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    
    //四维
    if([_type isEqualToString:@"siwei"]){
        _nameLabel.text = _siweiItem.name;
        NSString *filterStr = [QyUtils flattenHTML:_siweiItem.name];
        if(filterStr==nil){
            filterStr=@"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        _secondLabel.text = _siweiItem.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,nil];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    
    //左边的详情点击
    if([_type isEqualToString:@"left"]){
        
        if([_selectItem.type isEqualToString:@"0"]){//展区
            self.navigationItem.title=@"展区";
            [self startRequest];
        }
        if([_selectItem.type isEqualToString:@"1"]){//电影
            self.navigationItem.title=@"电影";
            [self startRequestFilm];
        }
        if([_selectItem.type isEqualToString:@"2"]){//活动
            self.navigationItem.title=@"活动";
            [self startRequestHuodong];
        }
        if([_selectItem.type isEqualToString:@"3"]){//展品
            self.navigationItem.title=@"展品";
        }
        if([_selectItem.type isEqualToString:@"4"]){//临展
            self.navigationItem.title=@"临展";
            [self startRequestTemp];
        }
    }
}


#pragma mark --网络请求
-(void) startRequest{//展区
    //加载数据
    DataRequest *request = [DataManager getZhanquRoomDetailWithId:_selectItem.entityId callback:^(RoomDetailItem *items, BOOL success) {
        NSLog(@"getZhanquRoomDetailWithId result %@=",items);
        _roomDetailItem = items;
        _nameLabel.text = items.name;
//        _summaryLabel.text = items.summary;
        NSString *filterStr = [QyUtils flattenHTML:_roomDetailItem.summary];
        if(filterStr==nil){
            filterStr = @"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;

        _secondLabel.text = items.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,items.titlePic];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }];
    
    [request startAsynchronous];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //导航栏设置为透明色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if([@"Y" isEqualToString:_needHiddenNavBar]){
            self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
            [self.navigationController.navigationBar lt_reset];
    }

}

#pragma mark - 按钮和appear相关
- (void)Back_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)playBtnClick:(id)sender {
    NSLog(@"pay Btn Click");
    PlayerVC *mapVc = (PlayerVC*)[StoryboardHelper getVCByVCName:@"playerVC"];
    if(_roomDetailItem != nil){
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,_roomDetailItem.video];
        mapVc.videoUrlStr = url;
    }

    mapVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapVc animated:YES];
    
}
- (IBAction)FavBtnClick:(id)sender {
    NSLog(@"fav Btn Click");
}
- (IBAction)shareBtnClick:(id)sender {
    NSLog(@"share Btn Click");
}
- (IBAction)commentBtnClick:(id)sender {
    NSLog(@"comment Btn Click");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - RKTabItemDelegate的相关方法
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    NSLog(@"enable click index is=%i",index);
    NSLog(@"enable click tabItem is=%@",tabItem);
    
    LinZhanListVC *vc = (LinZhanListVC *)[StoryboardHelper getVCByVCName:@"linZhanListVC"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    NSLog(@"disable click index is=%i",index);
    NSLog(@"disable click tabItem is=%@",tabItem);
}


#pragma mark - 其他类型的网络请求
//电影类型
-(void) startRequestFilm{
    //加载数据
    DataRequest *request = [QyDataManger getFilm4DById:_selectItem.entityId callback:^(NewFilmDetail *items, BOOL success) {
        NSLog(@"getZhanquRoomDetailWithId result %@=",items);
        //_roomDetailItem = items;
        _nameLabel.text = items.name;
        //        _summaryLabel.text = items.summary;
        NSString *filterStr = [QyUtils flattenHTML:items.introduction];
        if(filterStr==nil){
            filterStr = @"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        
        _secondLabel.text = items.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,items.image];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }];
    
    [request startAsynchronous];
}

-(void) startRequestTemp{//////临展
    //加载数据
    DataRequest *request = [QyDataManger getLinZhanInfoWithStartdate:_selectItem.entityId callback:^(TemporaryDisplay *td, BOOL success) {
        
        TemporaryDisplayData *items = nil;
        NSLog(@"getZhanquRoomDetailWithId result %@=",items);
        NSArray *list = td.dataList;
        for (TemporaryDisplayData *obj in list) {
            if(obj.dataId == _selectItem.entityId){
                items = obj;
            }
        }

        _nameLabel.text = items.name;
        //        _summaryLabel.text = items.summary;
        NSString *filterStr = [QyUtils flattenHTML:items.introduction];
        if(filterStr==nil){
            filterStr = @"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        _secondLabel.text = items.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,items.icon];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }];
    
    [request startAsynchronous];
}


-(void) startRequestHuodong{//活动
    //加载数据
    DataRequest *request = [QyDataManger getShiyanInfoWithStartdate:_selectItem.entityId callback:^(ShiyanItem *items, BOOL success) {
        NSLog(@"getZhanquRoomDetailWithId result %@=",items);

        _nameLabel.text = items.title;
        //        _summaryLabel.text = items.summary;
        NSString *filterStr = [QyUtils flattenHTML:items.introduction];
        if(filterStr==nil){
            filterStr = @"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        
        _secondLabel.text = items.title;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,items.pics[0]];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }];
    
    [request startAsynchronous];
    
}

-(void) startRequestZhanPin{//展品
    //加载数据
    DataRequest *request = [QyDataManger getZhanpinDetailById:_selectItem.entityId callback:^(MyZhanPinDetail *items, BOOL success) {
        NSLog(@"getZhanquRoomDetailWithId result %@=",items);
        
        _nameLabel.text = items.name;
        //        _summaryLabel.text = items.summary;
        NSString *filterStr = [QyUtils flattenHTML:items.summary];
        if(filterStr==nil){
            filterStr = @"";
        }
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:filterStr
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        
        _secondLabel.text = items.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,items.icon];
        [_zhanPinImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }];
    
    [request startAsynchronous];
}



@end
