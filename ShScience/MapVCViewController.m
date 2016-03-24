//
//  MapVCViewController.m
//  ShScience
//
//  Created by qiya on 16/1/12第3周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "MapVCViewController.h"
#import "QyUtils.h"
#import "UINavigationBar+Awesome.h"
#import "SKIndoorMapView.h"
#import "QyUtils.h"
#import "RKTabView.h"
#import "UIView+Ext.h"
#import "MapFileOwner.h"
#import "PathView.h"
#import "FloorVC.h"
#import "StoryboardHelper.h"
#import "DGActivityIndicatorView.h"
#import "LocateItem.h"
#import "JHChainableAnimations.h"
#import "Constant.h"
#import "DataManager.h"
#import "InfoItem.h"
#import "HomeVC.h"
#import "TabBarVC.h"

@interface MapVCViewController ()


@end

UIView *contentView;
SKIndoorMapView *indoorView;
UIView *itemView2;
UIView *itemView3;

MapFileOwner *owner;

@implementation MapVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏设置为透明色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    //big_scale_map
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWitdh, self.view.frame.size.height)];
    //[contentView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:contentView];
    
    
    [self setupNavBtn];
    
    [self setupBelowNav];
    
    
    //注册消息观察者
    [self initliazeUser];
    
    _displayLable = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight-60, ScreenWitdh, 30)];
    [_displayLable setBackgroundColor:[UIColor yellowColor]];
    [_displayLable setText:@"location Info display"];
    [self.view addSubview:_displayLable];
    
    _lastx = 0;
    _lasty = 0;
    
    
    //请求信息点数据
    [self requestDataAndBuild];
    
    //[indoorView bringSubviewToFront:_activityIndicatorView];

}

-(void)requestDataAndBuild{
    DataRequest *request = [DataManager loadPointInfoWithUser:nil floor:1 callback:^(NSArray *infos, BOOL success) {
        //
        NSLog(@"load point info with user %lu",(unsigned long)[infos count]);
        _infosArra = infos;
        //地图
        [self builderMap:Floor3 areaType:Areadqts upFloor:@"0" xPoint:500 yPoint:500];
        [self buildThreeButton];
        
    }];
    [request startAsynchronous];
}

#pragma mark - 构造地图
-(void) builderMap:(FloorType *) flooType areaType:(AreaType *)areaType upFloor:(NSString *)isUpFloor xPoint:(CGFloat) xpoint yPoint:(CGFloat)ypoint
{
    NSArray *mapName = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
                        @"floor_all_2",@"big_scale_map_dqts01",@"big_scale_map_zhzg01", @"big_scale_map_sjsyl",@"floor_all_2",@"big_scale_map_dwsj",@"floor_all_2",
                        @"big_scale_map_dqjy",@"big_scale_map_xxsd",@"big_scale_map_jqrsj",@"big_scale_map_zzz",@"floor_all_3",
                        
                        @"big_scale_map_tszg",@"big_scale_map_ryjk",@"big_scale_map_yhtd",@"floor_all_4"
                        
                        ,nil];
    NSString *name = [mapName objectAtIndex:areaType];
    
    indoorView = [[SKIndoorMapView alloc]initWithIndoorMapImageName:name Frame:CGRectMake(0, 0, ScreenWitdh, self.view.frame.size.height) Type:@"1" infoArr:_infosArra];//-64-44
    if(_selectMapName!=nil){
        indoorView = [[SKIndoorMapView alloc]initWithIndoorMapImageName:_selectMapName Frame:CGRectMake(0, 0, ScreenWitdh, self.view.frame.size.height) Type:@"1" infoArr:_infosArra];//-64-44
    }
    indoorView.navCtrl = self.navigationController;
    //[indoorView setBackgroundColor:[UIColor grayColor]];
    //换成网格背景
    indoorView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map_grid_bg"]];
    
    [contentView addSubview:indoorView];
    
    //当前指示位置
    _activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor redColor] size:35.0f];
    _activityIndicatorView.frame = CGRectMake(0, 0, 50.0f, 50.0f);//没有定位之前的一个固定位置
    [indoorView.mapView addSubview: _activityIndicatorView];
    [_activityIndicatorView startAnimating];
}

