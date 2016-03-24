//
//  HomeVC.m
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/3.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "HomeVC.h"
#import "EFAnimationViewController.h"
#import "iCarousel.h"
#import "MZTimerLabel.h"
#import "JDFlipNumberView.h"
#import "MapVCViewController.h"
#import "StoryboardHelper.h"
#import "PlayerVC.h"
#import "ZhanPinVC.h"
#import "QyUtils.h"
#import "SearchResultVC.h"
#import "LoginVC.h"
#import "DataManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "InterestLabelItem.h"
#import "JHChainableAnimations.h"
#import "FilmItem.h"
#import "QyDataManger.h"
#import "TemporaryDisplay.h"
#import "ShiyanItem.h"
#import "FilmDetailVC.h"
#import "ZhanQuDetailVC.h"
#import "HuoDongDetailVC.h"
#import "LinZhanDetailVC.h"
#import "NewZhanPinDetailVC.h"
#import "JDFlipClockView.h"


#define kCellIdentifier @"cellIdentifier"

@interface HomeVC ()

@property (weak, nonatomic) IBOutlet iCarousel *iCar;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSArray *leftItems;

@property (weak, nonatomic) IBOutlet iCarousel *iCenimal;
@property (nonatomic, strong) NSMutableArray *cenimalItems;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;


@property (weak, nonatomic) IBOutlet UIImageView *jumuImage;

@property (weak, nonatomic) IBOutlet UIButton *jumuBtn;

@property (weak, nonatomic) IBOutlet UIImageView *jumuSamllImage;
@property (weak, nonatomic) IBOutlet UIButton *jumuSamllBtn;

@property (weak, nonatomic) IBOutlet UIImageView *taikongSamllImage;
@property (weak, nonatomic) IBOutlet UIButton *taikongBtn;


@property (weak, nonatomic) IBOutlet UIImageView *qiumuSmallImage;
@property (weak, nonatomic) IBOutlet UIButton *qiumuBtn;

@property (weak, nonatomic) IBOutlet UIImageView *siweiSmallImage;

@property (weak, nonatomic) IBOutlet UIButton *siweiBtn;

@property (weak, nonatomic) IBOutlet UILabel *yinyuanLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@property (weak, nonatomic) IBOutlet UIButton *movieBtn1;
@property (weak, nonatomic) IBOutlet UIButton *movieBtn2;
@property (weak, nonatomic) IBOutlet UIButton *movieBtn3;

@end

@implementation HomeVC

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        [_items addObject:@(i)];
    }
    
    self.cenimalItems= [NSMutableArray array];
    for (int i = 0; i < 4; i++)
    {
        [_cenimalItems addObject:@(i)];
    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _jumuBtn.hidden = YES;//隐藏巨幕的按钮显示巨幕图
    //请求网络获取数据
    [self requestLeftPagedata];
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    //self.iCar.type = iCarouselTypeCylinder;
    self.iCar.type = iCarouselTypeRotary;
    self.iCar.type = iCarouselTypeCustom;
    self.iCar.vertical = YES;
    _iCar.backgroundColor = [UIColor clearColor];
    self.iCar.dataSource = self;
    self.iCar.delegate = self;
    self.iCar.scrollSpeed = 0.8;
    self.iCar.pagingEnabled = YES;
    
    self.iCenimal.hidden = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];

    _searchTextField.tintColor = [UIColor whiteColor];
    _searchTextField.textColor = [UIColor whiteColor];
    _searchTextField.hidden = YES;
    [[self view] endEditing:YES];
    
    
//    _flipNumberView = [[JDFlipNumberView alloc] initWithDigitCount:2 imageBundleName:@"MyFlipNumberView"];
//    _flipNumberView.value = 60;
//    [_flipNumberView animateDownWithTimeInterval: 1.0];
//    [self.view addSubview: _flipNumberView];
//    _flipNumberView.frame = CGRectMake(322,368,50,30);
    
    self.filpClockView = [[JDDateCountdownFlipView alloc] initWithDayDigitCount:0 imageBundleName:@"MyFlipNumberView"];
    self.filpClockView.targetDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60];
