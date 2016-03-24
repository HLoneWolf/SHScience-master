//
//  UploadPhotoVC.m
//  ShScience
//
//  Created by qiya on 16/2/23第9周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "UploadPhotoVC.h"
#import "QyUtils.h"
#import "CRMediaPickerController.h"
#import "UINavigationBar+Awesome.h"

@interface UploadPhotoVC ()<CRMediaPickerControllerDelegate>

@property (nonatomic, strong) CRMediaPickerController *mediaPickerController;


@end

@implementation UploadPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _photoCotent.placeholder = @"请输入正文";
    _photoCotent.placeholderTextColor = [UIColor lightGrayColor];
    
    self.mediaPickerController = [[CRMediaPickerController alloc] init];
    self.mediaPickerController.delegate = self;
    self.mediaPickerController.mediaType = CRMediaPickerControllerMediaTypeImage;
    self.mediaPickerController.sourceType = CRMediaPickerControllerSourceTypeCamera;
    self.mediaPickerController.allowsEditing = YES;
    //self.mediaPickerController.cameraDevice = (UIImagePickerControllerCameraDevice) self.deviceCameraSelected;
    [self.mediaPickerController show];
    
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


#pragma mark - setup导航按钮

-(void) setupNavBtn {
    self.navigationController.navigationBarHidden = NO;//打开顶部Tab
    
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];//导航字体颜色
    
    UIImage* image3 = [UIImage imageNamed:@"map_louceng_btn"];
    CGRect frameimg = CGRectMake(ScreenWitdh-15,5, 25,25);
    
    UIButton *loucengButton = [[UIButton alloc] initWithFrame:frameimg];
    [loucengButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [loucengButton addTarget:self action:@selector(louceng_btn:)
            forControlEvents:UIControlEventTouchUpInside];
    [loucengButton setShowsTouchWhenHighlighted:YES];
    
    
    UIImage* image4 = [UIImage imageNamed:@"map_louceng_back"];
    CGRect frameimg2 = CGRectMake(15,5, 25,25);
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg2];
    [backButton setBackgroundImage:image4 forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(Back_btn:)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setShowsTouchWhenHighlighted:YES];
    
    //左右两个按钮
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:loucengButton];
        self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *backBtttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBtttonItem;
    
    //设置标题及颜色
    self.navigationItem.title=@"随手拍";
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //导航颜色及背景颜色
    [self.navigationController.navigationBar setBackgroundColor:RGB(17, 59, 121)];
    [self.view setBackgroundColor:RGB(17, 59, 121)];
    
    
 
}

#pragma mark - CPDMediaPickerControllerDelegate

- (void)CRMediaPickerController:(CRMediaPickerController *)mediaPickerController didFinishPickingAsset:(ALAsset *)asset error:(NSError *)error
{
    if (!error) {
        
        if (asset) {
            
            if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                ALAssetRepresentation *representation = asset.defaultRepresentation;
                UIImage *image = [UIImage imageWithCGImage:representation.fullScreenImage];
                self.lastPhoto.image = image;
            }
            //didn't need media
            
        } else {
            NSLog(@"No media selected");
        }
        
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)CRMediaPickerControllerDidCancel:(CRMediaPickerController *)mediaPickerController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


#pragma mark - 按钮和appear相关
- (void)Back_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//楼层按钮
- (void)louceng_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_photoCotent endEditing:YES];
    [_photoTitle endEditing:YES];

}

#pragma mark - appear disapper
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavBtn];
    //导航栏设置为透明色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;//隐藏顶部Tab
    [self.navigationController.navigationBar lt_reset];
}
@end
