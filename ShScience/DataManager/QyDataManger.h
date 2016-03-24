//
//  QyDataManger.h
//  ShScience
//
//  Created by qiya on 16/3/9第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXDataManager.h"
#import <GCDAsyncUdpSocket.h>
#import <GCDAsyncSocket.h>
#import "NewFilm4DItem.h"
#import "TemporaryDisplay.h"
#import "ShiyanItem.h"
#import "NewFilmDetail.h"
#import "MyZhanPinDetail.h"

@interface QyDataManger : LXDataManager <GCDAsyncUdpSocketDelegate>

+(DataRequest *) getInfoLeftMainPageWithUserId:(NSString *)userId mac:(NSString *)user callback:(void (^)(NSArray *items, BOOL success))callback;

+(DataRequest *) getCenima4DInfoWithStartdate:(NSString *)startDate endDate:(NSString *)endDate callback:(void (^)(NSArray *item, BOOL success))callback;

+(DataRequest *) getLinZhanInfoWithStartdate:(NSString *)nothing  callback:(void (^)(TemporaryDisplay *item, BOOL success))callback;

+(DataRequest *) getShiyanInfoWithStartdate:(NSString *)nothing  callback:(void (^)(ShiyanItem *item, BOOL success))callback;

+(DataRequest *) getAllQuestion:(NSString *)nothing callback:(void (^)(NSArray *items, BOOL success))callback;

+(DataRequest *) getAllRadio:(NSString *)nothing callback:(void (^)(NSArray *items, BOOL success))callback;


+(DataRequest *) getFilm4DById:(NSString *)filmId  callback:(void (^)(NewFilmDetail *item, BOOL success))callback;


+(DataRequest *) getZhanpinDetailById:(NSString *)zhanpinId  callback:(void (^)(MyZhanPinDetail *item, BOOL success))callback;
@end