//    [self.filpClockView setBackgroundColor:[UIColor yellowColor]];
    self.filpClockView.frame = CGRectMake(240,368,100,100);
    [self.view addSubview:self.filpClockView];
    
    
    
    
    //搜索
    CGFloat controlWidth = 300;
    autoCompleteTextField = [[NHAutoCompleteTextField alloc] initWithFrame:CGRectMake(60+5, 30, ScreenWitdh-100-45, 50)];
    [autoCompleteTextField setDropDownDirection:NHDropDownDirectionDown];
    [autoCompleteTextField setDataSourceDelegate:self];
    [autoCompleteTextField setDataFilterDelegate:self];
    

    [self.view addSubview:autoCompleteTextField];
    autoCompleteTextField.suggestionTextField.background = [UIImage imageNamed:@"home_search"];
    autoCompleteTextField.suggestionListView.backgroundColor = [UIColor clearColor];
    autoCompleteTextField.backgroundColor = [UIColor clearColor];
    autoCompleteTextField.suggestionTextField.leftViewMode = UITextFieldViewModeAlways;
    autoCompleteTextField.suggestionTextField.leftView = view;
    manager = [[DemoDataManager alloc] init];
    inUseDataSource = [manager fetchDataSynchronously];
    
    //添加随手拍按钮
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 45, 30, 25)];
    //photoBtn.backgroundColor = [UIColor redColor];
    [photoBtn setBackgroundImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [photoBtn addTarget:nil action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoBtn];
    
    [self setupQiu];
    [self timeHiddenOrDispay:YES];
}

#pragma mark - 球的设置

- (void) setupQiu{
    _movieBtn1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _movieBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_movieBtn1 setTitle: @"" forState: UIControlStateNormal];
    _movieBtn2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _movieBtn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    _movieBtn3.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _movieBtn3.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_movieBtn2 setTitle: @"" forState: UIControlStateNormal];
    [_movieBtn3 setTitle: @"" forState: UIControlStateNormal];
    
    _jumuImage.image = [UIImage imageNamed:@"cenima1_big"];
    _yinyuanLabel.text=@"展览";
    _detailLabel.hidden = YES;
    _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
        //_detailLabel.hidden = NO;
    });
    
    [self requestLinZhanInfo];

}
- (IBAction)jumuClick:(id)sender {
    //显示的地方什么都不做。
}
- (IBAction)jumuSmallClick:(UIButton *)sender {
    
    
    if(sender.tag==400){
        _jumuImage.image = [UIImage imageNamed:@"cenima1_big"];
        _yinyuanLabel.text=@"展览";
        _detailLabel.hidden = YES;
        _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
            NSLog(@"Animation Done");
            //_detailLabel.hidden = NO;
        });
        //隐藏计时部分
        [self timeHiddenOrDispay:YES];
        [self requestLinZhanInfo];
    }
    else if(sender.tag == 401){//球幕影院
        _jumuImage.image = [UIImage imageNamed:@"cenima2_big"];
        _yinyuanLabel.text=@"影院";
        _detailLabel.hidden = YES;
        _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
            NSLog(@"Animation Done");
            //_detailLabel.hidden = NO;
           
        });
         [self timeHiddenOrDispay:NO];
        [self requestFilm4DInfo:@"球幕影院"];
    }
    else if(sender.tag == 402){//4维影院
        _jumuImage.image = [UIImage imageNamed:@"cenima3_big"];
        _yinyuanLabel.text=@"影院";
        _detailLabel.hidden = YES;
        _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
            NSLog(@"Animation Done");
            //_detailLabel.hidden = NO;
        });
        [self timeHiddenOrDispay:NO];
        
        [self requestFilm4DInfo:@"四维影院"];
    }
    else if(sender.tag == 404){//太空影院
        _jumuImage.image = [UIImage imageNamed:@"cenima3_big"];
        _yinyuanLabel.text=@"影院";
        _detailLabel.hidden = YES;
        _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
            NSLog(@"Animation Done");
            //_detailLabel.hidden = NO;
        });
         [self timeHiddenOrDispay:NO];
        [self requestFilm4DInfo:@"太空影院"];
    }
    else if(sender.tag == 405){//巨幕影院
        _jumuImage.image = [UIImage imageNamed:@"cenima3_big"];
        _yinyuanLabel.text=@"影院";
        _detailLabel.hidden = YES;
        _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
            NSLog(@"Animation Done");
            //_detailLabel.hidden = NO;
        });
         [self timeHiddenOrDispay:NO];
        [self requestFilm4DInfo:@"巨幕影院"];
    }
    
    else if(sender.tag == 403){//教育活动
        _jumuImage.image = [UIImage imageNamed:@"cenima4_big"];
        _yinyuanLabel.text=@"活动";
        _detailLabel.hidden = YES;
        _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
            NSLog(@"Animation Done");
            //_detailLabel.hidden = NO;
        });
         [self timeHiddenOrDispay:NO];
        [self requestQiuInfo];
    }
    
}

