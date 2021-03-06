//
//  LCTabBar.m
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/2.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "LCTabBar.h"
#import "LCTabBarItem.h"

#define ScreenWitdh [UIScreen mainScreen].applicationFrame.size.width
#define ScreenHeight [UIScreen mainScreen].applicationFrame.size.height

@interface LCTabBar ()

@property (nonatomic, strong) LCTabBarItem *selectedItem;
@property (nonatomic, strong) NSMutableArray *tabBarItems;

@end

@implementation LCTabBar

- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        
        _tabBarItems = [[NSMutableArray alloc] init];
    }
    return _tabBarItems;
}

- (void)addTabBarItem:(UITabBarItem *)item {
    
    LCTabBarItem *tabBarItem = [[LCTabBarItem alloc] initWithItemImageRatio:self.itemImageRatio];
    
    tabBarItem.badgeTitleFont         = self.badgeTitleFont;
    tabBarItem.itemTitleFont          = self.itemTitleFont;
    tabBarItem.itemTitleColor         = self.itemTitleColor;
    tabBarItem.selectedItemTitleColor = self.selectedItemTitleColor;
    
    tabBarItem.tabBarItemCount = self.tabBarItemCount;
    
    tabBarItem.tabBarItem = item;
    
    [tabBarItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabBarItem];
    
    [self.tabBarItems addObject:tabBarItem];
    
    if (self.tabBarItems.count == 1) {
        
        [self buttonClick:tabBarItem];
    }
}

- (void)buttonClick:(LCTabBarItem *)tabBarItem {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        
        [self.delegate tabBar:self didSelectedItemFrom:self.selectedItem.tabBarItem.tag to:tabBarItem.tag];
    }
    
    self.selectedItem.selected = NO;
    self.selectedItem = tabBarItem;
    self.selectedItem.selected = YES;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
//    CGRect tabFrame = self.frame;
//    tabFrame.size.height = 50;
//    tabFrame.origin.y = self.frame.size.height - 50;
//    self.frame = tabFrame;
    //self.frame =  CGRectMake(0, ScreenHeight-40, ScreenWitdh, 40);
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    //NSLog(@"h-------%f",h);
    
    int count = (int)self.tabBarItems.count;
    CGFloat itemY = 0;
    CGFloat itemW = w / self.subviews.count;
    CGFloat itemH = h;
    
    for (int index = 0; index < count; index++) {
        
        LCTabBarItem *tabBarItem = self.tabBarItems[index];
        
        //tabBarItem.backgroundColor = [UIColor redColor];
        tabBarItem.tag = index;
        CGFloat itemX = index * itemW;
        tabBarItem.frame = CGRectMake(itemX, itemY-10, itemW, itemH+10);
    }
}

//-(CGSize)sizeThatFits:(CGSize)size
//{
//    CGSize sizeThatFits = [super sizeThatFits:size];
//    sizeThatFits.height = 100;
//    
//    return sizeThatFits;
//}

@end
