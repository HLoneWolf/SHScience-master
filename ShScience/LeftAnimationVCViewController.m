//
//  LeftAnimationVCViewController.m
//  ShScience
//
//  Created by qiya on 16/1/7第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//



#import "LeftAnimationVCViewController.h"
#import "QyUtils.h"
#import "UINavigationBar+Awesome.h"


#define PHOTONUM 5
NSInteger array1 [PHOTONUM][PHOTONUM] = {
    {0,1,2,3,4},
    {4,0,1,2,3},
    {3,4,0,1,2},
    {2,3,4,0,1},
    {1,2,3,4,0}
};

@interface LeftAnimationVCViewController ()

@property (weak, nonatomic) IBOutlet iCarousel *iCar;
@property (nonatomic, strong) NSMutableArray *items;

@property NSMutableArray *positionSize;

@property NSMutableArray *alignType;

@property NSInteger oldIndex;
@property NSInteger curIndex;



@end

@implementation LeftAnimationVCViewController



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
    _positionSize = [NSMutableArray array];
    CGRect cgrect1=CGRectMake(0,200,150,200);
    CGRect cgrect2=CGRectMake(500,100,200,140);
    CGRect cgrect3=CGRectMake(0,300,400,600);
    CGRect cgrect4=CGRectMake(0,400,400,600);
    CGRect cgrect5=CGRectMake(0,0,200,200);
    [_positionSize addObject:[NSValue valueWithCGRect:cgrect1]];
    [_positionSize addObject:[NSValue valueWithCGRect:cgrect2]];
    [_positionSize addObject:[NSValue valueWithCGRect:cgrect3]];
    [_positionSize addObject:[NSValue valueWithCGRect:cgrect4]];
    [_positionSize addObject:[NSValue valueWithCGRect:cgrect5]];
    
    _alignType = [NSMutableArray array];
    [_alignType addObject:@"UIViewContentModeRight"];//UIViewContentModeRight;
    [_alignType addObject:@"UIViewContentModeRight"];//UIViewContentModeRight;
    [_alignType addObject:@"UIViewContentModeBottomLeft"];//UIViewContentModeBottomLeft
    [_alignType addObject:@"UIViewContentModeTopLeft"];//UIViewContentModeTopLeft
    [_alignType addObject:@"UIViewContentModeRight"];//UIViewContentModeRight;
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.iCar.type = iCarouselTypeRotary;
    //self.iCar.type = iCarouselTypeCoverFlow2;
    self.iCar.vertical = YES;
//    /_iCar.backgroundColor = [UIColor yellowColor];
    //_iCar.backgroundColor = [UIColor clearColor];
    self.iCar.dataSource = self;
    self.iCar.delegate = self;
    self.iCar.scrollSpeed = 0.8;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
  return [self.items count];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if([carousel isEqual:self.iCar]){
        NSLog(@"iCar index is %li",(long)index);
    }
    else{
        NSLog(@"iCenimal index is %li",(long)index);
    }
}

//- (UIView *)carousel:(iCarousel *)carousel
//  viewForItemAtIndex:(NSInteger)index
//         reusingView:(UIView *)view {
//  UILabel *label = nil;
//  // create new view if no view is available for recycling
//  if (view == nil) {
//    // don't do anything specific to the index within
//    // this `if (view == nil) {...}` statement because the view will be
//    // recycled and used with other index values later
//    NSString *imageName =
//        [NSString stringWithFormat:@"home_flow%ld", (long)index + 1];
//
//    NSLog(@"imageName=%@,%ld", imageName, index);
//
//    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 147.7f, 200.0f)];
//    ((UIImageView *)view).image = [UIImage imageNamed:imageName];
//
//    view.contentMode = UIViewContentModeCenter;
//    //     view.backgroundColor = [UIColor yellowColor];
//    view.contentMode = UIViewContentModeScaleToFill;
//
//    label = [[UILabel alloc] initWithFrame:view.bounds];
//    label.backgroundColor = [UIColor clearColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [label.font fontWithSize:50];
//    label.tag = 1;
//    [view addSubview:label];
//  } else {
//    // get a reference to the label in the recycled view
//    label = (UILabel *)[view viewWithTag:1];
//  }
//  return view;
//}