- (IBAction)taikongClick:(id)sender {
    _jumuImage.image = [UIImage imageNamed:@"cenima2_big"];
}

- (IBAction)qiumuClick:(id)sender {
    _jumuImage.image = [UIImage imageNamed:@"cenima4_big"];
}

//- (IBAction)siweiClick:(id)sender {
//    _jumuImage.image = [UIImage imageNamed:@"cenima4_big"];
//}
- (IBAction)newsiweiClick:(id)sender {
    _jumuImage.image = [UIImage imageNamed:@"cenima3_big"];
    _yinyuanLabel.text=@"影院";
    _detailLabel.hidden = YES;
    _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
        NSLog(@"Animation Done");
        //_detailLabel.hidden = NO;
    });
     [self timeHiddenOrDispay:NO];
    [self requestFilm4DInfo:@"四维影院"];
}

//add  dsy 03-21
- (IBAction)newTaikongClick:(id)sender {
    _jumuImage.image = [UIImage imageNamed:@"cenima5_big"];
    _yinyuanLabel.text=@"影院";
    _detailLabel.hidden = YES;
    _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
        NSLog(@"Animation Done");
        //_detailLabel.hidden = NO;
    });
     [self timeHiddenOrDispay:NO];
    [self requestFilm4DInfo:@"太空影院"];
}

- (IBAction)newJuMuClick:(id)sender {
    _jumuImage.image = [UIImage imageNamed:@"cenima6_big"];
    _yinyuanLabel.text=@"影院";
    _detailLabel.hidden = YES;
    _yinyuanLabel.rotate(360).animateWithCompletion(0.5, JHAnimationCompletion(){
        NSLog(@"Animation Done");
        //_detailLabel.hidden = NO;
    });
     [self timeHiddenOrDispay:NO];
    
    [self requestFilm4DInfo:@"巨幕影院"];
}

#pragma mark - 右边点击进入详情
- (IBAction)movieBtn1Click:(id)sender {
    [self filmItemClick:0];}

- (IBAction)movieBtn2Click:(id)sender {
    [self filmItemClick:1];
}

- (IBAction)movieBtn3Click:(id)sender {
    [self filmItemClick:2];
}

-(void) filmItemClick:(NSInteger *)index {

    if([_rightType isEqualToString:@"linzhan"]){
        TemporaryDisplayData *item = [_linzhanArr objectAtIndex:index];
        ZhanPinVC *zpVc = (ZhanPinVC*)[StoryboardHelper getVCByVCName:@"zhanpinVC"];
        zpVc.type = _rightType;
        zpVc.lizhanItem = item;
        zpVc.needHiddenNavBar = @"Y";
        
        zpVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zpVc animated:YES];
    }
    if([_rightType isEqualToString:@"huodong"]){
        FilmItem *item = [_huodongArr objectAtIndex:index];
        ZhanPinVC *zpVc = (ZhanPinVC*)[StoryboardHelper getVCByVCName:@"zhanpinVC"];
        zpVc.type = _rightType;
        zpVc.needHiddenNavBar = @"Y";
        zpVc.huodongItem = item;
        zpVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zpVc animated:YES];
    }
    if([_rightType isEqualToString:@"siwei"]){
        SubFilmItem *item = [_siweiArr objectAtIndex:index];
        ZhanPinVC *zpVc = (ZhanPinVC*)[StoryboardHelper getVCByVCName:@"zhanpinVC"];
        zpVc.type = _rightType;
        zpVc.needHiddenNavBar = @"Y";
        zpVc.siweiItem = item;
        zpVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zpVc animated:YES];
    }
}