#pragma mark - 三个按钮
-(void) buildThreeButton{
    UIButton *hereBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh-45, ScreenHeight-175-50, 45, 45)];
    [hereBtn setBackgroundImage:[UIImage imageNamed:@"map_location"] forState:UIControlStateNormal];
    hereBtn.tag = 998;
    [hereBtn addTarget:nil action:@selector(btnOnMapperClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:hereBtn];
    
    UIButton *biggerBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh-45, ScreenHeight-175, 45, 45)];
    [biggerBtn setBackgroundImage:[UIImage imageNamed:@"map_bigger"] forState:UIControlStateNormal];
    biggerBtn.tag = 999;
    [biggerBtn addTarget:nil action:@selector(btnOnMapperClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:biggerBtn];
    
    UIButton *smallerBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh-45, ScreenHeight-125, 45, 45)];
    smallerBtn.tag = 1000;
    [smallerBtn addTarget:nil action:@selector(btnOnMapperClick:) forControlEvents:UIControlEventTouchUpInside];
    [smallerBtn setBackgroundImage:[UIImage imageNamed:@"map_smaller"] forState:UIControlStateNormal];
    [contentView addSubview:smallerBtn];
}


-(void) btnOnMapperClick:(UIButton *)sender {
    NSLog(@"btnOnMapperClick");
    if (sender.tag == 998) {//当前位置
        if(_lastLocateItem!=nil){//如果收到位置信息
            //切换到指定楼层指定展区,并且显示坐标
            [self builderMap:_lastLocateItem.floorType areaType:_lastLocateItem.areaType upFloor:@"0" xPoint:_lastLocateItem.pt.x yPoint:_lastLocateItem.pt.y];
        }
        else {//如果没有位置信息
            [indoorView scaleMapWithCenter:CGPointMake(500, 500) scaleSize:1];
        }
        //dsy 解析是哪个位置？？定位到相应的位置
        
    }
    else if(sender.tag==999){//放大
        //获取当前屏幕的中心点
        [indoorView scaleMapBiggerWithCenter:CGPointMake(500, 500)];
    }
    else if(sender.tag==1000){//缩小
        [indoorView scaleMapSmallerWithCenter:CGPointMake(500, 500)];
    }
}

#pragma mark - 定位触发相关方法
//注册消息观察者
-(void) initliazeUser {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locateUser:) name:@"DataManagerLocate" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeMap:) name:@"ChangeMap" object:nil];
}

//Selector 事件--地图切换
- (void)ChangeMap:(NSNotification *)notification{
    NSString *selectMapName = notification.userInfo[@"selectMapName"];
    _selectMapName = selectMapName;
    [self requestDataAndBuild];
}
//Selector 事件--定位
- (void)locateUser:(NSNotification *)notification{

    LocateItem *locateItem = notification.userInfo[@"locateItem"];
    _lastLocateItem = locateItem;
    NSLog(@"locateUser newlocateItem is=%@",locateItem);
    NSString *result = [NSString stringWithFormat:@"location x=%f,y=%f",locateItem.pt.x,locateItem.pt.y];
    [_displayLable setText:result];
    
    CGFloat movex = locateItem.pt.x -_lastx;
    CGFloat movey = locateItem.pt.y - _lasty;
    _lastx = locateItem.pt.x;
    _lasty = locateItem.pt.y;
    //更改到定位位置
    //_activityIndicatorView.moveXY(162.0f, 195.0f).animate(1.0);
//    CGFloat x = locateItem.pt.x*MAP_LOC_SCALE;
//    CGFloat y = locateItem.pt.y*MAP_LOC_SCALE;
    _activityIndicatorView.moveXY(movex,movey).animate(1.0);
    //_activityIndicatorView.transformXY(x,y).animate(1.0);
}

