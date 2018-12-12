//
//  TestPlayViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/6/11.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TestPlayViewController.h"

@interface TestPlayViewController ()

@end

@implementation TestPlayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setupPlayer];
    self.url = [NSURL URLWithString:@"http://7xk8ky.com1.z0.glb.clouddn.com/9tdiwrundefined.mp4"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUrl:(NSURL *)url {
    if ([_url.absoluteString isEqualToString:url.absoluteString]) return;
    _url = url;
    
    if (self.player) {
        [self.player stop];
        [self setupPlayer];
        [self.player play];
    }
}

- (void) setupPlayer {
    
    NSLog(@"播放地址: %@", _url.absoluteString);
    
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    PLPlayFormat format = kPLPLAY_FORMAT_UnKnown;
    NSString *urlString = _url.absoluteString.lowercaseString;
    if ([urlString containsString:@"mp4"]) {
        format = kPLPLAY_FORMAT_MP4;
    } else if ([urlString hasPrefix:@"rtmp:"]) {
        format = kPLPLAY_FORMAT_FLV;
    } else if ([urlString containsString:@".mp3"]) {
        format = kPLPLAY_FORMAT_MP3;
    } else if ([urlString containsString:@".m3u8"]) {
        format = kPLPLAY_FORMAT_M3U8;
        
    }
    [option setOptionValue:@(format) forKey:PLPlayerOptionKeyVideoPreferFormat];
    [option setOptionValue:@(kPLLogNone) forKey:PLPlayerOptionKeyLogLevel];
    
    self.player = [PLPlayer playerWithURL:_url option:option];
    [self.view insertSubview:self.player.playerView atIndex:0];
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.player.delegateQueue = dispatch_get_main_queue();
    self.player.playerView.contentMode = UIViewContentModeScaleAspectFit;
    self.player.delegate = self;
    self.player.loopPlay = YES;
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.player stop];
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![self.player isPlaying]) {
        [self.player play];
    }
}

- (void)singleTapAction:(UIGestureRecognizer *)gesture {
    if ([self.player isPlaying]) {
        [self.player pause];
    } else {
        [self.player resume];
    }
}

- (void)clickPlayButton:(UIButton *)button {
    [self.player resume];
}


@end
