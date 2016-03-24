//
//  OneFloorVC.h
//  ShScience
//
//  Created by qiya on 16/2/4第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKIndoorMapView.h"
#import "BasicNaviVC.h"
@interface OneFloorVC : BasicNaviVC<SKIndoorMapDelegate>

@property SKIndoorMapView *mapView;


@property NSMutableArray *zoneAreArray;

@property NSString *selectFloor;

@end