#pragma mark - RKTabItemDelegate的相关方法
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    NSLog(@"enable click index is=%i",index);
    NSLog(@"enable click tabItem is=%@",tabItem);
    if(index==0){
        [self removeSubView];
        //地图
        indoorView = [[SKIndoorMapView alloc]initWithIndoorMapImageName:@"big_scale_map_1" Frame:CGRectMake(0, 0, ScreenWitdh, self.view.frame.size.height) Type:@"1" infoArr:_infosArra];//-64-44
        indoorView.navCtrl = self.navigationController;
        [contentView addSubview:indoorView];
        //[contentView addSubview:indoorView];
    }
    else if (index==1){
        //load from xib
        [self removeSubView];
        //地图
        indoorView = [[SKIndoorMapView alloc]initWithIndoorMapImageName:@"big_scale_map_1" Frame:CGRectMake(0, 0, ScreenWitdh, self.view.frame.size.height) Type:@"1"];//-64-44
        indoorView.navCtrl = self.navigationController;
        indoorView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map_grid_bg"]];
        [contentView addSubview:indoorView];
        //画线
        _pathView= [[PathView alloc]initWithFrame:CGRectMake(50, 50, 1, 1)];
        _pathView.backgroundColor = [UIColor clearColor];
        [indoorView.mapView addSubview:_pathView];
        _pathView.userInteractionEnabled = YES;

    }
    else if (index==2){
        [self removeSubView];
        [contentView addSubview:indoorView];
        indoorView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map_grid_bg"]];
    }
    else if (index==3){//公共设施
        [self removeSubView];
        //标注公共设施路线
        indoorView = [[SKIndoorMapView alloc]initWithIndoorMapImageName:@"big_scale_map_1" Frame:CGRectMake(0, 0, ScreenWitdh, self.view.frame.size.height) Type:@"3"];//-64-44
        indoorView.navCtrl = self.navigationController;
        indoorView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map_grid_bg"]];
        [contentView addSubview:indoorView];
    }
    else if(index == 4){
        [self removeSubView];
        //当前馆内人数
        SXWaveView *animateView1 = [[SXWaveView alloc]initWithFrame:CGRectMake(140, 150,150, 150)];
        [self.view addSubview:animateView1];
        self.animateView1 = animateView1;
        [self.animateView1 setPrecent:40 description:@"当前人数" textColor:[UIColor orangeColor] bgColor:RGBA(39, 127, 195, 0) alpha:1 clips:NO];
        //[self.view addSubview:_animateView1];
        [self.animateView1 addAnimateWithType:0];
        
        UILabel *currentPeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 280, 200, 40)];
        currentPeopleLabel.text = @"馆内当前人数";
        currentPeopleLabel.font = [UIFont boldSystemFontOfSize:24];
        currentPeopleLabel.textColor = [UIColor whiteColor];
        
        UIImageView *simleView = [[UIImageView alloc]initWithFrame:CGRectMake(180, 350,80, 80)];
        simleView.image = [UIImage imageNamed:@"yongji_smile"];
        [contentView addSubview:simleView];
        [contentView addSubview:currentPeopleLabel];
        
        //下面的导航栏目
        UIImage *r3f = [UIImage imageNamed:@"r_3f"];
        UIImage *r3fSel = [UIImage imageNamed:@"r_2f_sel"];
        
        
        RKTabItem *tabItem1 = [RKTabItem createUsualItemWithImageEnabled:r3fSel imageDisabled:r3f];
        RKTabItem *tabItem2 = [RKTabItem createUsualItemWithImageEnabled:r3fSel imageDisabled:r3f];
        RKTabItem *tabItem3 = [RKTabItem createUsualItemWithImageEnabled:r3fSel imageDisabled:r3f];
        RKTabItem *tabItem4 = [RKTabItem createUsualItemWithImageEnabled:r3fSel imageDisabled:r3f];
        
        RKTabView *tabView = [[RKTabView alloc] initWithVerticalFrame:CGRectMake(ScreenWitdh-80, 70, 50, 200) andTabItems:@[tabItem1, tabItem2,tabItem3,tabItem4]];
        
        //tabView.tabItems = @[tabItem1, tabItem2,tabItem3,tabItem4,tabItem5];
        tabView.backgroundColor = [UIColor clearColor];//背景颜色
        tabView.delegate = self;
        
        [contentView addSubview:tabView];
        [tabView switchTabIndex:3];
    }
}

