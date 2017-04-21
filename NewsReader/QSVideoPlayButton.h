//
//  QSVideoPlayButton.h
//  TTMM
//
//  Created by xue on 16/11/22.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QSVideoPlayButton : UIButton

@property (nonatomic,strong) AVPlayerViewController * playerController;
@property (nonatomic,strong) UIButton * closeButton;
@property (nonatomic,assign) BOOL isPlay;

- (void)playURL:(NSURL *)url;

@end