- (CGFloat)carousel:(iCarousel *)carousel
     valueForOption:(iCarouselOption)option
        withDefault:(CGFloat)value {

//  if (option == iCarouselOptionSpacing) {
//    return value * 1.2;
//  }
//  if (option == iCarouselOptionVisibleItems) {
//    NSLog(@"%@ iCarouselOptionVisibleItems", self.iCar);
//    return 5;
//  }
//  if (option == iCarouselOptionCount) {
//    return 5;
//  }
//
//  if (option == iCarouselOptionOffsetMultiplier) {
//    return value * 0.8;
//  }
//
//  if (option == iCarouselOptionRadius) { //半径
//    return value * 1.7;
//  }

  return value;
}



#pragma mark - iCarousel代理
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
//    if (view == nil) {
//        CGFloat viewWidth = ScreenWidth - 2*PAGE_OFFSET;
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
//    }
//    
//    ((UIImageView *)view).image = [UIImage imageNamed:[self.dataList objectAtIndex:index]];
    UILabel *label = nil;
    NSString *imageName =
    [NSString stringWithFormat:@"home_flow%ld", (long)index + 1];
    
    NSLog(@"imageName=%@,%ld", imageName, index);
    //view = [UIImageView alloc];
    view = [[UIImageView alloc] initWithFrame:[[_positionSize objectAtIndex:index] CGRectValue]];
    //NSLog(@"%ld,%d,%f,%ld",50*index, 0, 147.7f, 200+20*index);
    ((UIImageView *)view).image = [UIImage imageNamed:imageName];
//    /view.backgroundColor = [UIColor redColor];
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
    label.text = [NSString stringWithFormat:@"%ld",(long)index];
        [view addSubview:label];

    //view.contentMode = UIViewContentModeCenter;
         //view.backgroundColor = [UIColor blueColor];
    //view.contentMode = UIViewContentModeScaleToFill;
    
    if(index==0){
        view.contentMode = UIViewContentModeRight;
    }
    else if(index ==2){
        view.contentMode = UIViewContentModeBottomLeft;
    }
    else if(index==3) {
        view.contentMode = UIViewContentModeTopLeft;
    }
    else{
        view.contentMode = UIViewContentModeLeft;
    }
    
    return view;
}

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel{
    //开始
    NSLog(@"carouselWillBeginScrollingAnimation,%ld",_iCar.currentItemIndex);
//    _curIndex = _iCar.currentItemIndex;
//    if(_curIndex==0){
//        return ;
//    }
//    NSLog(@"_curIndex===%ld", (long)_curIndex);
//    //_iCar itemViewAtIndex:<#(NSInteger)#>;
//    for(int i = 0;i<5;i++)
//    {
//        NSInteger j = array1[_curIndex][i];
//        [_iCar itemViewAtIndex:j].frame = [[_positionSize objectAtIndex:i] CGRectValue];
//        
//    }
    //NSInteger a[5] = array[_curIndex];

}


- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    NSLog(@"carouselDidEndScrollingAnimation,%ld",_iCar.currentItemIndex);
    //调整图片位置
    //_iCar.currentItemView.backgroundColor = [UIColor redColor];
    //结束
    }

- (void)carouselDidScroll:(iCarousel *)carousel{
    //NSLog(@"carouselDidScroll");
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    NSLog(@"carouselWillBeginDragging-%ld",_iCar.currentItemIndex);
    _oldIndex = _iCar.currentItemIndex;
    
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
    NSLog(@"carouselDidEndDragging");
}

- (void)carouselWillBeginDecelerating:(iCarousel *)carousel{
    NSLog(@"carouselWillBeginDecelerating");
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel{
    NSLog(@"carouselDidEndDecelerating");
}


//-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset
//
//    //
//    //    const CGFloat offsetFactor = [self carousel:carousel valueForOption:iCarouselOptionSpacing withDefault:1.0f]*carousel.itemWidth;
//    //    NSLog(@"offsetFactor=%f,%f,%f",offsetFactor,offset,offset*offsetFactor);
//    //    transform = CATransform3DTranslate(transform, offset*offsetFactor, 0, 0);
//    //    return transform;
//}

@end
