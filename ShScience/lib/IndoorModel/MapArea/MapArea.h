//
//  MapArea.h
//  TagImageView
//
//  Created by apple on 13-10-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MapArea : NSObject
{
    UIBezierPath        *_mapArea;
}

@property (nonatomic, retain)   UIBezierPath        *mapArea;

-(id)initWithCoordinate:(NSString*)inStrCoordinate;

-(BOOL)isAreaSelected:(CGPoint)inPointTouch;

@end
