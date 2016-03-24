//
//  RecommandMapVC.m
//  ShScience
//
//  Created by qiya on 16/1/3第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "RecommandMapVC.h"
#import "DGActivityIndicatorView.h"
#import "UINavigationBar+Awesome.h"
#import "QyUtils.h"
#import "RFSegmentView.h"
#import "WYPopoverController.h"
#import "StoryboardHelper.h"
#import "PopSelectVC.h"

@implementation RecommandMapVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //[self setupNavBtn];
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab

    
    //设置上半部分的三段
    [self setupHeaderTab];
    
    
    _itemarray =[[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        [_itemarray addObject:@""];
    }
    
//    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:35.0f];
//    activityIndicatorView.frame = CGRectMake(62.0f, 95.0f, 50.0f, 50.0f);
//    [self.view addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
    
}


#pragma mark - setup 三段选择Tab

-(void) setupHeaderTab {
    CGRect aRect = CGRectMake(-12, 20, ScreenWitdh+24, 60);
    
    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:aRect items:@[@"推荐路线",@"热门路线",@"自定义路线"]];
    //segmentView.backgroundColor = [UIColor redColor];
    segmentView.tintColor       = [UIColor clearColor];
    segmentView.itemHeight      = 44.0f;
    segmentView.leftRightMargin = 0.f;
    segmentView.segementItemNorColor = RGB(39, 127, 195);
    segmentView.segementItemSelColor = [UIColor whiteColor];

    segmentView.handlder        = ^ (RFSegmentView * __nullable view, NSInteger selectedIndex) {
        // doSomething
        NSLog(@"segment selected index is:%lu",(unsigned long)selectedIndex);
        if(selectedIndex==0){//推荐路线
            //预约表格
            [self removeOtherView];
            [self setupHotPathTable];
        }
        else if(selectedIndex == 1){//热门路线
            [self removeOtherView];
            
            [self setupHotPathTable];
            
        }
        else if(selectedIndex==2){//自定义路线
            [self removeOtherView];
            _hiddenBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh-100, 60, 20, 20)];
            [_hiddenBtn setBackgroundColor:[UIColor redColor]];
            [_hiddenBtn addTarget:nil action:@selector(callRightLayout) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_hiddenBtn];
            _hiddenBtn.hidden = YES;
            
            [self setupCustomPathTable];//初始化表格
            
            //生成按钮
            UIButton *genBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh-100, ScreenHeight-120, 60, 60)];
            [genBtn setBackgroundImage:[UIImage imageNamed:@"qiu_gen"] forState:UIControlStateNormal];
            [genBtn addTarget:nil action:@selector(genClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:genBtn];
        }
    };
    [self setupHotPathTable];
    segmentView.selectedIndex = 0;//先选择自定义路线
    [self.view addSubview:segmentView];
}

-(void) genClick {
    NSLog(@"gen btn click");
}

-(void) callRightLayout {
    
   _vc = (PopSelectVC *)[StoryboardHelper getVCByVCName:@"popSelectVC"];
    _vc.callBtn = _hiddenBtn;
    _vc.delgate = self;
    _vc.preferredContentSize = CGSizeMake(320, 400);
//    CGFloat width = _vc.preferredContentSize.width*0.5;
//    CGFloat height = _vc.preferredContentSize.height*0.5;
//    _vc.preferredContentSize = CGSizeMake(width, height);
    
                _popover = [[WYPopoverController alloc] initWithContentViewController:_vc];
    _popover.delegate = self;
    
                [_popover presentPopoverFromRect:_hiddenBtn.bounds
                                         inView:_hiddenBtn
                       permittedArrowDirections:WYPopoverArrowDirectionAny
                                       animated:YES
                                        options:WYPopoverAnimationOptionFadeWithScale];
}
-(void) done:(NSString*) select {
    [_popover dismissPopoverAnimated:YES];
    [_itemarray replaceObjectAtIndex:_currentIdex withObject:select];
    [_customPath reloadData];
}

