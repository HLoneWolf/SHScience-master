//
//  FilmDetailVC.m
//  ShScience
//
//  Created by qiya on 16/3/22第13周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "FilmDetailVC.h"
#import "LXDataManager.h"
#import "DataManager.h"
#import "RoomDetailItem.h"
#import "QyUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "QyDataManger.h"
#import "PlayerVC.h"
#import "StoryboardHelper.h"
#import "KLCPopup.h"
#import "LinZhanListVC.h"

@interface FilmDetailVC ()

@end

@implementation FilmDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBtnWithTitle:@"电影"];
    [self setupDetailLabel];
    [self setupBelowNav];
    [self startRequestFilm];
    // Do any additional setup after loading the view.
}

#pragma mark - RKTabItemDelegate的相关方法
-(void) setupBelowNav {
    UIImage *videoBtn = [UIImage imageNamed:@"film_video"];
    UIImage *videoBtnSel = [UIImage imageNamed:@"film_video_sel"];
    UIImage *locBtn = [UIImage imageNamed:@"film_loc"];
    UIImage *locaBtnSel = [UIImage imageNamed:@"film_loc_sel"];
    UIImage *yongjiBtn = [UIImage imageNamed:@"film_yuyue"];
    UIImage *yongjiBtnSel = [UIImage imageNamed:@"film_yuyue_sel"];
    
    UIImage *moreBtn = [UIImage imageNamed:@"film_more"];
    UIImage *moreBtnSel = [UIImage imageNamed:@"film_more_sel"];
    
    RKTabItem *tabItem1 = [RKTabItem createUsualItemWithImageEnabled:videoBtnSel imageDisabled:videoBtn];
    RKTabItem *tabItem2 = [RKTabItem createUsualItemWithImageEnabled:locaBtnSel imageDisabled:locBtn];
    RKTabItem *tabItem3 = [RKTabItem createUsualItemWithImageEnabled:yongjiBtnSel imageDisabled:yongjiBtn];
    RKTabItem *tabItem4 = [RKTabItem createUsualItemWithImageEnabled:moreBtnSel imageDisabled:moreBtn];
    
    
    RKTabView *tabView = [[RKTabView alloc] initWithFrame:CGRectMake(0, ScreenHeight-35, ScreenWitdh, 55)];
    tabView.tabItems = @[tabItem1, tabItem2,tabItem3,tabItem4];
    tabView.backgroundColor = RGB(23, 45, 89);//背景颜色
    tabView.delegate = self;
    
    [self.view addSubview:tabView];
//    [tabView switchTabIndex:0];
    
}

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    NSLog(@"enable click index is=%i",index);
    NSLog(@"enable click tabItem is=%@",tabItem);
    
    if(index==3){//更多
        //临展
        LinZhanListVC *vc = (LinZhanListVC *)[StoryboardHelper getVCByVCName:@"linZhanListVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(index==2){//预约
        //临展

    }
    if(index == 1){//定位

    }
    
    if(index == 0){//视频
        PlayerVC *mapVc = (PlayerVC*)[StoryboardHelper getVCByVCName:@"playerVC"];
        if(_itemData != nil){
            NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,_itemData.video];
            mapVc.videoUrlStr = url;
            mapVc.titleName = _itemData.name;
        }
        [self.navigationController pushViewController:mapVc animated:YES];
    }
    //    LinZhanListVC *vc = (LinZhanListVC *)[StoryboardHelper getVCByVCName:@"linZhanListVC"];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    NSLog(@"disable click index is=%i",index);
    NSLog(@"disable click tabItem is=%@",tabItem);
}

-(void) setupDetailLabel{
    _detailLabel.hidden = YES;
    
    
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

    scrollView.contentSize = _detailDes.frame.size;
    [self.view addSubview:scrollView];
    [scrollView addSubview:_detailDes];
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

//电影类型
-(void) startRequestFilm{
    //加载数据
    DataRequest *request = [QyDataManger getFilm4DById:_selectItem.entityId callback:^(NewFilmDetail *items, BOOL success) {
        _itemData = items;
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
        
        _name2Label.text = items.name;
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,items.image];
        [_iconImage sd_setImageWithURL:[NSURL URLWithString:url]];
    }];
    
    [request startAsynchronous];
}

#pragma mark -  收藏 播放 评论 分享 4个按钮

- (IBAction)likeBtnClick:(id)sender {
    //处理收藏按钮
    
}
- (IBAction)playerBtnClick:(id)sender {
    PlayerVC *mapVc = (PlayerVC*)[StoryboardHelper getVCByVCName:@"playerVC"];
    if(_itemData != nil){
        NSString * url = [NSString stringWithFormat:@"%@%@",kServerAddress,_itemData.video];
        mapVc.videoUrlStr = url;
        mapVc.titleName = _itemData.name;
    }
    [self.navigationController pushViewController:mapVc animated:YES];
}
- (IBAction)commentBtnClick:(id)sender {
    
    [self hiddenBellow:YES];
    UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:self options:nil] objectAtIndex:0];
    rootView.frame  = CGRectMake(0, 0, ScreenWitdh-20, ScreenHeight -124-70);
    CGPoint center = CGPointMake(ScreenWitdh/2, ScreenHeight/2+62);
    KLCPopup* popup = [KLCPopup popupWithContentView:rootView];
    popup.showType = KLCPopupShowTypeSlideInFromBottom;
    popup.shouldDismissOnBackgroundTouch = YES;
    popup.maskType = KLCPopupMaskTypeClear;
    popup.didFinishDismissingCompletion=^ (){
        [self hiddenBellow:NO];
    };
    [popup showAtCenter:center inView:rootView];
    
}
- (IBAction)shareBtnClick:(id)sender {
    [self hiddenBellow:YES];
    UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] objectAtIndex:0];
    rootView.frame  = CGRectMake(0, 0, ScreenWitdh-20, ScreenHeight -124-70);
    CGPoint center = CGPointMake(ScreenWitdh/2, ScreenHeight/2+62);
    KLCPopup* popup = [KLCPopup popupWithContentView:rootView];
    popup.showType = KLCPopupShowTypeSlideInFromBottom;
    popup.shouldDismissOnBackgroundTouch = YES;
    popup.maskType = KLCPopupMaskTypeClear;
    popup.didFinishDismissingCompletion=^ (){
        [self hiddenBellow:NO];
    };
    [popup showAtCenter:center inView:rootView];
}

-(void) hiddenBellow:(BOOL)hidden {
    _grayView.hidden = hidden;
    _detailDes.hidden = hidden;
}

@end
