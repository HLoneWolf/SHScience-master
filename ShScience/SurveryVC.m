//
//  SurveryVC.m
//  ShScience
//
//  Created by qiya on 16/1/3第2周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "SurveryVC.h"
#import "EFAnimationViewController.h"
#import "CNPPopupController.h"
#import "QyUtils.h"
#import "AKPickerView.h"
#import "DataManager.h"

@interface SurveryVC ()

@property (nonatomic, strong) CNPPopupController *popupController;

@property (nonatomic, strong) EFAnimationViewController *efViewController;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (weak, nonatomic) IBOutlet UIView *selectContentView;
@property (nonatomic) IBOutlet UIImageView *manIV;
@property (nonatomic) IBOutlet UIImageView *womanIV;
@property (weak, nonatomic) IBOutlet AKPickerView *agePickerView;
@property (weak, nonatomic) IBOutlet AKPickerView *bothPickerView;

@property (weak, nonatomic) IBOutlet AKPickerView *timesPickerView;
@property (weak, nonatomic) IBOutlet AKPickerView *likePickerView;
@property (weak, nonatomic) IBOutlet UIImageView *introImage;
@property (weak, nonatomic) IBOutlet UILabel *myKjg;
@property (weak, nonatomic) IBOutlet UITextField *textOfMykjg;
@property (weak, nonatomic) IBOutlet UILabel *detailOfkjg;
@end

@implementation SurveryVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.efViewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        viewController.view.backgroundColor=[UIColor clearColor];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });
    self.efViewController.delegate = self;
    
    
    
    _textOfMykjg.layer.borderColor = [UIColor whiteColor].CGColor;
    //_textOfMykjg.layer.borderColor = UIColor.redColor.CGColor;
    _textOfMykjg.layer.borderWidth = 1;
    _textOfMykjg.layer.masksToBounds = true;
    [_textOfMykjg setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

    
    [self.view bringSubviewToFront:_skipBtn];
    [self.view bringSubviewToFront:_manIV];
    [self.view bringSubviewToFront:_womanIV];
    [self.view bringSubviewToFront:_manBtn];
    [self.view bringSubviewToFront:_womanBtn];
    
    
    [self.view bringSubviewToFront:_myKjg];
    [self.view bringSubviewToFront:_textOfMykjg];
    [self.view bringSubviewToFront:_detailOfkjg];
    [self.view bringSubviewToFront:_introImage];
    [self.view bringSubviewToFront:_selectContentView];
    [self.view bringSubviewToFront:_agePickerView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [_introImage setUserInteractionEnabled:YES];
    [_introImage addGestureRecognizer:singleTap];
    

    _agePickerView.backgroundColor = [UIColor clearColor];
    _agePickerView.delegate = self;
    _agePickerView.dataSource = self;
    _agePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _agePickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    _agePickerView.textColor = [UIColor whiteColor];
    _agePickerView.highlightedTextColor = [UIColor whiteColor];
    _agePickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:28];
    _agePickerView.interitemSpacing = 20.0;
    _agePickerView.fisheyeFactor = 0.001;
    _agePickerView.pickerViewStyle = AKPickerViewStyle3D;
    _agePickerView.maskDisabled = false;
    [self.agePickerView reloadData];
  
    _bothPickerView.backgroundColor = [UIColor clearColor];
    _bothPickerView.delegate = self;
    _bothPickerView.dataSource = self;
    _bothPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _bothPickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    _bothPickerView.textColor = [UIColor whiteColor];
    _bothPickerView.highlightedTextColor = [UIColor whiteColor];
    _bothPickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:28];
    _bothPickerView.interitemSpacing = 20.0;
    _bothPickerView.fisheyeFactor = 0.001;
    _bothPickerView.pickerViewStyle = AKPickerViewStyle3D;
    _bothPickerView.maskDisabled = false;
    [_bothPickerView reloadData];
    
    _timesPickerView.backgroundColor = [UIColor clearColor];
    _timesPickerView.delegate = self;
    _timesPickerView.dataSource = self;
    _timesPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _timesPickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    _timesPickerView.textColor = [UIColor whiteColor];
    _timesPickerView.highlightedTextColor = [UIColor whiteColor];
    _timesPickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:28];
    _timesPickerView.interitemSpacing = 20.0;
    _timesPickerView.fisheyeFactor = 0.001;
    _timesPickerView.pickerViewStyle = AKPickerViewStyle3D;
    _timesPickerView.maskDisabled = false;
    [_timesPickerView reloadData];
    
    _likePickerView.backgroundColor = [UIColor clearColor];
    _likePickerView.delegate = self;
    _likePickerView.dataSource = self;
    _likePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _likePickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    _likePickerView.textColor = [UIColor whiteColor];
    _likePickerView.highlightedTextColor = [UIColor whiteColor];
    _likePickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:28];
    _likePickerView.interitemSpacing = 20.0;
    _likePickerView.fisheyeFactor = 0.001;
    _likePickerView.pickerViewStyle = AKPickerViewStyle3D;
    _likePickerView.maskDisabled = false;
    [_likePickerView reloadData];
    
    _agearr = [NSArray arrayWithObjects:
               @"1982",
               @"1983",
               @"1984",
               @"1985",
               @"1986",nil];
    
    _birtharr = [NSArray arrayWithObjects:
                @"上海",
                @"浙江",
                @"江苏",
                @"北京",
                @"广州",nil];
    _timesarr = [NSArray arrayWithObjects:
                @"1",
                @"2",
                @"3",
                @"4",
                @"5",nil];
    
    _likearr = [NSArray arrayWithObjects:
               @"很关注",
               @"非常关注",
               @"特别关注",
               @"一般关注",
               @"不了解",nil];
    [self removeOtherView];
    
    [_manIV setHidden:YES];
    [_womanIV setHidden:YES];
    
    [_womanBtn setHidden:NO];
    [_manBtn setHidden:NO];
    

    _gender=@"1";
    _origin=@"上海";
    _ages=@"1982";
    _comeTimes=@"1";
    _interest=@"很关注";
    
}

