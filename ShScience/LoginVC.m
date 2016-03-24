//
//  LoginVC.m
//  ShScience
//
//  Created by qiya on 16/1/23第4周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "LoginVC.h"
#import "UINavigationBar+Awesome.h"
#import "QyUtils.h"
#import "CRToast.h"
#import "Constant.h"
#import "User.h"
#import "DataManager.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;

@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;

@end

@implementation LoginVC

//登录按钮
- (IBAction)loginBtn:(id)sender {
    NSString *phone= _userNameTxt.text;
    NSString *pass = _passwordTxt.text;
    
    if([phone length]==0){
        [QyUtils navbarInfoToast:@"手机号码不能为空"];
        return;
    }
    if([pass length]==0){
        [QyUtils navbarInfoToast:@"密码不能为空"];
    }
    User *_user = [[User alloc]init];
    [_user generateMAC];
    _user.account = phone;
    _user.pwd = pass;
    
    DataRequest *request = [DataManager loginWithUser:_user callback:^(User *user, BOOL success) {
        NSLog(@"enter login user is %@",user);
        if(success){
            NSLog(@"success login user is %@",user);
            //保存用户信息
            [QyUtils setDefaultValue:user.mobile WithKey:KJG_USER];
            [QyUtils setDefaultValueObject:user.score WithKey:ALL_USER_KJG];
            [QyUtils setDefaultValueObject:user.score WithKey:KJG_USER_ID];
            //退出登录界面
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [request startAsynchronous];
}

//注册按钮
- (IBAction)regBtn:(id)sender {
    
    NSString *phone= _userNameTxt.text;
    NSString *pass = _passwordTxt.text;
    
    if([phone length]==0){
        [QyUtils navbarInfoToast:@"手机号码不能为空"];
        return;
    }
    if([pass length]==0){
        [QyUtils navbarInfoToast:@"密码不能为空"];
    }
    User *_user = [[User alloc]init];
    [_user generateMAC];
    _user.account = phone;
    _user.pwd = pass;
    
    DataRequest *request = [DataManager registWithUser:_user callback:^(BOOL registed, BOOL success) {
        //NSLog(@"register back info %@",registed);
    }];
    
    [request startAsynchronous];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavBtnWithTitle:@"用户登录"];//父类中设置导航
    
    //设置输入框颜色和提示字体颜色
    UIColor *whiteColor = [UIColor whiteColor];
    UIColor *lightTextColor = [UIColor lightTextColor];
    _userNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"点击输入手机号/Email登录" attributes:@{NSForegroundColorAttributeName: lightTextColor}];
    _passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:@{NSForegroundColorAttributeName: lightTextColor}];
    _userNameTxt.layer.borderColor = [whiteColor CGColor];
    _passwordTxt.layer.borderColor = [whiteColor CGColor];
    _userNameTxt.layer.borderWidth = 1.0f;
    _passwordTxt.layer.borderWidth = 1.0f;
    //_userNameTxt.layer.cornerRadius = 6.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;//打开顶部Tab
//    [self.navigationController.navigationBar lt_setBackgroundColor:[QyUtils colorWithRed:1 green:78 blue:146]];//1 78 146
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//导航字体颜色
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
//    [self.navigationController.navigationBar lt_reset];
//}

//键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_userNameTxt endEditing:YES];
    [_passwordTxt endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
