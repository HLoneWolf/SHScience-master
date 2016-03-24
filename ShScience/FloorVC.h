//
//  FloorVC.h
//  ShScience
//
//  Created by qiya on 16/2/2第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "iCarousel.h"

@interface FloorVC : UIViewController<RKTabViewDelegate,iCarouselDelegate,iCarouselDataSource>


@property iCarousel *iCarousel;

@end
