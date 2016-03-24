//
//  PlayerVC.m
//  ShScience
//
//  Created by qiya on 16/1/31第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "PlayerVC.h"
#import "QyUtils.h"
#import "PBJVideoPlayer.h"

@interface PlayerVC () <GUIPlayerViewDelegate>

@end

@implementation PlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
//    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWitdh, self.view.frame.size.height)];
    [self.view addSubview:_contentView];
    NSString *str = @"";
    if(_titleName){
        str = _titleName;
    }
    [self setupNavBtnWithTitleNoHidden:@""];
    _nameLabel.text = str;
    //播放器设置
    CGRect rect = CGRectMake(10, 150, ScreenWitdh-20, ScreenWitdh*9/16);
    _guiPlayerView = [[GUIPlayerView alloc]initWithFrame:rect];
    
    NSString *urlString = @"http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4";
    if(_videoUrlStr != nil){
        urlString = _videoUrlStr;
    }
    NSURL *URL = [NSURL URLWithString:urlString];
//    NSURL *URL = [NSURL URLWithString:@"http://download.wavetlan.com/SVV/Media/HTTP/H264/Talkinghead_Media/H264_test1_Talkinghead_mp4_480x360.mp4"];
    
    _guiPlayerView.delegate = self;
    [_guiPlayerView setVideoURL:URL];
    
    
    [self.view addSubview:_guiPlayerView];
    
//    PBJVideoPlayerController *videoPlayerController = [[PBJVideoPlayerController alloc] init];
//    videoPlayerController.delegate = self;
//    videoPlayerController.view.frame = CGRectMake(0, 100, ScreenWitdh, ScreenWitdh*9/16);
//    
//    videoPlayerController.videoPath = @"http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4";
//
//    // present
//    [self addChildViewController:videoPlayerController];
//    [self.view addSubview:videoPlayerController.view];
//    [videoPlayerController didMoveToParentViewController:self];

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

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    //导航栏设置为透明色
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    
//}

#pragma mark - 按钮和appear相关
- (void)Back_btn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [_guiPlayerView stop];
    [_guiPlayerView clean];
}

- (IBAction)playerBtnClick:(id)sender {
    
    [_guiPlayerView prepareAndPlayAutomatically:YES];
    //[_guiPlayerView play];
}

#pragma mark - GUI Player View Delegate Methods

//- (void)playerWillEnterFullscreen {
//    [[self navigationController] setNavigationBarHidden:YES];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//}
//
//- (void)playerWillLeaveFullscreen {
//    [[self navigationController] setNavigationBarHidden:NO];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//}

//- (void)playerDidEndPlaying {
//    [copyrightLabel setHidden:YES];
//    
//    [playerView clean];
//    
//    [addPlayerButton setEnabled:YES];
//    [removePlayerButton setEnabled:NO];
//}

- (void)playerFailedToPlayToEnd {
    NSLog(@"Error: could not play video");
    //[playerView clean];
}


@end
