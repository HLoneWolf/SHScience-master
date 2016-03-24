//
//  BasicNaviVC.h
//  ShScience
//
//  Created by qiya on 16/2/24第9周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicNaviVC : UIViewController

@property NSString *hiddenOthers;

-(void) setupNavBtnWithTitle:(NSString *) title ;
-(void) setupNavBtnWithTitleNoHidden:(NSString *) title ;

@end
