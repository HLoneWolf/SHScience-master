//
//  EFAnimationViewController.h
//  aaatest
//
//  Created by Jueying on 15/5/17.
//  Copyright (c) 2015年 Jueying. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EFItemViewDelegate <NSObject>

- (void)didTapped:(NSInteger)index;

@end


@protocol EFAnimationViewDelegate <NSObject>

- (void)didTappedEF:(NSInteger)index;

@end

@interface EFAnimationViewController : UIViewController
    @property (nonatomic, weak) id <EFAnimationViewDelegate>delegate;
@end




@interface EFItemView : UIButton

@property (nonatomic, weak) id <EFItemViewDelegate>delegate;

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title;

@end