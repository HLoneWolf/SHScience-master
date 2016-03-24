//
//  MapFileOwner.m
//  ShScience
//
//  Created by qiya on 16/1/25第5周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "MapFileOwner.h"

@implementation MapFileOwner

+(id)viewFromNibNamed:(NSString*) nibName {
    MapFileOwner *owner = [self new];
    [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    return owner.item2View;
}

+(id)fileOwnerFromNibNamed:(NSString*) nibName {
    MapFileOwner *owner = [self new];
    [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    return owner;
}

@end
