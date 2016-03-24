//
//  ProfileFileOwner.m
//  ShScience
//
//  Created by qiya on 16/1/26第5周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ProfileFileOwner.h"

@implementation ProfileFileOwner


+(id)fileOwnerFromNibNamed {
    ProfileFileOwner *owner = [self new];
    [[NSBundle mainBundle] loadNibNamed:@"ProfileView" owner:owner options:nil];
    return owner;
}

@end
