//
//  ViewController.m
//  OpenGLDemo2
//
//  Created by Thomas Lau on 2020/4/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getNativeVideo];
}

- (void)getNativeVideo {

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"111" withExtension:@"mp4"];
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = CGRectMake(0, 60, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width);
    playerLayer.borderColor = [UIColor grayColor].CGColor;
    playerLayer.borderWidth = 1.0;
    [self.view.layer addSublayer:playerLayer];
    // [playerLayer.player play];
}



#pragma mark -- delegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    AVPlayerItem *item = object;
    //判断监听对象的状态
    if ([keyPath isEqualToString:@"status"]) {
    
        if (item.status == AVPlayerItemStatusReadyToPlay) {//准备好的
            NSLog(@"AVPlayerItemStatusReadyToPlay");
        } else if(item.status ==AVPlayerItemStatusUnknown){//未知的状态
           NSLog(@"AVPlayerItemStatusUnknown");
        }else if(item.status ==AVPlayerItemStatusFailed){//有错误的
            NSLog(@"AVPlayerItemStatusFailed");
        }
        
    }
    
}

@end
