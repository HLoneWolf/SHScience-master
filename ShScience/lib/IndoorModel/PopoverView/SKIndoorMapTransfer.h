//
//  SKIndoorMapTransfer.h
//  IndoorMapDemo
//
//  Created by silverk on 14-8-7.
//  Copyright (c) 2014年 silverk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopoverView.h"
#import "MapArea.h"

@interface SKIndoorMapTransfer : NSObject<PopoverViewDelegate>


+(void)initWithCoordinate:(NSString*)inStrCoordinate InPoint:(CGPoint)point Inview:(UIView*)view WithContentView:(UIView*)contentView delegate:(id<PopoverViewDelegate>)delegate popoverView:(PopoverView*) popoverView;


@end
