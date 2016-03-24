//
//  UIView+Ext.m
//  LoadNibViewDemo
//
//  Created by Haven on 7/2/14.
//  Copyright (c) 2014 LF. All rights reserved.
//

#import "UIView+Ext.h"
#import "MapFileOwner.h"

@implementation UIView (Ext)
+(id)loadFromNib {
    return [self loadFromNibNamed:NSStringFromClass(self)];
}

+(id)loadFromNibNamed:(NSString*) nibName {
    return [MapFileOwner viewFromNibNamed:nibName];
}

+ (id)loadFileOwnerFromNibNamed:(NSString*) nibName {
    return [MapFileOwner fileOwnerFromNibNamed:nibName];
}

+ (id)loadFromNibNoOwner {
    UIView *result = nil;
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner: nil options: nil];
    for (id anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            result = anObject;
            break;
        }
    }
    return result;
}
@end