-(void)removeOtherView{
    for (UIView *view in self.view.subviews) {
        if (![view isKindOfClass:[RFSegmentView class]]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - setup导航按钮

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
    //    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:loucengButton];
    //    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *backBtttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBtttonItem;
    
    //设置标题及颜色
    self.navigationItem.title=@"学习清单";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

#pragma mark - 按钮和appear相关
- (void)Back_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//楼层按钮
- (void)louceng_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - appear disapper
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //导航栏设置为透明色
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
//    [self.navigationController.navigationBar lt_reset];
}




#pragma mark - WYPopoverControllerDelegate

- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerDidPresentPopover");
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    PopSelectVC *psvc =(PopSelectVC *)controller.contentViewController;
    NSLog(@" popselectvc select index is %@", psvc.selectId);
    
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if (controller == _popover)
    {
        _popover.delegate = nil;
        _popover = nil;
    }
//    [_customPath reloadData];
}

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController
{
    return YES;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 0; // set value to 0 if you want to avoid the popover to be moved
}



#pragma mark - 关于表格相关的处理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_customPath){
        return [_itemarray count];
    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView==_customPath){//自定义路线
        return [self setupCustomPath:tableView cellForRowAtIndexPath:indexPath];
    }
    if(tableView == _hotPath){//热门路线
        return [self setupHotPathCell:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _customPath){
        return 100;
    }
    else if(tableView == _hotPath) {
        return 185;
    }
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"learnVC didSelectRowAtIndexPath=%li",(long)indexPath.row);
}

#pragma mark - 自定义线路
//自定义路线
-(UITableViewCell*) setupCustomPath:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell1;
    if (cell1 == nil){
      cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                     reuseIdentifier:@"learnTableCell"];
    }

    //UIImageView *verImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWitdh/2-20, 20, 60, 60)];
    //verImgView.image = [UIImage imageNamed:@"qiu_add"];
    UIButton *addImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh/2-20, 20, 60, 60)];
    if([@"" isEqualToString:[_itemarray objectAtIndex:indexPath.row]]){
        [addImageBtn setBackgroundImage:[UIImage imageNamed:@"qiu_add"] forState:UIControlStateNormal];
    }
    else {
        [addImageBtn setBackgroundImage:[UIImage imageNamed:@"qiu_one"] forState:UIControlStateNormal];
    }
    addImageBtn.tag = indexPath.row + 1000;
    [addImageBtn addTarget:nil action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell1 addSubview:addImageBtn];
    [cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
}

//自定义路线表格
-(void) setupCustomPathTable {
    if(_customPath==nil){
        _customPath = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, ScreenWitdh, ScreenHeight)];
        _customPath.dataSource = self;
        _customPath.delegate = self;
        _customPath.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_customPath setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_customPath];
    }
    else{
        [self.view addSubview:_customPath];
    }
}

#pragma mark - 热门路线表格
-(UITableViewCell*) setupHotPathCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell1;
    if (cell1 == nil){
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:@"hotTableCell"];
    }
    if(indexPath.row%2==0){
//        cell1.backgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"path_guiji1"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
        UIImageView *pathImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWitdh/2-10+3, 10, 77, 190)];
        pathImageView.image = [UIImage imageNamed:@"path_guiji1"];

        [cell1 addSubview:pathImageView];
        
        UIButton *addImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh/2+30, 70, 80, 80)];
        [addImageBtn setBackgroundImage:[UIImage imageNamed:@"qiu_one"] forState:UIControlStateNormal];
        addImageBtn.tag = indexPath.row + 1000;
        [addImageBtn addTarget:nil action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell1 addSubview:addImageBtn];
    }
    else {
        UIImageView *pathImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWitdh/2-77-3, 10, 77, 190)];
        pathImageView.image = [UIImage imageNamed:@"path_guiji2"];

//        cell1.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"path_guiji2"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        [cell1 addSubview:pathImageView];
        
        UIButton *addImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWitdh/2-120, 70, 80, 80)];
        [addImageBtn setBackgroundImage:[UIImage imageNamed:@"qiu_one"] forState:UIControlStateNormal];
        addImageBtn.tag = indexPath.row + 1000;
        [addImageBtn addTarget:nil action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell1 addSubview:addImageBtn];
    }

    
    
    [cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell1;
}
//热门路线表格
-(void) setupHotPathTable {
    if (_hotPath == nil){
        _hotPath = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, ScreenWitdh, ScreenHeight)];
        _hotPath.dataSource = self;
        _hotPath.delegate = self;
        _hotPath.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_hotPath setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_hotPath];
    }
    else{
        [self.view addSubview:_hotPath];
    }
}


-(void) addImageClick:(id) sender {
    NSLog(@"addImageClick...");
    UIButton *clicked = (UIButton *) sender;
    NSInteger index = clicked.tag-1000;
    _currentIdex = index;
    [self callRightLayout];
   
}




@end
