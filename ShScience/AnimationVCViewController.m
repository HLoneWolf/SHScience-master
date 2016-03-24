//
//  AnimationVCViewController.m
//  ShScience
//
//  Created by qiya on 16/1/5第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "AnimationVCViewController.h"
#import "JHChainableAnimations.h"
#import "UINavigationBar+Awesome.h"
#import "QyUtils.h"


const CGFloat circle_x = 290.0;//原点位置
const CGFloat circle_y = 320.0;
const CGFloat circle_radius = 200;//半径

const CGFloat pic_size = 76;
const CGFloat half_pic_size = 38;

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface AnimationVCViewController ()


@property UIImageView * image1;
@property UIImageView * image2;
@property UIImageView * image3;
@property UIImageView * image4;
//@property UIImageView * image5;

@end

@implementation AnimationVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _image1 = [[UIImageView alloc]init];
    _image1.image = [UIImage imageNamed:@"cenima1"];
    _image1.frame = CGRectMake(150, 190, pic_size, pic_size);
    
//    _image5 = [[UIImageView alloc]init];
//    _image5.image = [UIImage imageNamed:@"cenima1"];
//    _image5.frame = CGRectMake(130, 430, half_pic_size, half_pic_size);//135度
    
    _image2 = [[UIImageView alloc]init];
    _image2.image = [UIImage imageNamed:@"cenima2"];
    _image2.frame = CGRectMake(170, 470, half_pic_size, half_pic_size);//120度
    
    _image3 = [[UIImageView alloc]init];
    _image3.image = [UIImage imageNamed:@"cenima3"];
    _image3.frame = CGRectMake(210, 500, half_pic_size, half_pic_size);//105度
    
    _image4 = [[UIImageView alloc]init];
    _image4.image = [UIImage imageNamed:@"cenima4"];
    _image4.frame = CGRectMake(250, 530, half_pic_size, half_pic_size);//95度
    
    [self.view addSubview:_image1];
    [self.view addSubview:_image2];
    [self.view addSubview:_image3];
    [self.view addSubview:_image4];
    //[self.view addSubview:_image5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
    UIBezierPath *path = [_image1 bezierPathForAnimation];
    
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circle_x, circle_y)
                                          radius:circle_radius
                                      startAngle:DEGREES_TO_RADIANS(250)
                                        endAngle:DEGREES_TO_RADIANS(135)
                                       clockwise:NO];
    _image1.moveOnPath(path).makeScale(0.5).animate(1.5);
    //path = [UIBezierPath bezierPathWithOvalInRect:[self getCircleRect]];
    //_iv.moveOnPath(path).thenAfter(2).moveX(-200).animate(0.5);
    //.thenAfter(0.5).moveXY(100,200).animate(1);

}

- (IBAction)upMoveAnimationBtn:(id)sender {
    UIBezierPath *path = [_image1 bezierPathForAnimation];
    
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circle_x, circle_y)
                                          radius:circle_radius
                                      startAngle:DEGREES_TO_RADIANS(135)
                                        endAngle:DEGREES_TO_RADIANS(250)
                                       clockwise:YES];
    _image1.moveOnPath(path).makeScale(2).animate(1.5);
}

- (CGRect)getCircleRect {
    
  CGFloat leftTopPoint_x = circle_x - circle_radius;
  CGFloat leftTopPoint_y = circle_y - circle_radius;
  CGFloat rectLength = 2 * circle_radius;
    NSLog(@"%f %f %f ",leftTopPoint_x,leftTopPoint_y,rectLength);
  return CGRectMake(leftTopPoint_x, leftTopPoint_y, rectLength, rectLength);
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;//打开顶部Tab
    //self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[QyUtils colorWithRed:1 green:78 blue:146]];//1 78 146
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//导航字体颜色
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    [self.navigationController.navigationBar lt_reset];
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
