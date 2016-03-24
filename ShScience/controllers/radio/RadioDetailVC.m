//
//  RadioDetailVC.m
//  ShScience
//
//  Created by qiya on 16/3/8第11周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "RadioDetailVC.h"
#import "TTTAttributedLabel.h"
#import "QyUtils.h"

@interface RadioDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *detailName;
//@property (weak, nonatomic) IBOutlet TTTAttributedLabel *detailDes;
@property TTTAttributedLabel *detailDes;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation RadioDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitleNoHidden:@"载人飞船"];
    
    _detailDes = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _detailDes.font = [UIFont systemFontOfSize:17];
    _detailDes.lineBreakMode = NSLineBreakByWordWrapping;
    _detailDes.numberOfLines = 0;

    NSString *text = @"新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)新华网北京3月8日电 3月8日上午，中共中央总书记、国家主席、中央军委主席习近平来到十二届全国人大四次会议湖南代表团参加审议。(据新华社“新华视点”微博报道)";
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:text
                                                                    attributes:@{
                                                                                 (id)kCTForegroundColorAttributeName : (id)[UIColor whiteColor].CGColor,
                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                 }];
    _detailDes.text = attString;
    CGSize s =[TTTAttributedLabel sizeThatFitsAttributedString:attString withConstraints:CGSizeMake(ScreenWitdh-60, 1000) limitedToNumberOfLines:0];
    
    _detailDes.frame = CGRectMake(5, 5, s.width, s.height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(28, 160, ScreenWitdh-56, 310)];
    //[scrollView setBackgroundColor:[UIColor yellowColor]];
    scrollView.contentSize = _detailDes.frame.size;
    [self.view addSubview:scrollView];
    [scrollView addSubview:_detailDes];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detailPlay:(id)sender {
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
