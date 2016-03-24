//
//  QyDataManger.m
//  ShScience
//
//  Created by qiya on 16/3/9第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "QyDataManger.h"
#import "DataManager.h"
#import "InterestLabelItem.h"
#import "NewFilm4DItem.h"
#import "TemporaryDisplay.h"
#import "ShiyanItem.h"
#import "QuestionItem.h"
#import "HelpItem.h"
#import "RadioItem.h"
#import "NewFilmDetail.h"
#import "MyZhanPinDetail.h"


@implementation NSJSONSerialization (private)

+ (id)JSONObjecNoNulltWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError *__autoreleasing *)error
{
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:result];
    
    [NSJSONSerialization recursiveWithDictionary:dic];
    
    return dic;
}

+ (void)recursiveWithDictionary:(NSMutableDictionary *)originDic
{
    //1 移除所有null
    [NSJSONSerialization removeNullValueWithDic:originDic];
    
    NSArray *allkeysValue = [originDic allKeys];
    for (NSString *key in allkeysValue) {
        NSDictionary *dic = originDic[key];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            originDic[key] = mutableDic;
            [NSJSONSerialization recursiveWithDictionary:mutableDic];
        }
        
        //
        NSArray *array = originDic[key];
        if ([array isKindOfClass:[NSArray class]]) {
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
            originDic[key] = mutableArray;
            [NSJSONSerialization recursiveWithArray:mutableArray];
        }
    }
}

+ (void)recursiveWithArray:(NSMutableArray *)originArray
{
    for (NSInteger n = 0; n < originArray.count ; n++) {
        id subObject = originArray[n];
        if ([subObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:subObject];
            [originArray replaceObjectAtIndex:n withObject:mutableArray];
            [NSJSONSerialization recursiveWithArray:mutableArray];
        }
        
        if ([subObject isKindOfClass:[NSDictionary class]]) {
            [NSJSONSerialization recursiveWithDictionary:subObject];
        }
    }
}

//移除Dictironary 中的[NSNull null]
+ (void)removeNullValueWithDic:(NSMutableDictionary *)dic
{
    NSArray *keysNullValue = [dic allKeysForObject:[NSNull null]];
    [dic removeObjectsForKeys:keysNullValue];
}


@end


@implementation QyDataManger 


#pragma mark - 信息显示
+ (void)showMessage:(NSString *)message dur:(CGFloat)dur
{
    MBProgressHUD *errorHUD = nil;
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    errorHUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    errorHUD.removeFromSuperViewOnHide = YES;
    errorHUD.mode = MBProgressHUDModeText;
    errorHUD.detailsLabelText = message;
    [errorHUD show:YES];
    
    [errorHUD hide:YES afterDelay:dur];
}


