//
//  Comment.h
//  ShanghaiNaturalHistoryMuseum
//
//  Created by Leon on 14/8/26.
//  Copyright (c) 2014年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    CommentStory = 0,
//    CommentExhibit = 1,
//    CommentQuestionAnswer = 2,
//    CommentDisscus = 3,
//    CommentTakePhoto = 4,
//} CommentType;
@class User;

@interface CommentContent : NSObject

@property (nonatomic, strong) NSNumber *sid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSDate *date;

@end

@interface CommentItem : NSObject

///当前页
@property (nonatomic, strong) NSNumber *currentPage;
///每页最大数
@property (nonatomic, strong) NSNumber *pageSize;
///评论详细信息
@property (nonatomic, strong) NSMutableArray *contents;

@end
