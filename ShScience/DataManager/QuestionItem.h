//
//  QuestionItem.h
//  NaturalMuseumiPhone
//
//  Created by Michael Lu on 15/6/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerItem : NSObject

@property(nonatomic, strong) NSNumber *sid;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *number;

@end

@interface QuestionItem : NSObject

@property(nonatomic, strong) NSNumber *sid;
@property(nonatomic, strong) NSNumber *sort;
@property(nonatomic, copy) NSString *question;
@property(nonatomic, copy) NSString *rightAnswer;
@property(nonatomic, strong) NSArray *answerItems;
@property(nonatomic, copy) NSString *myAnswerNumber;
@property(nonatomic, assign) BOOL isFinished;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, copy) NSString *usedTime;

@end
