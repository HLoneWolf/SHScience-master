//
//  SKIndoorMapView.m
//  IndoorMapDemo
//
//  Created by silverk on 14-8-3.
//  Copyright (c) 2014年 silverk. All rights reserved.
//

#import "SKIndoorMapView.h"
#import "SKIndoorMapTransfer.h"
#import "QyUtils.h"
#import "ZhanPinVC.h"
#import "StoryboardHelper.h"
#import "InfoItem.h"

@implementation SKIndoorMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(id)initWithIndoorMapImageName:(NSString*)indoorMap Frame:(CGRect)frame Type:(NSString *) type;
{
    if (self=[super init]) {
        
        self.bounces = NO;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.frame = frame;
        
        UIImage *map = [UIImage imageNamed:indoorMap];
        NSLog(@"map.size.width=%f and map.size.height=%f",map.size.width,map.size.height);
        _mapView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, map.size.width, map.size.height)];
        //_mapView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWitdh, ScreenHeight)];
        _mapView.contentMode = UIViewContentModeScaleAspectFit;
        _mapView.image=map;
        _mapView.userInteractionEnabled = YES;
        [self addSubview:_mapView];
        
        //双击
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [_mapView addGestureRecognizer:doubleTapGesture];
        
        //CGFloat minScale = self.frame.size.width/_mapView.frame.size.width;
        //CGFloat minScale = self.frame.size.width/_mapView.frame.size.width;
        CGFloat minScale = self.frame.size.height/_mapView.frame.size.height;
        [self setMinimumZoomScale:0.1];
        [self setZoomScale:minScale];
   
        //开始标注地图
        //660.66666158040368, 455
        UIImage *img = [UIImage imageNamed:@"mark_at_map"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
        imageView.frame = CGRectMake(640, 425, 45, 50);
        
        if([@"3" isEqualToString:type]){//公共设施
            UIImage *img1 = [UIImage imageNamed:@"fac1"];
            UIImageView *imageView1 = [[UIImageView alloc] initWithImage:img1];
            imageView1.frame = CGRectMake(700, 245, 45, 50);
            
            UIImage *img2 = [UIImage imageNamed:@"fac2"];
            UIImageView *imageView2 = [[UIImageView alloc] initWithImage:img2];
            imageView2.frame = CGRectMake(800, 450, 45, 50);
            
            UIImage *img3 = [UIImage imageNamed:@"fac3"];
            UIImageView *imageView3 = [[UIImageView alloc] initWithImage:img3];
            imageView3.frame = CGRectMake(850, 600, 45, 50);
            
            UIImage *img4 = [UIImage imageNamed:@"fac4"];
            UIImageView *imageView4 = [[UIImageView alloc] initWithImage:img4];
            imageView4.frame = CGRectMake(850, 550, 45, 50);
            
            
            [_mapView addSubview:imageView1];
            [_mapView addSubview:imageView2];
            [_mapView addSubview:imageView3];
            [_mapView addSubview:imageView4];
           
        }
        
        UIImage *img00 = [UIImage imageNamed:@"mark_at_map"];
        UIImageView *imageView00 = [[UIImageView alloc] initWithImage:img00];
        imageView00.frame = CGRectMake(640, 625, 45, 50);
        
        [_mapView addSubview:imageView00];
        [_mapView addSubview:imageView];
    }

    return self;
}

-(id)initWithIndoorMapImageName:(NSString*)indoorMap Frame:(CGRect)frame Type:(NSString *) type infoArr:(NSArray *) infosArray;
{
    if (self=[super init]) {
        
        self.bounces = NO;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.frame = frame;
        
        UIImage *map = [UIImage imageNamed:indoorMap];
        NSLog(@"map.size.width=%f and map.size.height=%f",map.size.width,map.size.height);
        _mapView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, map.size.width, map.size.height)];
        //_mapView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWitdh, ScreenHeight)];
        _mapView.contentMode = UIViewContentModeScaleAspectFit;
        _mapView.image=map;
        _mapView.userInteractionEnabled = YES;
        [self addSubview:_mapView];
        
        //双击
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [_mapView addGestureRecognizer:doubleTapGesture];
        
        //CGFloat minScale = self.frame.size.width/_mapView.frame.size.width;
        //CGFloat minScale = self.frame.size.width/_mapView.frame.size.width;
        CGFloat minScale = self.frame.size.height/_mapView.frame.size.height;
        [self setMinimumZoomScale:0.1];
        [self setMaximumZoomScale:10];
        [self setZoomScale:minScale];
        
        //开始标注地图
        //660.66666158040368, 455
        if(infosArray!=nil){
            for(InfoItem *info in infosArray){
                NSLog(@"info items type:%u",info.type);
                NSString *imageType = @"mark_at_map";
                if(info.type == InfoItemExhibit){
                    imageType = @"hudong_at_map";
                }
                else if(info.type == InfoItemRemoteVideo){//公共设施
                    imageType = @"";
                }
                else if(info.type == InfoItemRemoteVideo){//公共设施
                    imageType = @"dianti_at_map";
                }
                else if (info.type == InfoItemGame){
                    imageType = @"hudong_at_map";
                }
                else if (info.type == InfoItemGroup){
                    imageType = @"zhanpin_at_map";
                }
                UIImage *img = [UIImage imageNamed:imageType];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
                CGPoint point = info.pt;
                imageView.frame = CGRectMake(point.x, point.y, 45, 50);
                [_mapView addSubview:imageView];
            }
        }

    }
    
    return self;
}


