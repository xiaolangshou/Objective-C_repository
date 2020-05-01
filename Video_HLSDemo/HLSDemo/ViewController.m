//
//  ViewController.m
//  HLSDemo
//
//  Created by Thomas Lau on 2020/3/25.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializePlayer];
}

- (void)initializePlayer {
    
    NSURL *playFilePathURL = [NSURL URLWithString:@"http://169.254.252.249:8080/?action=stream"];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:playFilePathURL];
    
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.view.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:self.playerLayer];
    
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:{
                [self.player play];
                break;
            }
            case AVPlayerStatusFailed:{//视频加载失败，点击重新加载
                break;
            }
            case AVPlayerStatusUnknown:{
                NSLog(@"加载遇到未知问题:AVPlayerStatusUnknown");
                break;
            }
            default:
                break;
        }
    }
}

@end
