//
//  SKIndoorMapTransfer.m
//  IndoorMapDemo
//
//  Created by silverk on 14-8-7.
//  Copyright (c) 2014年 silverk. All rights reserved.
//

#import "SKIndoorMapTransfer.h"


@implementation SKIndoorMapTransfer

+(void)initWithCoordinate:(NSString*)inStrCoordinate InPoint:(CGPoint)point Inview:(UIView*)view WithContentView:(UIView*)contentView delegate:(id<PopoverViewDelegate>)delegate popoverView:(PopoverView*) popoverView
{
    
    MapArea*_mapArea= [[MapArea alloc]initWithCoordinate:inStrCoordinate];
    if ([_mapArea isAreaSelected:point]) {
        NSLog(@"point in this area");
        [popoverView showAtPoint:point inView:view withContentView:contentView];
    }
    
}


@end
