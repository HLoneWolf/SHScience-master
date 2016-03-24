//
//  FloorVC.m
//  ShScience
//
//  Created by qiya on 16/2/2第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "FloorVC.h"
#import "UINavigationBar+Awesome.h"
#import "QyUtils.h"
#import "OneFloorVC.h"
#import "StoryboardHelper.h"

@interface FloorVC ()
@property (weak, nonatomic) IBOutlet UIImageView *lou1View;
@property (weak, nonatomic) IBOutlet UIImageView *lou2View;
@property (weak, nonatomic) IBOutlet UIImageView *lou3View;
@property (weak, nonatomic) IBOutlet UIImageView *lou4View;

@end

@implementation FloorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;//打开顶部Tab
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//导航字体颜色
    
    UIImage* image3 = [UIImage imageNamed:@"map_map"];
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
    self.navigationItem.title=@"楼层地图";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    //下面的导航栏目
    RKTabItem *tabItem1 = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"floor_btn_3_sel"] imageDisabled:[UIImage imageNamed:@"floor_btn_3"]];
    RKTabItem *tabItem2 = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"floor_btn_2_sel"] imageDisabled:[UIImage imageNamed:@"floor_btn_2"]];
    RKTabItem *tabItem3 = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"floor_btn_1_sel"] imageDisabled:[UIImage imageNamed:@"floor_btn_1"]];
    RKTabItem *tabItem4 = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"floor_btn_b1_sel"] imageDisabled:[UIImage imageNamed:@"floor_btn_b1"]];

    RKTabView *tabView = [[RKTabView alloc] initWithVerticalFrame:CGRectMake(ScreenWitdh-80, 70, 50, 200) andTabItems:@[tabItem1, tabItem2,tabItem3,tabItem4]];
    
    //tabView.tabItems = @[tabItem1, tabItem2,tabItem3,tabItem4,tabItem5];
    tabView.backgroundColor = [UIColor clearColor];//背景颜色
    tabView.delegate = self;
    
    [self.view addSubview:tabView];
    [tabView switchTabIndex:0];

//楼层图的点击事件
    
    _lou1View.userInteractionEnabled = YES;
    _lou2View.userInteractionEnabled = YES;
     _lou3View.userInteractionEnabled = YES;
     _lou4View.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage3f)];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage2f)];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage1f)];
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageb1f)];
    [_lou1View addGestureRecognizer:singleTap1];
    [_lou2View addGestureRecognizer:singleTap2];
    [_lou3View addGestureRecognizer:singleTap3];
    [_lou4View addGestureRecognizer:singleTap4];
    
    
    _lou1View.hidden = YES;
    _lou2View.hidden = YES;
    _lou3View.hidden = YES;
    _lou4View.hidden = YES;
    
    [self setupiCarousel];
}

-(void) setupiCarousel {
    [self.view addSubview:self.iCarousel];
}

-(iCarousel *)iCarousel{

    if (_iCarousel == nil) {
        _iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(20, 60, ScreenWitdh-100, ScreenHeight*0.67)];
        _iCarousel.delegate = self;
        _iCarousel.vertical = YES;
        _iCarousel.dataSource = self;
        _iCarousel.bounces = NO;
        _iCarousel.pagingEnabled = YES;
        _iCarousel.type = iCarouselTypeLinear;
    }
    return _iCarousel;
}

#pragma mark - 图片点击
-(void)onClickImage3f{
    // here, do whatever you wantto do
    OneFloorVC *oneVc = (OneFloorVC *)[StoryboardHelper getVCByVCName:@"oneFloorVC"];
    oneVc.selectFloor = @"floor_all_4";
    oneVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oneVc animated:YES];
}
-(void)onClickImage2f{
    // here, do whatever you wantto do
    OneFloorVC *oneVc = (OneFloorVC *)[StoryboardHelper getVCByVCName:@"oneFloorVC"];
    oneVc.selectFloor = @"floor_all_3";
    oneVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oneVc animated:YES];
}
-(void)onClickImage1f{
    // here, do whatever you wantto do
    OneFloorVC *oneVc = (OneFloorVC *)[StoryboardHelper getVCByVCName:@"oneFloorVC"];
    oneVc.selectFloor = @"floor_all_2";
    oneVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oneVc animated:YES];
}
-(void)onClickImageb1f{
    // here, do whatever you wantto do
    OneFloorVC *oneVc = (OneFloorVC *)[StoryboardHelper getVCByVCName:@"oneFloorVC"];
    oneVc.selectFloor = @"floor_all_1";
    oneVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oneVc animated:YES];
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
#pragma mark - 左右两个返回按钮
- (void)Back_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//楼层按钮
- (void)louceng_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 覆盖系统 appear
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //导航栏设置为透明色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
}


#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    return 4;
    
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{

        UILabel *label = nil;
        
        // create new view if no view is available for recycling
        if (view == nil) {
            // don't do anything specific to the index within
            // this `if (view == nil) {...}` statement because the view will be
            // recycled and used with other index values later
            
            

                NSString *imageName =
                [NSString stringWithFormat:@"floor_all_%ld", (long)4-index];
                view =
                [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 259.0f, 132.0f)];
            if(index==0){
                view =
                [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120.0f, 122.0f)];
            }
                ((UIImageView *)view).image = [UIImage imageNamed:imageName];
            
            view.contentMode = UIViewContentModeScaleToFill;
            
            label = [[UILabel alloc] initWithFrame:view.bounds];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [label.font fontWithSize:50];
            label.tag = 1;
            [view addSubview:label];
        } else {
            // get a reference to the label in the recycled view
            label = (UILabel *)[view viewWithTag:1];
        }
        
        return view;
   
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{

        NSLog(@"iCar index is %li",(long)index);
    
    OneFloorVC *oneVc = (OneFloorVC *)[StoryboardHelper getVCByVCName:@"oneFloorVC"];
    NSString *imageName =
    [NSString stringWithFormat:@"floor_all_%ld", (long)4-index];
    oneVc.selectFloor = imageName;
    oneVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oneVc animated:YES];

}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{

        if (option == iCarouselOptionSpacing)
        {
            return value*1.4;
        }
        if(option == iCarouselOptionVisibleItems){
            return 5;
        }
        if(option == iCarouselOptionCount){
            return 5;
        }

        
        return value;
        

    
}


@end
