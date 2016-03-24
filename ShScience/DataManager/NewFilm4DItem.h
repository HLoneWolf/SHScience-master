//
//  NewFilm4DItem.h
//  ShScience
//
//  Created by qiya on 16/3/9第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewFilm4DItem : NSObject

@property (nonatomic, strong) NSNumber *cenimaId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;

@property NSArray *filmList;
@end


@interface SubFilmItem : NSObject

@property (nonatomic, strong) NSNumber *subFilmId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *scheduleTime;

@property (nonatomic, copy) NSString *scheduleScreenings;

@end