#pragma mark - 网络请求
//请求网络数据
-(void) requestLeftPagedata{
    
    DataRequest *request =[DataManager getInfoLeftMainPageWithUserId:@"11" mac:@"8888" callback:^(NSArray *rankItems, BOOL success) {
        //_leftItems = rankItems;
        _items = [rankItems copy];
        [_iCar reloadData];
    
    }];
    [request startAsynchronous];
}

//右边的请求数据 --教育活动
-(void) requestQiuInfo {
    [self threeBtnRest];
    NSString *today = [QyUtils TodayStrFromDate];
    NSDate *date = [QyUtils dateFromString:today foramtStr:@"yyyy-MM-dd"];
    DataRequest *r =[DataManager loadFilmsOrActivitysForType:OrderTypeActivity currentpage:1 countOfOnePage:3 date:date callback:^(NSArray *filmsOrActivitys, BOOL success) {
        //filmsOr--
        NSLog(@"result %@",filmsOrActivitys);
        
        //置参数®
        _rightType = @"huodong";
        _huodongArr = filmsOrActivitys;
        
        if([filmsOrActivitys count]==0){
//            _filpClockView.hidden = YES;
            [self timeHiddenOrDispay:YES];
        }
        if([filmsOrActivitys count]==1){
            BOOL flag = NO;
            FilmItem *item = [filmsOrActivitys objectAtIndex:0];
            NSString *str = [NSString stringWithFormat:@"%@-%@\n%@",item.beginTime,item.endTime,item.name];
            [_movieBtn1 setTitle: str forState: UIControlStateNormal];
            //比较时间，如果当前的时间比现在的时间晚，则是第一个
            NSString *thisDay = [NSString stringWithFormat:@"%@ %@",today,item.beginTime];
            NSDate *thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint1.hidden = NO;
                flag = YES;
            }
        }
        if([filmsOrActivitys count]==2){
            BOOL flag = NO;
            FilmItem *item = [filmsOrActivitys objectAtIndex:0];
            [_movieBtn1 setTitle: item.name forState: UIControlStateNormal];
            NSString *thisDay = [NSString stringWithFormat:@"%@ %@",today,item.beginTime];
            NSDate *thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint1.hidden = NO;
                flag = YES;
            }

            item = [filmsOrActivitys objectAtIndex:1];
            [_movieBtn2 setTitle: item.name forState: UIControlStateNormal];
            thisDay = [NSString stringWithFormat:@"%@ %@",today,item.beginTime];
            thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint2.hidden = NO;
                flag = YES;
            }

        }
        if([filmsOrActivitys count]>=3){
            BOOL flag = NO;
            FilmItem *item = [filmsOrActivitys objectAtIndex:0];
            [_movieBtn1 setTitle: item.name forState: UIControlStateNormal];
            NSString *thisDay = [NSString stringWithFormat:@"%@ %@",today,item.beginTime];
            NSDate *thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint1.hidden = NO;
                flag = YES;
            }

            item = [filmsOrActivitys objectAtIndex:1];
            [_movieBtn2 setTitle: item.name forState: UIControlStateNormal];
            thisDay = [NSString stringWithFormat:@"%@ %@",today,item.beginTime];
            thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint2.hidden = NO;
                flag = YES;
            }

            item = [filmsOrActivitys objectAtIndex:2];
            [_movieBtn3 setTitle: item.name forState: UIControlStateNormal];
            thisDay = [NSString stringWithFormat:@"%@ %@",today,item.beginTime];
            thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint3.hidden = NO;
                flag = YES;
            }

        }
        
    }];
    
    [r startAsynchronous];
}

