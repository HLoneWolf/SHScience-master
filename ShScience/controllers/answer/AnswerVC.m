//
//  AnswerVC.m
//  ShScience
//
//  Created by qiya on 16/3/1第10周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "AnswerVC.h"
#import "DataManager.h"

@interface AnswerVC ()
@property (weak, nonatomic) IBOutlet UILabel *questionTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *choice1Btn;

@property (weak, nonatomic) IBOutlet UIButton *choice2Btn;
@property (weak, nonatomic) IBOutlet UIButton *choice3Btn;

@property (weak, nonatomic) IBOutlet UIButton *choice4Btn;
@property (weak, nonatomic) IBOutlet UIButton *questionPreBtn;
@property (weak, nonatomic) IBOutlet UIButton *questionNextBtn;
@property (weak, nonatomic) IBOutlet UILabel *questionIndex;

@end

@implementation AnswerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setupNavBtnWithTitle:@"学习单"];
    [self setupNavBtnWithTitleNoHidden:@"学习单"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 网络请求

-(void) requestGetQuestionAnswer {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:@"1"];
    User *user = [DataManager getUser];
    
    if(user!=nil){
//        DataRequest *request = [DataManager loadQuestionItemsForLearnBookID:<#(NSNumber *)#> user:<#(User *)#> callback:^(NSArray *questionItems, BOOL success) {
//            //
//        }];
//        [request startAsynchronous];
    }
    
    else {
        //登录去
    }
}
@end
