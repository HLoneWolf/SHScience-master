//
//  ViewController.m
//  ShScience
//
//  Created by qiya on 15/12/29第1周.
//  Copyright © 2015年 qiya. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "UserApi.h"
#import "UIImageView+WebCache.h"
#import "SDVersion.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)HudStatusBtn:(id)sender {
    
    //sample url
    //http://www.cnblogs.com/xunziji/archive/2012/11/05/2754915.html
    //https://github.com/TransitApp/SVProgressHUD
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack]; //用户不可操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        [NSThread sleepForTimeInterval:3.0f];//显示3s 进度条
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}
- (IBAction)getFromNetBtn:(id)sender {
    
    NSString *username = @"deng";
    NSString *password = @"deng";
    if (username.length > 0 && password.length > 0) {
        UserApi *api = [[UserApi alloc] initWithUsername:username password:password];
       [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"succeed");
            NSString *result = [api getResult];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:result preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        } failure:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSLog(@"failed");
        }];
    }
    
}

- (IBAction)loadImageFromNet:(id)sender {
    //https://github.com/rs/SDWebImage
    //http://www.cocoachina.com/ios/20141212/10622.html
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/PC%E9%A6%96%E9%A1%B5%E8%83%8C%E6%99%AF%EF%BC%8D%E5%BD%AD%E4%BA%8E%E6%99%8F.jpg"] placeholderImage:[UIImage imageNamed:@"Flash"]];
}

- (IBAction)getIOSDevice:(id)sender {
//https://github.com/sebyddd/SDVersion
    // Check for device model
    if ([SDVersion deviceVersion] == iPhone6S)
        NSLog(@"You got the iPhone 6S. Sweet 🍭!");
    else if ([SDVersion deviceVersion] == iPhone6Plus)
        NSLog(@"iPhone 6 Plus? Bigger is better!");
    else if ([SDVersion deviceVersion] == iPadPro)
        NSLog(@"You own an iPad Pro!");
    
    // Check for device screen size
    if ([SDVersion deviceSize] == Screen4inch)
        NSLog(@"Your screen is 4 inches");
    NSLog(@"%@",[SDVersion deviceName]);
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:[SDVersion deviceName] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
