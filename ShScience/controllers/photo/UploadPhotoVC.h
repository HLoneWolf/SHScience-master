//
//  UploadPhotoVC.h
//  ShScience
//
//  Created by qiya on 16/2/23第9周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@interface UploadPhotoVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *photoTitle;
@property (weak, nonatomic) IBOutlet SZTextView *photoCotent;
@property (weak, nonatomic) IBOutlet UIImageView *lastPhoto;

@end