//获取科学实验信息
+(DataRequest *) getShiyanInfoWithStartdate:(NSString *)nothing  callback:(void (^)(ShiyanItem *item, BOOL success))callback{

    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@web/dc/ec/%@", [DataManager shareDataManager].serverAddress,nothing];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToShiyanWithRequest:result callback:^(ShiyanItem *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}


//获取临展信息
+(DataRequest *) getLinZhanInfoWithStartdate:(NSString *)nothing  callback:(void (^)(TemporaryDisplay *item, BOOL success))callback{
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@web/tdf/temporaryDisplay/1", [DataManager shareDataManager].serverAddress];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToTemporaryDisplayWithRequest:result callback:^(TemporaryDisplay *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}


//获取Film4D新
+(DataRequest *) getFilm4DById:(NSString *)filmId  callback:(void (^)(NewFilmDetail *item, BOOL success))callback{
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@api/museum/film4D/%@", [DataManager shareDataManager].serverAddress,filmId];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToNewFilm4DItemWithRequest:result callback:^(NewFilmDetail *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}


//获取展品详情
+(DataRequest *) getZhanpinDetailById:(NSString *)zhanpinId  callback:(void (^)(MyZhanPinDetail *item, BOOL success))callback{
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@app/museum/exhibits/%@", [DataManager shareDataManager].serverAddress,zhanpinId];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToMyZhanpinDetailItemWithRequest:result callback:^(MyZhanPinDetail *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

//获取4维电影排片信息
+(DataRequest *) getCenima4DInfoWithStartdate:(NSString *)startDate endDate:(NSString *)endDate callback:(void (^)(NSArray *item, BOOL success))callback{
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@app/scheduleFilm4D?startDate=%@&endDate=%@", [DataManager shareDataManager].serverAddress,startDate, endDate];

    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToNewFileItemWithRequest:result callback:^(NSArray *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}




//获取用户关注的标签详情
+(DataRequest *) getInfoLeftMainPageWithUserId:(NSString *)userId mac:(NSString *)user callback:(void (^)(NSArray *items, BOOL success))callback{
    NSString *urlString;
    
    urlString = [NSString stringWithFormat:@"%@%@/app/label/interest?userId=%@&mac=%@", [DataManager shareDataManager].serverAddress, @"", userId, user];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToInterestLabelItemWithRequest:result callback:^(NSArray *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}

//帮助中心的问题
+(DataRequest *) getAllQuestion:(NSString *)nothing callback:(void (^)(NSArray *items, BOOL success))callback{
    
    NSString *urlString;
    
    urlString = [NSString stringWithFormat:@"%@app/help", [DataManager shareDataManager].serverAddress];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToQuestionItemWithRequest:result callback:^(NSArray *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;

}

//语音导航
+(DataRequest *) getAllRadio:(NSString *)nothing callback:(void (^)(NSArray *items, BOOL success))callback{
    
    NSString *urlString;
    
    urlString = [NSString stringWithFormat:@"http://www.snhm.org.cn/museum/web/ce/findExhbitAudio?12"];
    
    DataRequest *request = [DataManager requestWithURL:[NSURL URLWithString:urlString] callback:^(DataRequest *result, BOOL success) {
        if (success) {
            [QyDataManger convertToRadioItemWithRequest:result callback:^(NSArray *item, BOOL success) {
                callback(item, success);
            }];
        }else{
            if (callback != nil) {
                callback(nil, success);
            }
        }
    }];
    
    return  request;
}































+ (void)convertToRadioItemWithRequest:(DataRequest *)request callback:(void (^)( NSArray *items, BOOL success))callback {
    
    NSMutableArray *innerItemList = [NSMutableArray array];
    //
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        
        for (NSDictionary *item1Dic in dic[@"result"][@"data"]) {
            RadioItem *innerItem = [[RadioItem alloc] init];
            innerItem.eid =  @([item1Dic[@"eid"] integerValue]);
            innerItem.name = [NSString stringWithFormat:@"%@",item1Dic[@"name"]];
            innerItem.code = [NSString stringWithFormat:@"%@",item1Dic[@"code"]];
            innerItem.audio = [NSString stringWithFormat:@"%@",item1Dic[@"audio"]];
            innerItem.eRoomName = [NSString stringWithFormat:@"%@",item1Dic[@"eRoomName"]];
            [innerItemList addObject:innerItem];
        }
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(innerItemList, success);
    }
    
}

//帮助中心的转换，让问题匹配。
+ (void)convertToQuestionItemWithRequest:(DataRequest *)request callback:(void (^)( NSArray *items, BOOL success))callback {
    
    NSMutableArray *innerItemList = [NSMutableArray array];
    //
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        
        for (NSDictionary *item1Dic in dic[@"result"]) {
            HelpItem *innerItem = [[HelpItem alloc] init];
            
            innerItem.hid =  @([item1Dic[@"id"] integerValue]);
            innerItem.question = [NSString stringWithFormat:@"%@",item1Dic[@"question"]];
            innerItem.answer = [NSString stringWithFormat:@"%@",item1Dic[@"answer"]];
            [innerItemList addObject:innerItem];
        }
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(innerItemList, success);
    }
    
}

+ (void)convertToShiyanWithRequest:(DataRequest *)request callback:(void (^)( ShiyanItem *items, BOOL success))callback {
    
    ShiyanItem *innerItem = [[ShiyanItem alloc] init];
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        
        innerItem.title = dic[@"result"][@"title"];
        innerItem.introduction = dic[@"result"][@"introduction"];
        innerItem.type = dic[@"result"][@"type"];
        innerItem.address = dic[@"result"][@"address"];
        innerItem.startDate = dic[@"result"][@"startDate"];
        innerItem.endDate = dic[@"result"][@"endDate"];
        innerItem.specificTime = dic[@"result"][@"specificTime"];
        innerItem.pics = dic[@"result"][@"pics"];
        innerItem.keyWord = dic[@"result"][@"keyWord"];
        innerItem.totalParticipants = dic[@"result"][@"totalParticipants"];
        innerItem.contents = dic[@"result"][@"contents"];
        innerItem.video = dic[@"result"][@"video"];
        innerItem.audio = dic[@"result"][@"audio"];
        innerItem.canBook = dic[@"result"][@"canBook"];
        innerItem.scientist = dic[@"result"][@"scientist"];
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(innerItem, success);
    }
}

+ (void)convertToTemporaryDisplayWithRequest:(DataRequest *)request callback:(void (^)( TemporaryDisplay *items, BOOL success))callback {
    TemporaryDisplay *innerItem = [[TemporaryDisplay alloc] init];
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        
        innerItem.total = dic[@"result"][@"total"];
        innerItem.currentpage = dic[@"result"][@"currentpage"];
        innerItem.pagesize = dic[@"result"][@"pagesize"];
        
        
        NSMutableArray *subItemList = [NSMutableArray array];
            for (NSDictionary *itemDic in dic[@"result"][@"data"]) {
                TemporaryDisplayData *subItem = [[TemporaryDisplayData alloc] init];
                subItem.dataId = @([itemDic[@"id"] integerValue]);
                subItem.icon = [NSString stringWithFormat:@"%@",itemDic[@"icon"]];
                subItem.name = [NSString stringWithFormat:@"%@",itemDic[@"name"]];
                subItem.pics = itemDic[@"pics"];
                subItem.exhibitionDate = [NSString stringWithFormat:@"%@",itemDic[@"exhibitionDate"]];
                subItem.exhibitionEndDate = [NSString stringWithFormat:@"%@",itemDic[@"exhibitionEndDate"]];
                subItem.address = [NSString stringWithFormat:@"%@",itemDic[@"address"]];
                subItem.introduction = [NSString stringWithFormat:@"%@",itemDic[@"introduction"]];
                 subItem.video = [NSString stringWithFormat:@"%@",itemDic[@"video"]];
                 subItem.audio = [NSString stringWithFormat:@"%@",itemDic[@"audio"]];
                 subItem.roomId = @([itemDic[@"roomId"] integerValue]);
                
                [subItemList addObject:subItem];
            }
            innerItem.dataList = subItemList;
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(innerItem, success);
    }

    
}




//获取展品详情
+ (void)convertToMyZhanpinDetailItemWithRequest:(DataRequest *)request callback:(void (^)( MyZhanPinDetail *items, BOOL success))callback {
    MyZhanPinDetail *innerItem = [[MyZhanPinDetail alloc] init];
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        
        innerItem.eid = @([dic[@"result"][@"eid"] integerValue]);
        innerItem.name =[NSString stringWithFormat:@"%@",dic[@"result"][@"name"]];
        innerItem.summary = [NSString stringWithFormat:@"%@",dic[@"result"][@"summary"]];
        innerItem.icon = [NSString stringWithFormat:@"%@",dic[@"result"][@"icon"]];
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(innerItem, success);
    }
    
    
}



//获取电影详情
+ (void)convertToNewFilm4DItemWithRequest:(DataRequest *)request callback:(void (^)( NewFilmDetail *items, BOOL success))callback {
    NewFilmDetail *innerItem = [[NewFilmDetail alloc] init];
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        
        innerItem.cenimaId = @([dic[@"result"][@"id"] integerValue]);
        innerItem.name =[NSString stringWithFormat:@"%@",dic[@"result"][@"name"]];
        innerItem.introduction = [NSString stringWithFormat:@"%@",dic[@"result"][@"introduction"]];
        innerItem.image = [NSString stringWithFormat:@"%@",dic[@"result"][@"image"]];
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(innerItem, success);
    }
    
    
}



+ (void)convertToNewFileItemWithRequest:(DataRequest *)request callback:(void (^)( NSArray *items, BOOL success))callback {
    NSMutableArray *innerItemList = [NSMutableArray array];
//
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        
        
        for (NSDictionary *item1Dic in dic[@"result"]) {
            NewFilm4DItem *innerItem = [[NewFilm4DItem alloc] init];
            
            innerItem.cenimaId =  @([item1Dic[@"id"] integerValue]);
            innerItem.name = [NSString stringWithFormat:@"%@",item1Dic[@"name"]];
            innerItem.address = [NSString stringWithFormat:@"%@",item1Dic[@"address"]];
            
            NSMutableArray *subItemList = [NSMutableArray array];
            
            for (NSDictionary *itemDic in item1Dic[@"film"]) {
                SubFilmItem *subItem = [[SubFilmItem alloc] init];
                subItem.subFilmId = @([itemDic[@"id"] integerValue]);
                subItem.name = [NSString stringWithFormat:@"%@",itemDic[@"name"]];
                subItem.scheduleTime = [NSString stringWithFormat:@"%@",itemDic[@"scheduleTime"]];
                subItem.scheduleScreenings = [NSString stringWithFormat:@"%@",itemDic[@"scheduleScreenings"]];
                [subItemList addObject:subItem];
            }
            innerItem.filmList = subItemList;
            
            [innerItemList addObject:innerItem];
        }
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(innerItemList, success);
    }

}