-(void) requestLinZhanInfo {

    [self threeBtnRest];
    DataRequest *r =[QyDataManger getLinZhanInfoWithStartdate:@"" callback:^(TemporaryDisplay *bigitem, BOOL success) {
        
        
        NSArray *data = bigitem.dataList;

        
        //置参数
        _rightType = @"linzhan";
        _linzhanArr = data;

        
        if([data count]==0){
            
        }
        if([data count]==1){
             TemporaryDisplayData *item = [data objectAtIndex:0];
//            NSString *str = [NSString stringWithFormat:@"%@-%@\n%@",item.beginTime,item.endTime,item.name];
            NSString *str = [NSString stringWithFormat:@"%@",item.name];
            [_movieBtn1 setTitle: str forState: UIControlStateNormal];
        }
        if([data count]==2){
            TemporaryDisplayData *item = [data objectAtIndex:0];
            [_movieBtn1 setTitle: item.name forState: UIControlStateNormal];
            item = [data objectAtIndex:1];
            [_movieBtn2 setTitle: item.name forState: UIControlStateNormal];
        }
        if([data count]>=3){
            TemporaryDisplayData *item = [data objectAtIndex:0];
            [_movieBtn1 setTitle: item.name forState: UIControlStateNormal];
            item = [data objectAtIndex:1];
            [_movieBtn2 setTitle: item.name forState: UIControlStateNormal];
            item = [data objectAtIndex:2];
            [_movieBtn3 setTitle: item.name forState: UIControlStateNormal];
        }
        
    }];
    
    [r startAsynchronous];
}


-(void) requestFilm4DInfo:(NSString *) yytype {
    [self threeBtnRest];
    NSString *today = [QyUtils TodayStrFromDate];
    DataRequest *r =[QyDataManger getCenima4DInfoWithStartdate:today endDate:today callback:^(NSArray *arr, BOOL success)  {
        NewFilm4DItem *film = nil;
        for (NewFilm4DItem *tfilm in arr) {
            if([yytype isEqualToString:tfilm.name]){
                film = tfilm;
            }
        }
        if(film==nil){
            return;
        }
        
        NSArray *data = film.filmList;
        
        //置参数
        _rightType = @"siwei";
        _siweiArr = data;
        
        if([data count]==0){
            //距离放映时间关闭
            _filpClockView.hidden = YES;
        }
        if([data count]==1){
             BOOL flag = NO;
            SubFilmItem *item = [data objectAtIndex:0];
            //            NSString *str = [NSString stringWithFormat:@"%@-%@\n%@",item.beginTime,item.endTime,item.name];
            NSString *str = [NSString stringWithFormat:@"%@ %@",item.scheduleTime,item.name];
            [_movieBtn1 setTitle: str forState: UIControlStateNormal];
            NSString *thisDay = [NSString stringWithFormat:@"%@ %@",today,item.scheduleTime];
            NSDate *thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint1.hidden = NO;
                flag = YES;
            }
        }
        if([data count]==2){
             BOOL flag = NO;
            SubFilmItem *item = [data objectAtIndex:0];
            NSString *str = [NSString stringWithFormat:@"%@ %@",item.scheduleTime,item.name];
            [_movieBtn1 setTitle: str forState: UIControlStateNormal];
            NSString *thisDay = [NSString stringWithFormat:@"%@ %@",today,item.scheduleTime];
            NSDate *thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint1.hidden = NO;
                flag = YES;
            }

            item = [data objectAtIndex:1];
            str = [NSString stringWithFormat:@"%@ %@",item.scheduleTime,item.name];
            [_movieBtn2 setTitle: str forState: UIControlStateNormal];
            thisDay = [NSString stringWithFormat:@"%@ %@",today,item.scheduleTime];
            thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint2.hidden = NO;
                flag = YES;
            }

        }
        if([data count]>=3){
            BOOL flag = NO;
            SubFilmItem *item = [data objectAtIndex:0];
            NSString *str = [NSString stringWithFormat:@"%@ %@",item.scheduleTime,item.name];
            [_movieBtn1 setTitle: str forState: UIControlStateNormal];
            NSString *thisDay = [NSString stringWithFormat:@"%@ %@",today,item.scheduleTime];
            NSDate *thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint1.hidden = NO;
                flag = YES;
            }
            
            item = [data objectAtIndex:1];
            str = [NSString stringWithFormat:@"%@ %@",item.scheduleTime,item.name];
            [_movieBtn2 setTitle: str forState: UIControlStateNormal];
            
            thisDay = [NSString stringWithFormat:@"%@ %@",today,item.scheduleTime];
            thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint2.hidden = NO;
                flag = YES;
            }
            
            item = [data objectAtIndex:2];
            str = [NSString stringWithFormat:@"%@ %@",item.scheduleTime,item.name];
            [_movieBtn3 setTitle: str forState: UIControlStateNormal];
            thisDay = [NSString stringWithFormat:@"%@ %@",today,item.scheduleTime];
            thisTime = [QyUtils dateFromString:thisDay foramtStr:@"yyyy-MM-dd HH:mm"];
            interval = [thisTime timeIntervalSinceNow];
            if(interval>0&&flag==NO){
                _filpClockView.targetDate = thisTime;
                _redPoint3.hidden = NO;
                flag = YES;
            }
        }
        
    }];
    
    [r startAsynchronous];
}

