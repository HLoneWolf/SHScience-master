//
//  MoreVC.m
//  ShScience
//
//  Created by qiya on 16/1/2第1周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "MoreVC.h"
#import "SurveryVC.h"
#import "StoryboardHelper.h"
#import "RecommandMapVC.h"
#import "ViewController.h"
#import "LeftAnimationVCViewController.h"
#import "AnimationVCViewController.h"
#import "LoginVC.h"
#import "ZhanQuListVC.h"
#import "LearnVC.h"
#import "ZhiHuiTreeVC.h"
#import "HelpVC.h"
#import "RadioVC.h"
#import "BuyTicketVC.h"
#import "ShopVC.h"
#import "BigZhanQuVC.h"
#import "AnswerVC.h"
#import "JiaoLiuFenXiangVC.h"
#import "ZhanXiangHudongVC.h"

#define WIDTH 70
#define HEIGHT 90.7
#define PADDING 15
#define NUMBEROFBUTTONSINAROW 4
#define X 20
#define Y 100
#define TOTALBUTTONS 9



@interface MoreVC()

@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,readwrite)int animationCounter;
@property(nonatomic,strong)UIScrollView *scrollview;

@end

@implementation MoreVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    
    self.animationCounter=0;
    
    [self createScrollView];
    
    [self createButton];
    
    [self animateButtons];
}


-(void)animateButtons
{
    
    if (self.animationCounter < TOTALBUTTONS) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             ((UIButton *)[self.array objectAtIndex:self.animationCounter]).alpha = 1.0;
                         } completion:^(BOOL finished) {
                             self.animationCounter++;
                             [self animateButtons];
                             
                         }];
    }
}

-(void)createScrollView{
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//  self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height*2)+100);
    self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+100);
    
}


-(void)createButton{
    
    self.array = [[NSMutableArray alloc] init];
    
    for(int i=0 ; i<TOTALBUTTONS;i++)
    {
        UIButton *buttonClick = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonClick setImage:[UIImage imageNamed:[NSString stringWithFormat:@"more_btn_%d",i]] forState:UIControlStateNormal];
        [buttonClick setFrame:CGRectMake(X+((WIDTH + PADDING) * (i%NUMBEROFBUTTONSINAROW)), Y + (HEIGHT + PADDING)*(i/NUMBEROFBUTTONSINAROW), WIDTH, HEIGHT)];
        //buttonClick.backgroundColor = [UIColor redColor];
        [buttonClick addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        buttonClick.tag=i + 1;
        [buttonClick setAlpha:0.0];
        [self.array addObject:buttonClick];
        [self.scrollview addSubview:buttonClick];
        
    }
    
    [self.view addSubview:self.scrollview];
    
}
-(void)buttonTapped:(id)sender
{
    
    NSLog(@"Button Clicked %ld",(long)((UIButton *)sender).tag);
    long tag = (long)((UIButton *)sender).tag;
    if(tag==1){//触发 语音导览
        RadioVC *vc = (RadioVC *)[StoryboardHelper getVCByVCName:@"radioVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
//        SurveryVC *surveyVC = (SurveryVC *)[StoryboardHelper getVCByVCName:@"surveyVC"];
//        surveyVC.needBack = @"Y";
//        surveyVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:surveyVC animated:YES];
    }
    if(tag==2){//做动画效果 展区
        BigZhanQuVC *viewController = (BigZhanQuVC *)[StoryboardHelper getVCByVCName:@"bigZhanQuVC"];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];

        //AnimationVCViewController *viewController = (AnimationVCViewController *)[StoryboardHelper getVCByVCName:@"animationVC"];
        //viewController.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:viewController animated:YES];
    }
    
    if(tag==3){//首页翻转动画效果 展区互动
        ZhanXiangHudongVC *vc = (ZhanXiangHudongVC *)[StoryboardHelper getVCByVCName:@"zhanXiangHudongVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if(tag==4){//科技智慧树
        ZhiHuiTreeVC *vc = (ZhiHuiTreeVC *)[StoryboardHelper getVCByVCName:@"zhiHuiTreeVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if(tag==5){//学习清单
        LearnVC *viewController = (LearnVC *)[StoryboardHelper getVCByVCName:@"learnVC"];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
//        AnswerVC *vc = (AnswerVC *)[StoryboardHelper getVCByVCName:@"answerVC"];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if(tag==6){//帮助
        HelpVC *vc = (HelpVC *)[StoryboardHelper getVCByVCName:@"helpVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    if(tag==7){
        //分享交流
        JiaoLiuFenXiangVC *vc = (JiaoLiuFenXiangVC *)[StoryboardHelper getVCByVCName:@"jiaoLiuFenXiangVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if(tag==8){//地图上的闪动光标
//        RecommandMapVC *recVC = (RecommandMapVC *)[StoryboardHelper getVCByVCName:@"recommandMapVC"];
//        recVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:recVC animated:YES];
        BuyTicketVC *vc = (BuyTicketVC *)[StoryboardHelper getVCByVCName:@"buyTicketVC"];
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(tag==9){//功能展示页面
//        ViewController *viewController = (ViewController *)[StoryboardHelper getVCByVCName:@"viewController"];
//        viewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:viewController animated:YES];
//        LoginVC *loginVC = (LoginVC *)[StoryboardHelper getVCByVCName:@"loginVC"];
//        loginVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVC animated:YES];
        ShopVC *vc = (ShopVC *)[StoryboardHelper getVCByVCName:@"shopVC"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