-(void) removeSubView{
    NSArray *viewsToRemove = [contentView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    if(_pathView!=nil){
        [_pathView removeFromSuperview];
    }
    if(_animateView1!=nil){
        [_animateView1 removeFromSuperview];
    }
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    NSLog(@"disable click index is=%i",index);
    NSLog(@"disable click tabItem is=%@",tabItem);
}


#pragma mark - 按钮和appear相关
- (void)Back_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //一直pop直到HomeVC
}

//楼层按钮
- (void)louceng_btn:(id)sender{
    
    FloorVC *floorVc = (FloorVC*)[StoryboardHelper getVCByVCName:@"floorVC"];
    floorVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:floorVc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    [self.navigationController.navigationBar lt_reset];
}


#pragma mark - setup导航按钮
//顶部导航栏
-(void) setupNavBtn {
    self.navigationController.navigationBarHidden = NO;//打开顶部Tab
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//导航字体颜色
    
    UIImage* image3 = [UIImage imageNamed:@"map_louceng_btn"];
    CGRect frameimg = CGRectMake(ScreenWitdh-15,5, 25,25);
    
    UIButton *loucengButton = [[UIButton alloc] initWithFrame:frameimg];
    [loucengButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [loucengButton addTarget:self action:@selector(louceng_btn:)
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
    self.navigationItem.title=@"地图";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

//底部导航栏
-(void)setupBelowNav {
    //下面的导航栏目
    UIImage *recPathBtn = [UIImage imageNamed:@"rec_path_btn"];
    UIImage *recPathBtnSel = [UIImage imageNamed:@"rec_path_btn_sel"];
    UIImage *hotPathBtn = [UIImage imageNamed:@"hot_path_btn"];
    UIImage *hotPathBtnSel = [UIImage imageNamed:@"hot_path_btn_sel"];
    UIImage *customPathBtn = [UIImage imageNamed:@"custom_path"];
    UIImage *customPathBtnSel = [UIImage imageNamed:@"custom_path_sel"];
    UIImage *facBtn = [UIImage imageNamed:@"fac_btn"];
    UIImage *factBtnSel = [UIImage imageNamed:@"fac_btn_sel"];
    UIImage *yongjiBtn = [UIImage imageNamed:@"yongji_btn"];
    UIImage *yongjiBtnSel = [UIImage imageNamed:@"yongji_btn_sel"];
    
    RKTabItem *tabItem1 = [RKTabItem createUsualItemWithImageEnabled:recPathBtnSel imageDisabled:recPathBtn];
    RKTabItem *tabItem2 = [RKTabItem createUsualItemWithImageEnabled:hotPathBtnSel imageDisabled:hotPathBtn];
    RKTabItem *tabItem3 = [RKTabItem createUsualItemWithImageEnabled:customPathBtnSel imageDisabled:customPathBtn];
    RKTabItem *tabItem4 = [RKTabItem createUsualItemWithImageEnabled:factBtnSel imageDisabled:facBtn];
    RKTabItem *tabItem5 = [RKTabItem createUsualItemWithImageEnabled:yongjiBtnSel imageDisabled:yongjiBtn];
    
    RKTabView *tabView = [[RKTabView alloc] initWithFrame:CGRectMake(0, ScreenHeight-35, ScreenWitdh, 55)];
    tabView.tabItems = @[tabItem1, tabItem2,tabItem3,tabItem4,tabItem5];
    tabView.backgroundColor = RGB(23, 45, 89);//背景颜色
    tabView.delegate = self;
    
    [self.view addSubview:tabView];
    [tabView switchTabIndex:0];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
