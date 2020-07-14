//
//  ViewController.m
//  AudioDemo
//
//  Created by Thomas Lau on 2020/7/14.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%s", __FUNCTION__);
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"bubbs.wav" withExtension:nil];
     
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    AudioServicesPlayAlertSound(soundID);
}
@end