+ (void)convertToInterestLabelItemWithRequest:(DataRequest *)request callback:(void (^)(NSArray *items, BOOL success))callback {
    
    //
    NSMutableArray *labelitems = [NSMutableArray array];
    
    NSString *message;
    BOOL success = YES;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjecNoNulltWithData:request.responseData options:NSJSONReadingMutableContainers error:&error];
    
    //JSON 错误
    if(error != nil)
    {
        message = error.description;
        success = NO;
    }
    
    //格式错误
    @try {
        //NSTimeInterval interval = ((NSNumber *)dic[@"result"][@"date"]).doubleValue/1000.0;
        //interestLabelItem.date = [NSDate dateWithTimeIntervalSince1970:interval];
        for (NSDictionary *itemDic in dic[@"result"]) {
            InterestLabelItem *interestLabelItem = [[InterestLabelItem alloc] init];
            interestLabelItem.type = [NSString stringWithFormat:@"%@",itemDic[@"userName"]];
            interestLabelItem.labelId = @([itemDic[@"labelId"] integerValue]);
            interestLabelItem.entityId = @([itemDic[@"entityId"] integerValue]);
            interestLabelItem.icon = [NSString stringWithFormat:@"%@",itemDic[@"icon"]];
            interestLabelItem.displayName = [NSString stringWithFormat:@"%@",itemDic[@"name"]];
            [labelitems addObject:interestLabelItem];
        }
        
    }
    @catch (NSException *exception) {
        success = NO;
        message = exception.description;
    }
    @finally {
        if (request.showError && !success) {
            [QyDataManger showMessage:message dur:request.errorDur];
        }
        callback(labelitems, success);
    }
}

@end
