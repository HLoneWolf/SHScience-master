//
//  MapFileOwner.h
//  ShScience
//
//  Created by qiya on 16/1/25第5周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MapFileOwner : NSObject

@property (strong, nonatomic) IBOutlet UIView *item2View;
@property (strong, nonatomic) IBOutlet UIView *item3View;

+(id)viewFromNibNamed:(NSString*) nibName;

+(id)fileOwnerFromNibNamed:(NSString*) nibName;

@end