-(void) threeBtnRest{
    [_movieBtn1 setTitle:@"" forState:UIControlStateNormal];
    [_movieBtn2 setTitle:@"" forState:UIControlStateNormal];
    [_movieBtn3 setTitle:@"" forState:UIControlStateNormal];
}


//键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_searchTextField endEditing:YES];
    [autoCompleteTextField.suggestionTextField endEditing:YES];
}

#pragma mark - 点击地图
- (IBAction)mapClickBtn:(id)sender {
    MapVCViewController *mapVc = (MapVCViewController*)[StoryboardHelper getVCByVCName:@"mapVC"];
    mapVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapVc animated:YES];

}
//点击随手拍按钮
-(void)photoBtnClick{
    MapVCViewController *vc = (MapVCViewController*)[StoryboardHelper getVCByVCName:@"uploadPhotoVC"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //处理LaunchScreen，可以在这里面加时间延迟和动画。
    //https://github.com/k06a/LaunchScreenViewController
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self performSegueWithIdentifier:@"new_segue_screensaver" sender:nil];

//                        [self performSegueWithIdentifier:@"segue_survey_home" sender:nil];

    });
    
//    static dispatch_once_t onceToken1;
//    dispatch_once(&onceToken1, ^{
//        [self performSegueWithIdentifier:@"segue_survey_home" sender:nil];
//    });
}


- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{

    CGFloat line = 200;
    
    if(carousel.frame.origin.x<line){//根据位置来判断属于哪一个carousel

        return [self.items count];
        
    }
    else{
        return [self.cenimalItems count];
    }
   
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
  if ([carousel isEqual:self.iCar]) {
    UILabel *label = nil;

    // create new view if no view is available for recycling
    if (view == nil) {
      // don't do anything specific to the index within
      // this `if (view == nil) {...}` statement because the view will be
      // recycled and used with other index values later
     
        
        if([_items[index] isKindOfClass:[InterestLabelItem class]]){
            NSString *imageName1 =
            [NSString stringWithFormat:@"%@%@", kServerAddress,((InterestLabelItem *)_items[index]).icon];
            imageName1 = [imageName1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            view =
            [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 144.0f, 194.4f)];
            [((UIImageView *)view) sd_setImageWithURL:[NSURL URLWithString:imageName1]];
        }
        else{
            NSString *imageName =
            [NSString stringWithFormat:@"home_flow%ld", (long)index + 1];
            view =
            [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 144.0f, 194.4f)];
            ((UIImageView *)view).image = [UIImage imageNamed:imageName];
        }
    
      
        
      //view.contentMode = UIViewContentModeCenter;
      //view.backgroundColor = [UIColor yellowColor];
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

    // set item label
    // remember to always set any properties of your carousel item
    // views outside of the `if (view == nil) {...}` check otherwise
    // you'll get weird issues with carousel item content appearing
    // in the wrong place in the carousel

    // label.text = [_items[index] stringValue];//在每张图片上设置label内容

    return view;
  }

    else {
        UILabel *label = nil;
        
        // create new view if no view is available for recycling
        if (view == nil) {
            // don't do anything specific to the index within
            // this `if (view == nil) {...}` statement because the view will be
            // recycled and used with other index values later
            NSString *imageName =
            [NSString stringWithFormat:@"cenima%ld", (long)index + 1];
            view =
            [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50.0f, 50.0f)];
            ((UIImageView *)view).image = [UIImage imageNamed:imageName];
//            view.backgroundColor = [UIColor redColor];
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
        
        // set item label
        // remember to always set any properties of your carousel item
        // views outside of the `if (view == nil) {...}` check otherwise
        // you'll get weird issues with carousel item content appearing
        // in the wrong place in the carousel
        
        // label.text = [_items[index] stringValue];//在每张图片上设置label内容
        
        return view;
    }
    
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if([carousel isEqual:self.iCar]){
        NSLog(@"iCar index is %li",(long)index);
        //到详情页面
        
        if([_items[index] isKindOfClass:[InterestLabelItem class]]){
            //如果选中了其中一个item;
            InterestLabelItem *labelItem = _items[index];
            NSLog(@"InterestLabelItem entityId=%@",labelItem.entityId);
            if([labelItem.type isEqualToString:@"0"]){//展区
                //跳转到
                ZhanQuDetailVC *zpVc = (ZhanQuDetailVC*)[StoryboardHelper getVCByVCName:@"zhanQuDetailVC"];
                zpVc.selectItem = labelItem;
                zpVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zpVc animated:YES];
            }
            if([labelItem.type isEqualToString:@"1"]){//电影
               //跳转到电影
                FilmDetailVC *zpVc = (FilmDetailVC*)[StoryboardHelper getVCByVCName:@"filmDetailVC"];
                zpVc.selectItem = labelItem;
                zpVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zpVc animated:YES];
            }
            if([labelItem.type isEqualToString:@"2"]){//活动
                //跳转到
                HuoDongDetailVC *zpVc = (HuoDongDetailVC*)[StoryboardHelper getVCByVCName:@"huoDongDetailVC"];
                zpVc.selectItem = labelItem;
                zpVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zpVc animated:YES];
            }
            if([labelItem.type isEqualToString:@"3"]){//展品
                //跳转到
                
                NewZhanPinDetailVC *zpVc = (NewZhanPinDetailVC*)[StoryboardHelper getVCByVCName:@"newZhanPinDetailVC"];
                zpVc.selectItem = labelItem;
                zpVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zpVc animated:YES];
            }
            
            if([labelItem.type isEqualToString:@"4"]){//临展
                //跳转到
                LinZhanDetailVC *zpVc = (LinZhanDetailVC*)[StoryboardHelper getVCByVCName:@"linZhanDetailVC"];
                zpVc.selectItem = labelItem;
                zpVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zpVc animated:YES];
            }
        }
        
        
//        ZhanPinVC *zpVc = (ZhanPinVC*)[StoryboardHelper getVCByVCName:@"zhanpinVC"];
//        InterestLabelItem *sele = _items[index];//选中的项目
//        zpVc.selectItem = _items[index];
//        zpVc.type = @"left";
//        zpVc.needHiddenNavBar = @"Y";
//        zpVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:zpVc animated:YES];
    }
    else{
        NSLog(@"iCenimal index is %li",(long)index);
    }
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    const CGFloat offsetFactor = [self carousel:carousel valueForOption:iCarouselOptionSpacing withDefault:1.0f]*carousel.itemWidth;
    
    //The larger these values, as the items move away from the center ...
    
    //... the faster they move to the back
    const CGFloat zFactor = 150.0f;
    
    //... the faster they move to the bottom of the screen
    const CGFloat normalFactor = 40.0f;
    
    //... the faster they shrink
    const CGFloat shrinkFactor = 3.0f;
    
    //hyperbola
    CGFloat f = sqrtf(offset*offset+1)-1;
    
    transform = CATransform3DTranslate(transform, -f*normalFactor*3,offset*offsetFactor, f*(-zFactor));
    transform = CATransform3DScale(transform, 1/(f/shrinkFactor+1.0f)*1.1, 1/(f/shrinkFactor+1.0f)*1.1, 1.0);
    return transform;
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if([carousel isEqual:self.iCar]){
        if (option == iCarouselOptionSpacing)
        {
            return value*0.8;
        }
        if(option == iCarouselOptionVisibleItems){
            return 5;
        }
        if(option == iCarouselOptionCount){
            return 5;
        }
        
        if(option == iCarouselOptionOffsetMultiplier){
            return value *0.8;
        }

        if(option == iCarouselOptionRadius){//半径
            return value;
        }
        if (option == iCarouselOptionWrap) {
          return YES;
        }
        if(option == iCarouselOptionFadeMax){
            return 0.43f;
        }
        if(option == iCarouselOptionFadeMin){
            return -0.43f;
        }
        if(option == iCarouselOptionFadeRange){
            return 2.5f;
        }
        
        return value;
        
        
        
    }
    else{
        if(option == iCarouselOptionRadius){//半径
            return value * 4.5;
        }
        if(option == iCarouselOptionArc){
            return value * 0.5;
        }
        if(option == iCarouselOptionOffsetMultiplier){
            return value *0.8;
        }
        return value;
    }
    
}

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel{
//    NSLog(@"carouselWillBeginScrollingAnimation");
    
}
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
//    NSLog(@"carouselDidEndScrollingAnimation");
}

