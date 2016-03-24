//
//  ProfileFileOwner.h
//  ShScience
//
//  Created by qiya on 16/1/26第5周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProfileFileOwner : NSObject

//前面的3个按钮
@property (strong, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (strong, nonatomic) IBOutlet UIView *likeView;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (strong, nonatomic) IBOutlet UIView *settingView;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;

//列表中的视图
@property (strong, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;

//@property (strong, nonatomic) IBOutlet UIView *feiChuanDetailCellView;

@property (strong, nonatomic) IBOutlet UIView *feiChuanDetailCellView;//这个其实是浏览路径


@property (strong, nonatomic) IBOutlet UIView *loveView;

@property (strong, nonatomic) IBOutlet UIView *shareView;

@property (strong, nonatomic) IBOutlet UIView *pathView;//这个是飞船详细

@property (weak, nonatomic) IBOutlet UILabel *recommandPathView;
@property (strong, nonatomic) IBOutlet UIView *suggestView;

@property (strong, nonatomic) IBOutlet UIView *msgView;
+(id)fileOwnerFromNibNamed;
@end
