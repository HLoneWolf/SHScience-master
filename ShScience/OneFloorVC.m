//
//  OneFloorVC.m
//  ShScience
//
//  Created by qiya on 16/2/4第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "OneFloorVC.h"
#import "QyUtils.h"
#import "MapArea.h"
#import "MapVCViewController.h"
#import "StoryboardHelper.h"

@interface OneFloorVC ()

@end

@implementation OneFloorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *floorName = @"地图";
    if([_selectFloor isEqualToString:@"floor_all_4"]){
        floorName=@"地上三层";
    }
    else if([_selectFloor isEqualToString:@"floor_all_3"]){
        floorName=@"地上二层";
    }
    else if([_selectFloor isEqualToString:@"floor_all_2"]){
        floorName=@"地上一层";
    }
    else if([_selectFloor isEqualToString:@"floor_all_1"]){
        floorName=@"地下一层";
    }
    [self setupNavBtnWithTitleNoHidden:floorName];
    
    // Do any additional setup after loading the view.
    
    //地图
    _mapView = [[SKIndoorMapView alloc]initWithIndoorMapImageName:@"floor_all_4" Frame:CGRectMake(10, 100, ScreenWitdh, self.view.frame.size.height) Type:@"1" infoArr:nil];//-64-44
    if(_selectFloor){
        _mapView = [[SKIndoorMapView alloc]initWithIndoorMapImageName:_selectFloor Frame:CGRectMake(10, 100, ScreenWitdh, self.view.frame.size.height) Type:@"1" infoArr:nil];//-64-44
    }
    _mapView.navCtrl = self.navigationController;
    _mapView.mydelegate = self;
    _mapView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_mapView];
    [self setupPathOnMap];
}

#pragma mark -地图画区域
-(void) setupPathOnMap {
    
    
    if([_selectFloor isEqualToString:@"floor_all_4"]){
        [self pathDrawFloor4];
    }
    if([_selectFloor isEqualToString:@"floor_all_3"]){
        [self pathDrawFloor3];
    }
    if([_selectFloor isEqualToString:@"floor_all_2"]){
        [self pathDrawFloor2];
    }
    if([_selectFloor isEqualToString:@"floor_all_1"]){
        [self pathDrawFloor1];
    }
 
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
     [_mapView scaleMapWithCenter:CGPointMake(500, 500) scaleSize:0.5];
    //导航栏设置为透明色
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
}

-(void)performTouch:(NSValue *)inTouchPoint {
    
    
    if([_selectFloor isEqualToString:@"floor_all_4"]){
        NSArray *mapName = [NSArray arrayWithObjects:@"big_scale_map_yhtd",@"big_scale_map_yhtd",@"big_scale_map_ryjk",@"big_scale_map_tszg", nil];
        [self floorAndZhangquChange:mapName touchPoint:inTouchPoint];
    }
    
    if([_selectFloor isEqualToString:@"floor_all_3"]){
            NSArray *mapName = [NSArray arrayWithObjects:@"big_scale_map_zzz",@"big_scale_map_zzz",@"big_scale_map_jqrsj",@"big_scale_map_jqrsj",@"big_scale_map_xxsd",@"big_scale_map_dqjy", nil];
        [self floorAndZhangquChange:mapName touchPoint:inTouchPoint];
    }
    
    if([_selectFloor isEqualToString:@"floor_all_2"]){
        NSArray *mapName = [NSArray arrayWithObjects:@"big_scale_map_dwsj",@"big_scale_map_dwsj",@"big_scale_map_zhzg01",@"big_scale_map_dqts01",@"big_scale_map_zhzg01",@"big_scale_map_zhzg01",@"big_scale_map_sjsyl",nil];
        [self floorAndZhangquChange:mapName touchPoint:inTouchPoint];
        
    }
    
    if([_selectFloor isEqualToString:@"floor_all_1"]){
        NSArray *mapName = [NSArray arrayWithObjects:@"big_scale_map_ryjk",@"big_scale_map_tszg",@"big_scale_map_yhtd", nil];
        [self floorAndZhangquChange:mapName touchPoint:inTouchPoint];
    }
    
    

}

