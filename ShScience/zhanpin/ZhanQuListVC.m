//
//  ZhanQuListVC.m
//  ShScience
//
//  Created by qiya on 16/2/3第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ZhanQuListVC.h"
#import "UINavigationBar+Awesome.h"
#import "QyUtils.h"
#import "NKContainerCellTableViewCell.h"
#import "DataManager.h"
#import "ZhanPinVC.h"
#import "StoryboardHelper.h"
#import "RoomRelationItem.h"

@interface ZhanQuListVC ()

@end

@implementation ZhanQuListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtn];
    [self setupContent];

//    self.sampleData = @[
//      @{
//        @"description" : @"2016-06-14",
//        @"Blocks" : @[
//          @{@"title" : @"Block A1", @"image" : @"zq_konglong1"}
//
//        ]
//      }
//    ];
    
    //请求网络数据
    [self requestZhanQuRelation];
    NSMutableArray *muteArr = [NSMutableArray array];
    for(RoomRelationItem *relItem in _zhanquRelationArr){
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@"2016-06-14" forKey:@"description"];
        
        NSMutableArray *smallmuteArr = [NSMutableArray array];
        
        NSArray *pics = relItem.pics;
        for (NSString *picStr in pics) {
            NSString *url = [NSString stringWithFormat:@"%@%@",[DataManager shareDataManager].serverAddress,picStr];
            NSMutableDictionary *dictsmall = [NSMutableDictionary new];
            [dictsmall setObject:@"zq_konglong1" forKey:@"title"];
            [dictsmall setObject:url forKey:@"image"];
            [smallmuteArr addObject:dictsmall];
        }
        [dict setObject:smallmuteArr forKey:@"Blocks"];
        [muteArr addObject:dict];
    }
    NSLog(@"------%@",muteArr);
    self.sampleData = muteArr;
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"description" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    _arrayChronologicalOrder = [self.sampleData sortedArrayUsingDescriptors:descriptors];
    
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

#pragma mark - tableview 相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==_zhanquTableView){
        return [_arrayChronologicalOrder count];
    }
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(tableView==_zhanquTableView){
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"NKContainerCellTableViewCell%ld",indexPath.section];
    NKContainerCellTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell4) {
        cell4 = [[NKContainerCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:CellIdentifier];
        NSDictionary *cellData = [_arrayChronologicalOrder objectAtIndex:[indexPath section]];
        NSArray *BlockData = [cellData objectForKey:@"Blocks"];
//        [cell4 setCollectionData:BlockData];
        if(indexPath.section==1){
            [cell4 setCollectionData:BlockData ImageName:@"zq_linzhan"];
        }
        else {
            [cell4 setCollectionData:BlockData ImageName:@"zq_fav"];
        }
        
        cell4.backgroundColor = [UIColor clearColor];
        cell4.selectionStyle = UITableViewCellAccessoryNone;
    }
    return cell4;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(tableView == _zhanquTableView){
        return 180;
    }
    
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - appear disapper
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //导航栏设置为透明色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    //self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    [self.navigationController.navigationBar lt_reset];
}



#pragma mark - setup 主内容
-(void) setupContent {
    self.slideShow = [[KIImagePager alloc] initWithFrame:CGRectMake(0, 75, ScreenWitdh, 190)];
    _slideShow.delegate = self;
    _slideShow.dataSource = self;
    _slideShow.imageCounterDisabled = YES;
    _slideShow.captionTextColor = [UIColor whiteColor];
    _slideShow.captionFont = [UIFont boldSystemFontOfSize:28];
    _slideShow.captionBackgroundColor = [UIColor blackColor];
    [self.view addSubview:_slideShow];
    
    
    _zhanquTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, ScreenWitdh, ScreenHeight)];
    _zhanquTableView.dataSource = self;
    _zhanquTableView.delegate = self;
    _zhanquTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_zhanquTableView setBackgroundColor:[UIColor clearColor]];
    // Add observer that will allow the nested collection cell to trigger the view controller select row at index path
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
    [self.view addSubview:_zhanquTableView];

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
    self.navigationItem.title=@"展区";
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


#pragma mark - slidshow  相关

- (NSArray *) arrayWithImages:(KIImagePager*)pager
{
    NSMutableArray *items = [NSMutableArray array];
    NSArray *pics = _roomItem.pics;
    for (int i=0;i<[pics count];i++) {
        NSString *picUrl = pics[i];
       NSString  *newUrl = [NSString stringWithFormat:@"%@%@",kServerAddress,picUrl];
        
        [items addObject:newUrl];
    }
    return [items copy];
    //return @[@"http://pic.qiyadeng.com/zq_slider.png",@"http://pic.qiyadeng.com/zq_slider.png",@"http://pic.qiyadeng.com/zq_slider.png"];
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager*)pager
{
    return UIViewContentModeScaleAspectFill;
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index inPager:(KIImagePager*)pager
{

    return _roomItem.name;
//    return @[
//             @"宇航天地",
//             @"宇航天地",
//             @"宇航天地3"
//             ][index];
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(KIImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
}

- (void) imagePager:(KIImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{
    NSLog(@"%s %lu", __PRETTY_FUNCTION__, (unsigned long)index);
    ZhanPinVC *viewController = (ZhanPinVC *)[StoryboardHelper getVCByVCName:@"zhanpinVC"];
    viewController.roomDetailItem = _roomItem;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];

    
}

#pragma mark - NSNotification to select table cell

- (void) didSelectItemFromCollectionView:(NSNotification *)notification
{
    NSDictionary *cellData = [notification object];
    NSLog(@"Data:-->%@",cellData);
}




#pragma mark - 请求网络数据
-(void) requestZhanQuRelation{
    DataRequest *request = [DataManager getZhanquRoomRelationList:@"6" type:@"2" callback:^(NSArray *items, BOOL success) {
        //
        _zhanquRelationArr = items;
    }];
    [request startSynchronous];
}
@end
