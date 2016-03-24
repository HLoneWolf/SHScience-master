//
//  SKIndoorMapView.h
//  IndoorMapDemo
//
//  Created by silverk on 14-8-3.
//  Copyright (c) 2014年 silverk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"

@protocol SKIndoorMapDelegate <NSObject>

-(void)performTouch:(NSValue *)inTouchPoint;

@end

@interface SKIndoorMapView : UIScrollView<UIScrollViewDelegate,PopoverViewDelegate>

@property(assign,nonatomic) id<SKIndoorMapDelegate> mydelegate;

@property(nonatomic,strong)UIImageView *mapView;
@property UINavigationController *navCtrl;

@property PopoverView *popoverView;

@property NSArray *infosArray;

//-(id)initWithIndoorMapImageName:(NSString*)indoorMap Frame:(CGRect)frame;
-(id)initWithIndoorMapImageName:(NSString*)indoorMap Frame:(CGRect)frame Type:(NSString *) type;

-(id)initWithIndoorMapImageName:(NSString*)indoorMap Frame:(CGRect)frame Type:(NSString *) type infoArr:(NSArray *) infosArray;



-(void) scaleMapWithCenter:(CGPoint)center scaleSize:(CGFloat) scale;

-(void) scaleMapBiggerWithCenter:(CGPoint)center;

-(void) scaleMapSmallerWithCenter:(CGPoint)center;

@end