-(void) floorAndZhangquChange:(NSArray*)mapName touchPoint:(NSValue *)inTouchPoint{
    
    //4楼
    int index = -1;
    for (int i=0;i<[_zoneAreArray count]; i++) {
        //
        MapArea *a = [_zoneAreArray objectAtIndex:i];
        if([a isAreaSelected:[inTouchPoint CGPointValue]]){
            index = i;
        }
    }
    
    if(index != -1){
        //切换4楼地图，以某某为中心
        //跳转两步
        UINavigationController *navigationController = self.navigationController;
        NSString *selectMapName = [mapName  objectAtIndex:index];
        [[NSNotificationCenter defaultCenter ]postNotificationName:@"ChangeMap" object:nil userInfo:@{@"selectMapName":selectMapName}];
        [navigationController popViewControllerAnimated:NO];
        [navigationController popViewControllerAnimated:YES];
    }

}

#pragma mark - 每层的标识

-(void) pathDrawFloor4{
    
    NSArray *mapName = [NSArray arrayWithObjects:@"big_scale_map_yhtd",@"big_scale_map_yhtd",@"big_scale_map_ryjk",@"big_scale_map_tszg", nil];
    _zoneAreArray = [NSMutableArray array];
    //开始图像绘图
    UIGraphicsBeginImageContext(_mapView.mapView.bounds.size);
    
    
    NSString *path1 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(230, 130)] width:70];//太空影院
    MapArea* arear1 = [[MapArea alloc]initWithCoordinate:path1];
//    [arear1.mapArea stroke];
    
    
    NSString *path2 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(160, 240)] width:90];//人与健康
    MapArea* arear2 = [[MapArea alloc]initWithCoordinate:path2];
//    [arear2.mapArea stroke];
    
    
    NSString *path3 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(320, 70)] width:100];//宇航天地
    MapArea* arear3 = [[MapArea alloc]initWithCoordinate:path3];
//    [arear3.mapArea stroke];
    
    NSString *path4 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(100, 350)] width:100];//探索之光
    MapArea* arear4 = [[MapArea alloc]initWithCoordinate:path4];
//    [arear4.mapArea stroke];
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [_mapView.mapView addSubview:imgView];
    
    [_zoneAreArray addObject: arear3];
    [_zoneAreArray addObject: arear1];
    [_zoneAreArray addObject: arear2];
    [_zoneAreArray addObject: arear4];
}

-(void) pathDrawFloor3{
    _zoneAreArray = [NSMutableArray array];
    //开始图像绘图
    

    UIGraphicsBeginImageContext(_mapView.mapView.bounds.size);
    
    NSString *path_zhizhu = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(740, 180)] width:100];//四维
    MapArea* arear_zhizhu = [[MapArea alloc]initWithCoordinate:path_zhizhu];
//    [arear_zhizhu.mapArea stroke];

    
    
    NSString *path_siwei = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(440, 120)] width:90];//四维
    MapArea* arear_siwei = [[MapArea alloc]initWithCoordinate:path_siwei];
//    [arear_siwei.mapArea stroke];
    
    NSString *path1 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(210, 200)] width:70];//机器人世界
    MapArea* arear1 = [[MapArea alloc]initWithCoordinate:path1];
//    [arear1.mapArea stroke];
    
    
    NSString *path2 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(140, 280)] width:80];//信息时代
    MapArea* arear2 = [[MapArea alloc]initWithCoordinate:path2];
//    [arear2.mapArea stroke];
    
    
    NSString *path3 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(270, 120)] width:90];//特展厅
    MapArea* arear3 = [[MapArea alloc]initWithCoordinate:path3];
//    [arear3.mapArea stroke];
    
    NSString *path4 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(80, 370)] width:70];//地球家园
    MapArea* arear4 = [[MapArea alloc]initWithCoordinate:path4];