//-(void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;//打开顶部Tab
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
//
//}

#pragma mark - CNPPopupController Delegate
- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Popup controller presented.");
}

-(void)tapDetected{//部分隐藏图片的点击
    [self showPopupWithStyle:CNPPopupStyleActionSheet];
}

-(void)tapDetectedPop{//弹出图片的点击
    NSLog(@"Image click");
    [self.popupController dismissPopupControllerAnimated:YES];
}

#pragma mark 跳过按钮

- (IBAction)skipBtn:(id)sender {
    
    //提交网络请求
    NSString *mac = [QyUtils getGenerateMAC];
    NSLog(@"request paramter userId=%@ mac=%@ origin=%@ age=%@ gender=%@ interest=%@",@"",mac,_origin,_ages,_gender,_interest);
    DataRequest *request = [DataManager accountsNaire:@"" mac:mac origin:_origin age:_ages gender:_gender interest:_interest callback:^(BOOL registed, BOOL success) {
        //
        //NSLog(@"accountsNaire == %@",success);
        
    }];
    [request startSynchronous];
    
    
    if([@"Y" isEqualToString:_needBack]){
        NSLog(@"skipBtn...");
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    //[self showPopupWithStyle:CNPPopupStyleActionSheet];
}



- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    

    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"survey_intro"]];
    imageView.frame = CGRectMake(0 ,0, 350, 586);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedPop)];
    singleTap.numberOfTapsRequired = 1;
    [imageView setUserInteractionEnabled:YES];
    [imageView addGestureRecognizer:singleTap];
    
    //imageView.backgroundColor = [UIColor redColor];
    
