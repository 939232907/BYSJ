//
//  QSVideoPlayButton.m
//  TTMM
//
//  Created by xue on 16/11/22.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "QSVideoPlayButton.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Masonry.h"
@interface QSVideoPlayButton()<AVPlayerViewControllerDelegate>

@property (nonatomic,strong) CADisplayLink * displayLink;

@end

@implementation QSVideoPlayButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.playerController = [[AVPlayerViewController alloc] init];
        [self addSubview:self.playerController.view];
        self.playerController.view.frame = self.bounds;
        self.playerController.delegate = self;
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkLink)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [closeButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:closeButton];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-10);
            make.top.equalTo(@10);
            make.width.equalTo(@40);
            make.height.equalTo(@20);
        }];
        self.closeButton = closeButton;
    }
    return self;
}

- (void)displayLinkLink {
    if (self.playerController.player.rate == 0) {
        self.isPlay = false;
    }else {
        self.isPlay = true;
    }
}

- (void)playURL:(NSURL *)url {
    [self.playerController.player pause];
    self.playerController.player = [AVPlayer playerWithURL:url];
    [self.playerController.player play];
}

- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s",__FUNCTION__);
}

- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s",__FUNCTION__);
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s",__FUNCTION__);
    
}

- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s",__FUNCTION__);
}

- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s",__FUNCTION__);
    return true;
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler {
    NSLog(@"%s",__FUNCTION__);
}


@end