//    [arear4.mapArea stroke];
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [_mapView.mapView addSubview:imgView];
    
    
    [_zoneAreArray addObject: arear_zhizhu];
    [_zoneAreArray addObject:arear_siwei];
    [_zoneAreArray addObject: arear3];
    [_zoneAreArray addObject: arear1];
    [_zoneAreArray addObject: arear2];
    [_zoneAreArray addObject: arear4];
}

-(void) pathDrawFloor2{
    _zoneAreArray = [NSMutableArray array];
    //开始图像绘图
   

    UIGraphicsBeginImageContext(_mapView.mapView.bounds.size);
    
    
    NSString *path_shengwu = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(820, 360)] width:100];//生物
    MapArea* arear_shengwu = [[MapArea alloc]initWithCoordinate:path_shengwu];
//    [arear_shengwu.mapArea stroke];
    
    NSString *path_dongwu = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(700, 360)] width:100];//动物
    MapArea* arear_dongwu = [[MapArea alloc]initWithCoordinate:path_dongwu];
//    [arear_dongwu.mapArea stroke];
    
    
    NSString *path1 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(270, 170)] width:70];//地壳秘密
    MapArea* arear1 = [[MapArea alloc]initWithCoordinate:path1];
//    [arear1.mapArea stroke];
    
    
    NSString *path_ertong = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(170, 170)] width:70];//儿童乐园
    MapArea* arear_ertong = [[MapArea alloc]initWithCoordinate:path_ertong];
//    [arear_ertong.mapArea stroke];
    
    NSString *path2 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(120, 280)] width:90];//智慧之光
    MapArea* arear2 = [[MapArea alloc]initWithCoordinate:path2];
//    [arear2.mapArea stroke];
    
    
    NSString *path3 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(440, 110)] width:100];//四维
    MapArea* arear3 = [[MapArea alloc]initWithCoordinate:path3];
//    [arear3.mapArea stroke];
    
    NSString *path4 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(70, 380)] width:100];//设计师摇篮
    MapArea* arear4 = [[MapArea alloc]initWithCoordinate:path4];
//    [arear4.mapArea stroke];
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [_mapView.mapView addSubview:imgView];
    
    [_zoneAreArray addObject:arear_shengwu];
    [_zoneAreArray addObject:arear_dongwu];
    [_zoneAreArray addObject: arear3];
    [_zoneAreArray addObject: arear1];
    [_zoneAreArray addObject:arear_ertong];
    [_zoneAreArray addObject: arear2];
    [_zoneAreArray addObject: arear4];
}

-(void) pathDrawFloor1{
    _zoneAreArray = [NSMutableArray array];
    //开始图像绘图
    UIGraphicsBeginImageContext(_mapView.mapView.bounds.size);
    
     NSArray *mapName = [NSArray arrayWithObjects:@"big_scale_map_ryjk",@"big_scale_map_tszg",@"big_scale_map_yhtd", nil];
    NSString *path1 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(400, 70)] width:110];//临展区上
    MapArea* arear1 = [[MapArea alloc]initWithCoordinate:path1];
//    [arear1.mapArea stroke];
    
    
    NSString *path2 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(160, 220)] width:110];//临展区下
    MapArea* arear2 = [[MapArea alloc]initWithCoordinate:path2];
//    [arear2.mapArea stroke];
    
    
    
    NSString *path4 = [QyUtils getRectAllPointStrFormat:[NSValue valueWithCGPoint:CGPointMake(800, 310)] width:150];//巨幕电影
    MapArea* arear4 = [[MapArea alloc]initWithCoordinate:path4];
//    [arear4.mapArea stroke];
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [_mapView.mapView addSubview:imgView];
    
    [_zoneAreArray addObject: arear4];
    [_zoneAreArray addObject: arear1];
    [_zoneAreArray addObject: arear2];
    
}


@end