//  self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, imageView, lineTwoLabel, customView, button]];
    self.popupController = [[CNPPopupController alloc] initWithContents:@[imageView]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    //self.popupController.theme.backgroundColor = [QyUtils colorWithRed:25 green:62 blue:106];
    self.popupController.theme.backgroundColor = [UIColor clearColor];
    self.popupController.theme.contentVerticalPadding = 0;
    //self.popupController.theme.popupContentInsets = UIEdgeInsetsMake(0,0,ScreenWitdh,400);
    //NSLog(@"size=%f,%f,%f,%f",self.popupController.theme.popupContentInsets.left,self.popupController.theme.popupContentInsets.top,self.popupController.theme.popupContentInsets.right,self.popupController.theme.popupContentInsets.bottom);
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
}


- (void)dealloc {
    
    [_efViewController.view removeFromSuperview];
    [_efViewController removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_textOfMykjg endEditing:YES];
}

//看点击的是那个按钮
- (void)didTappedEF:(NSInteger)index{
    //第几次来1004 籍贯1003 关注度 1002 年龄1001 性别1000
    NSLog(@"EFAnimationViewController item = %ld",(long)index);
    if(index == 1000){
        [self removeOtherView];
        [_womanBtn setHidden:NO];
        [_manBtn setHidden:NO];
    }
    else if(index == 1001){
        [self removeOtherView];
        //[self.selectContentView addSubview:_agePickerView];
        [_agePickerView setHidden:NO];
        
    }
    else if(index == 1002){
        [self removeOtherView];
        [_likePickerView setHidden:NO];
    }
    else if(index == 1003){
        [self removeOtherView];
        [_bothPickerView setHidden:NO];
    }
    else if(index == 1004){
        [self removeOtherView];
        [_timesPickerView setHidden:NO];
    }
}


-(void)removeOtherView{
    for (UIView *view in self.selectContentView.subviews) {
            //[view removeFromSuperview];
        [view setHidden:YES];
    }
}

-(NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView{
    if(pickerView == _agePickerView){
        return _agearr.count;
    }
    else if(pickerView == _likePickerView){
        return _likearr.count;
    }
    else if(pickerView == _bothPickerView){
        return _birtharr.count;
    }
    else if(pickerView == _timesPickerView){
        return _timesarr.count;
    }
    return 0;
}

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item{
    if(pickerView == _agePickerView){
        return _agearr[item];
    }
    else if(pickerView == _likePickerView){
        return _likearr[item];
    }
    else if(pickerView == _bothPickerView){
        return _birtharr[item];
    }
    else if(pickerView == _timesPickerView){
        return _timesarr[item];
    }
    return nil;
}

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item{
    
    //NSLog(@"select item =%d",item);
    
    if(pickerView == _agePickerView){
        _ages = _agearr[item];
    }
    else if(pickerView == _likePickerView){
        _interest= _likearr[item];
    }
    else if(pickerView == _bothPickerView){
        _origin= _birtharr[item];
    }
    else if(pickerView == _timesPickerView){
        _comeTimes = _timesarr[item];
    }

}

#pragma mark - 男女的两个按钮
- (IBAction)manBtnClick:(id)sender {
    NSLog(@"manBtnClick");
    _gender = @"0";
    [_manBtn setBackgroundImage:[UIImage imageNamed:@"man_survey"] forState:UIControlStateNormal];
    [_womanBtn setBackgroundImage:[UIImage imageNamed:@"woman_survey_sel"] forState:UIControlStateNormal];
    
}
- (IBAction)womanBtnClick:(id)sender {
     NSLog(@"womanBtnClick");
    _gender = @"1";
    [_womanBtn setBackgroundImage:[UIImage imageNamed:@"woman_survey"] forState:UIControlStateNormal];
    [_manBtn setBackgroundImage:[UIImage imageNamed:@"man_survey_sel"] forState:UIControlStateNormal];
}

@end

