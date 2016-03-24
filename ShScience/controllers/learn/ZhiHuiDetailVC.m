//
//  ZhiHuiDetailVC.m
//  ShScience
//
//  Created by qiya on 16/3/1第10周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ZhiHuiDetailVC.h"

@interface ZhiHuiDetailVC ()
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@property (weak, nonatomic) IBOutlet UIImageView *blackArrow;
@property (weak, nonatomic) IBOutlet UIImageView *redArrow;
@property (weak, nonatomic) IBOutlet UIImageView *yellowArrowView;
@property (weak, nonatomic) IBOutlet UIImageView *blueArrow;



@property (weak, nonatomic) IBOutlet UILabel *yellowArrow;
@property (weak, nonatomic) IBOutlet UILabel *bluelabel;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *blackLabel;




@end

@implementation ZhiHuiDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitleNoHidden:@"智慧树"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{ //根据程序调整布局
    CGRect blackframe= _blackView.frame;
    blackframe.size.width = 50;
    _blackView.frame = blackframe;
    
    CGRect blackArrowFrame = _blackArrow.frame;
    blackArrowFrame.origin.x = blackframe.size.width+blackframe.origin.x;
    _blackArrow.frame = blackArrowFrame;

    CGRect blackLabelFrame = _blackLabel.frame;
    blackLabelFrame.origin.x = blackArrowFrame.origin.x+30;
    _blackLabel.frame = blackLabelFrame;

}

-(void)viewDidAppear:(BOOL)animated{
    
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
