//
//  ZhiHuiTreeVC.m
//  ShScience
//
//  Created by qiya on 16/2/24第9周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "ZhiHuiTreeVC.h"
#import "MapArea.h"
#import "ZhiHuiDetailVC.h"
#import "StoryboardHelper.h"

@interface ZhiHuiTreeVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *mainImageView;

@property NSMutableArray *zoneAreArray;

@end

@implementation ZhiHuiTreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //初始化数组
    _zoneAreArray = [[NSMutableArray alloc]init];
    
    [self setupNavBtnWithTitle:@"科技智慧树"];
    
    // Creates a view Dictionary to be used in constraints
    NSDictionary *viewsDictionary;
    
    // Creates an image view with a test image
    self.mainImageView = [[UIImageView alloc] init];
    UIImage *turnImage = [UIImage imageNamed:@"zhihuiTree_big"];
    [self.mainImageView setImage:turnImage];
    
    // Add the imageview to the scrollview
    [self.mainScrollView addSubview:self.mainImageView];
    
    // Sets the following flag so that auto layout is used correctly
    self.mainScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Sets the scrollview delegate as self
    self.mainScrollView.delegate = self;
    
    // Creates references to the views
    // UIScrollView *scrollView = self.mainScrollView;
    
    // Sets the image frame as the image size
    self.mainImageView.frame = CGRectMake(0, 0, turnImage.size.width, turnImage.size.height);
    
    // Tell the scroll view the size of the contents
    self.mainScrollView.contentSize = turnImage.size;
    [self.mainScrollView setShowsHorizontalScrollIndicator:NO];
    [self.mainScrollView setShowsVerticalScrollIndicator:NO];
    
//    // Set the constraints for the scroll view
//    viewsDictionary = NSDictionaryOfVariableBindings(scrollView);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:0 views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]-(50)-|" options:0 metrics: 0 views:viewsDictionary]];
    
    // Add doubleTap recognizer to the scrollView
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.mainScrollView addGestureRecognizer:doubleTapRecognizer];
    
    // Add two finger recognizer to the scrollView
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.mainScrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    //add by dsy
    _mainImageView.userInteractionEnabled = YES;
    _mainScrollView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.mainScrollView addGestureRecognizer:singleTap];
    [self.mainScrollView setUserInteractionEnabled:YES];

    [[UIColor redColor] setStroke];
    
    //添加可点区域
    [self addZoneAtImage];
    
}

//在图片上添加选中区域
-(void) addZoneAtImage{
    
    //开始图像绘图
    UIGraphicsBeginImageContext(self.mainImageView.bounds.size);
    
    MapArea* _mapArea= [[MapArea alloc]initWithCoordinate:@"240,270,300,270,320,320,300,370,240,370,215,320"];
    [_mapArea.mapArea stroke];
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.mainImageView addSubview:imgView];
    [_zoneAreArray addObject: _mapArea];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Setup the scrollview scales on viewWillAppear
    [self setupScales];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupScales {
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.mainScrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.mainScrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.mainScrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.mainScrollView.minimumZoomScale = minScale;
    self.mainScrollView.maximumZoomScale = 10.0f;
    self.mainScrollView.zoomScale = 1.2;
    
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    // This method centers the scroll view contents also used on did zoom
    CGSize boundsSize = self.mainScrollView.bounds.size;
    CGRect contentsFrame = self.mainImageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.mainImageView.frame = contentsFrame;
}

#pragma mark -
#pragma mark - ScrollView Delegate methods
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.mainImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

#pragma mark -
#pragma mark - ScrollView gesture methods
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.mainImageView];
    
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.mainScrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.mainScrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = self.mainScrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.mainScrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.mainScrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.mainScrollView.minimumZoomScale);
    [self.mainScrollView setZoomScale:newZoomScale animated:YES];
}

#pragma mark -  单击图片中的位置
- (void)singleTapped:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"%@", [gestureRecognizer view]);
    CGPoint touchPoint = [gestureRecognizer locationInView: _mainImageView];
    NSValue *touchValue = [NSValue valueWithCGPoint:touchPoint];
    
    NSLog(@"imageView Click value %@",touchValue);
    
    for(int i = 0;i<[_zoneAreArray count];i++){
        MapArea *map = [_zoneAreArray objectAtIndex:i];
        if([map isAreaSelected:touchPoint]){
            NSLog(@"click area zone index is %i",i);
            ZhiHuiDetailVC  *vc = (ZhiHuiDetailVC *)[StoryboardHelper getVCByVCName:@"zhiHuiDetailVC"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}


#pragma mark -
#pragma mark - Rotation

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // When the orientation is changed the contentSize is reset when the frame changes. Setting this back to the relevant image size
    self.mainScrollView.contentSize = self.mainImageView.image.size;
    // Reset the scales depending on the change of values
    [self setupScales];
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
