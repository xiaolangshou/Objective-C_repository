//
//  ViewController.m
//  AVPlayerVCDemo
//
//  Created by Thomas Lau on 2020/3/25.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property(strong, nonatomic) AVPlayerViewController *playerVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.playerVC.player play];
}

- (void)setupView {
    NSString *urlStr = @"https://v.cdn.vine.co/r/videos/AA3C120C521177175800441692160_38f2cbd1ffb.1.5.13763579289575020226.mp4";
    NSURL *remoteURL = [NSURL URLWithString: urlStr];
    AVPlayer *player = [AVPlayer playerWithURL: remoteURL];
    
    self.playerVC = [[AVPlayerViewController alloc] init];
    self.playerVC.player = player;
    self.playerVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 9 / 16);
    [self.view addSubview:self.playerVC.view];
}


@end