#pragma mark - 搜索相关

#pragma mark - NHAutoComplete DataSource delegate functions

- (NSInteger)autoCompleteTextBox:(NHAutoCompleteTextField *)autoCompleteTextBox numberOfRowsInSection:(NSInteger)section
{
    return [inUseDataSource count];
}

- (UITableViewCell *)autoCompleteTextBox:(NHAutoCompleteTextField *)autoCompleteTextBox cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [autoCompleteTextBox.suggestionListView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    // Create cell, you can use the most recent way to create a cell.
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
        [cell.textLabel setFont:[UIFont fontWithName:cell.textLabel.font.fontName size:13.5f]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:cell.detailTextLabel.font.fontName size:11.0f]];
        
        //[cell.textLabel setTextColor:[UIColor brownColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        //[cell.detailTextLabel setTextColor:[UIColor grayColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
    }
    
    // Set text
    [cell.textLabel setText:[inUseDataSource[indexPath.row] objectForKey:@"CountryName"]];
    [cell.detailTextLabel setText:[inUseDataSource[indexPath.row] objectForKey:@"Capital"]];
    
    // Clear previously highlighted text
    [cell.textLabel normalizeSubstring:cell.textLabel.text];
    [cell.detailTextLabel normalizeSubstring:cell.detailTextLabel.text];
    
    // Highlight the selection
    if(autoCompleteTextBox.filterString)
    {
        [cell.textLabel boldSubstring:autoCompleteTextBox.filterString];
        [cell.detailTextLabel boldSubstring:autoCompleteTextBox.filterString];
    }
    
    //cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - NHAutoComplete Filter data source delegate functions

-(BOOL)shouldFilterDataSource:(NHAutoCompleteTextField *)autoCompleteTextBox
{
    return YES;
}

-(void)autoCompleteTextBox:(NHAutoCompleteTextField *)autoCompleteTextBox didFilterSourceUsingText:(NSString *)text
{
    if ([text length] == 0)
    {
        inUseDataSource = [[manager dataSource] mutableCopy];
        return;
    }
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", @"CountryName", text];
    NSPredicate *predCapital = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", @"Capital", text];
    
    // Want to look the matches in both country name and capital
    NSCompoundPredicate *compoundPred = [[NSCompoundPredicate alloc] initWithType:NSOrPredicateType subpredicates:[NSArray arrayWithObjects:predCountry, predCapital, nil]];
    
    NSArray *filteredArr = [[manager dataSource] filteredArrayUsingPredicate:compoundPred];
    inUseDataSource = filteredArr;
}

-(void)startSearchWithString:(NSString *)text{
    NSLog(@"start search with String=%@",text);
    SearchResultVC *searchResultVC = (SearchResultVC*)[StoryboardHelper getVCByVCName:@"searchResultVC"];
    searchResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}

-(void) timeHiddenOrDispay:(BOOL)hidden {
//    _imageHour0.hidden = hidden;
//    _imageHour1.hidden = hidden;
//    _imageHour2.hidden = hidden;
//    _imageHour5.hidden = hidden;
//    _flipNumberView.hidden = hidden;
    _julifangyinLabel.hidden =hidden;
    _filpClockView.hidden = hidden;
    if(hidden==YES){
        _redPoint1.hidden = hidden;
        _redPoint2.hidden = hidden;
        _redPoint3.hidden = hidden;
    }
    
}

@end