#pragma mark - Zoom methods
-(void)handleDoubleTap:(UIGestureRecognizer*)gesture
{
    CGFloat newScale = self.zoomScale*1.5;
    CGRect zoonRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
    [self zoomToRect:zoonRect animated:YES];

}

//指定的中心点放到多少倍
-(void) scaleMapWithCenter:(CGPoint)center scaleSize:(CGFloat) scale {
    //CGFloat newScale = self.zoomScale*1.5;
    CGRect zoonRect = [self zoomRectForScale:scale withCenter:center];
    [self zoomToRect:zoonRect animated:YES];
}

//指定的中心点放大1.5倍
-(void) scaleMapBiggerWithCenter:(CGPoint)center {
    CGFloat newScale = self.zoomScale*1.2;
    CGRect zoonRect = [self zoomRectForScale:newScale withCenter:center];
    [self zoomToRect:zoonRect animated:YES];
}

-(void) scaleMapSmallerWithCenter:(CGPoint)center {
    CGFloat newScale = self.zoomScale*0.8;
    CGRect zoonRect = [self zoomRectForScale:newScale withCenter:center];
    [self zoomToRect:zoonRect animated:YES];
}


-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    NSLog(@"scale = %f",scale);
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width = self.frame.size.width /scale;
    zoomRect.origin.x = center.x -(zoomRect.size.width/2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height/2.0);
    return zoomRect;
    

}

#pragma mark - UIScrollViewDelegate

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return _mapView;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:NO];
}


#pragma mark -UITouch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    CGPoint touchPoint  = [[touches anyObject] locationInView:_mapView];
    NSValue *touchValue = [NSValue valueWithCGPoint:touchPoint];
    ////确定委托是否存在Entered方法
    //if([delegate respondsToSelector:@selector(performTouch:)])
    if([self.mydelegate respondsToSelector:@selector(performTouch:)]){
        [self.mydelegate performTouch:touchValue];
    }
    [self performSelector:@selector(performTouchArea:)
               withObject:touchValue
               afterDelay:0.1];
    
}
- (void)performTouchArea:(NSValue *)inTouchPoint
{
    
    CGPoint aTouchPoint = [inTouchPoint CGPointValue];

    _popoverView = [[PopoverView alloc] initWithFrame:CGRectZero];
    _popoverView.backgroundColor = [UIColor clearColor];
    _popoverView.delegate = self;
    //iphone 6 plus 实际坐标值除于3
    UIButton *popView = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 51, 70)];
    [popView setBackgroundImage:[UIImage imageNamed:@"mark_combine"] forState:UIControlStateNormal];
    [popView addTarget:self action:@selector(handleSingleTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [SKIndoorMapTransfer initWithCoordinate:@"604.67, 428, 724.67, 426.3, 712.33, 526.67, 601, 503.33" InPoint:aTouchPoint Inview:_mapView WithContentView:popView delegate:self popoverView:_popoverView];
    
    [SKIndoorMapTransfer initWithCoordinate:@"604.67, 628, 724.67, 626.3, 712.33, 726.67, 601, 703.33" InPoint:aTouchPoint Inview:_mapView WithContentView:popView delegate:self popoverView:_popoverView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - popover相关
-(void)handleSingleTap:(PopoverView*) view{
    //TODO popover要消失
    //[self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    
    [_popoverView dismiss:YES];
    ZhanPinVC *zpVc = (ZhanPinVC*)[StoryboardHelper getVCByVCName:@"zhanpinVC"];
    zpVc.hidesBottomBarWhenPushed = YES;
    
    [self.navCtrl pushViewController:zpVc animated:YES];
    
    NSLog(@"Hello world");
}

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@" uiimage handle single tap");
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView{
    NSLog(@" uiimage handle single dismiss");
}

@end
